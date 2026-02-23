-- persian-latex-beamer-filter.lua
-- Filter for converting Persian markdown to LaTeX Beamer slides

-- Track if we're currently inside a frame
local in_frame = false
local current_section = nil
local current_subsection = nil

-- Frame options: fragile is required for minted/codebox environments
local frame_options = "[fragile,allowframebreaks]"

-- Process code blocks to custom codebox environment
function CodeBlock(el)
  local lang = el.classes[1] or "text"
  return pandoc.RawBlock('latex', "\\begin{codebox}{" .. lang .. "}\n" .. el.text .. "\n\\end{codebox}")
end

-- Process headers to appropriate LaTeX commands and frames
function Header(el)
  local level = el.level
  local title = pandoc.utils.stringify(el.content)

  if level == 1 then
    -- Level 1: Section (close any open frame first)
    local prefix = ""
    if in_frame then
      prefix = "\\end{frame}\n\n"
      in_frame = false
    end
    current_section = title
    return pandoc.RawBlock('latex', prefix .. '\\section{' .. title .. '}')

  elseif level == 2 then
    -- Level 2: Subsection + new frame (close any open frame first)
    local prefix = ""
    if in_frame then
      prefix = "\\end{frame}\n\n"
    end
    current_subsection = title
    in_frame = true
    return pandoc.RawBlock('latex', prefix .. '\\subsection{' .. title .. '}\n\\begin{frame}' .. frame_options .. '{' .. title .. '}')

  elseif level == 3 then
    -- Level 3: New frame with title (close any open frame first)
    local prefix = ""
    if in_frame then
      prefix = "\\end{frame}\n\n"
    end
    in_frame = true
    return pandoc.RawBlock('latex', prefix .. '\\begin{frame}' .. frame_options .. '{' .. title .. '}')

  else
    -- Level 4+: Just bold text within frame
    return pandoc.RawBlock('latex', '\n\\textbf{' .. title .. '}\n\n')
  end
end

-- Process paragraphs to handle images
function Para(el)
  if #el.content == 1 and el.content[1].t == "Image" then
    local img = el.content[1]
    local src = img.src or ""

    local latex = "\n\\begin{figure}\n\\centering\n\\includegraphics[width=0.7\\textwidth,height=0.6\\textheight,keepaspectratio]{" .. src .. "}\n\\end{figure}\n"

    return pandoc.RawBlock('latex', latex)
  end

  return nil
end

-- Process inline code to \texttt{}
function Code(el)
  local text = el.text:gsub("\\", "\\textbackslash "):gsub("([#$%%&_{}])", "\\%1")
  return pandoc.RawInline('latex', '\\texttt{' .. text .. '}')
end

-- Process links to \href{}
function Link(el)
  local url = (el.target or ""):gsub("([#$%%&_])", "\\%1")
  local text = pandoc.utils.stringify(el.content)
  return pandoc.RawInline('latex', '\\href{' .. url .. '}{' .. text .. '}')
end

-- Process math to preserve it
function Math(el)
  if el.mathtype == "InlineMath" then
    return pandoc.RawInline('latex', '$' .. el.text .. '$')
  else
    return pandoc.RawBlock('latex', '$$' .. el.text .. '$$')
  end
end

-- Helper function to convert cell contents to LaTeX
local function cell_to_latex(cell_contents)
  local latex = pandoc.write(pandoc.Pandoc(cell_contents), 'latex')
  latex = latex:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n+", " ")
  return latex
end

-- Process tables to simple tabular format
function Table(el)
  local latex = "\n\\begin{table}\n\\centering\n\\setLTR\n\\footnotesize\n\\begin{tabular}{"

  -- Determine column alignment
  local ncols = #el.colspecs
  for i = 1, ncols do
    latex = latex .. "l"
  end
  latex = latex .. "}\n\\hline\n"

  -- Process header if exists
  if el.head and el.head.rows and #el.head.rows > 0 then
    for _, row in ipairs(el.head.rows) do
      local cells = {}
      for _, cell in ipairs(row.cells) do
        local cell_content = cell_to_latex(cell.contents)
        table.insert(cells, "\\textbf{" .. cell_content .. "}")
      end
      latex = latex .. table.concat(cells, " & ") .. " \\\\\n"
    end
    latex = latex .. "\\hline\n"
  end

  -- Process body rows
  if el.bodies and #el.bodies > 0 then
    for _, body in ipairs(el.bodies) do
      for _, row in ipairs(body.body) do
        local cells = {}
        for _, cell in ipairs(row.cells) do
          local cell_content = cell_to_latex(cell.contents)
          table.insert(cells, cell_content)
        end
        latex = latex .. table.concat(cells, " & ") .. " \\\\\n"
      end
    end
  end

  latex = latex .. "\\hline\n\\end{tabular}\n\\end{table}\n"

  return pandoc.RawBlock('latex', latex)
end

-- Process lists to add proper spacing in frames
function BulletList(el)
  local items = {}
  for i, item in ipairs(el.content) do
    local item_content = pandoc.write(pandoc.Pandoc(item), 'latex')
    table.insert(items, "\\item " .. item_content)
  end

  return pandoc.RawBlock('latex', "\\begin{itemize}\n" .. table.concat(items, "\n") .. "\n\\end{itemize}")
end

function OrderedList(el)
  local items = {}
  for i, item in ipairs(el.content) do
    local item_content = pandoc.write(pandoc.Pandoc(item), 'latex')
    table.insert(items, "\\item " .. item_content)
  end

  return pandoc.RawBlock('latex', "\\begin{enumerate}\n" .. table.concat(items, "\n") .. "\n\\end{enumerate}")
end

-- Add a final frame closing at the end of document (only if one is open)
function Pandoc(doc)
  if in_frame then
    table.insert(doc.blocks, pandoc.RawBlock('latex', '\\end{frame}'))
    in_frame = false
  end
  return doc
end

-- Return all filters
return {
  { CodeBlock = CodeBlock },
  { Header = Header },
  { Para = Para },
  { Table = Table },
  { Math = Math },
  { Link = Link },
  { Code = Code },
  { BulletList = BulletList },
  { OrderedList = OrderedList },
  { Pandoc = Pandoc }
}
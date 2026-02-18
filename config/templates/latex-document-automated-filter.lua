-- persian-latex-filter.lua
-- Final comprehensive filter for Persian markdown to LaTeX conversion

-- Process code blocks to custom codebox environment
function CodeBlock(el)
  local lang = el.classes[1] or "text"
  return pandoc.RawBlock('latex', "\\begin{codebox}{" .. lang .. "}\n" .. el.text .. "\n\\end{codebox}")
end

-- Process headers to appropriate LaTeX commands
function Header(el)
  local commands = {[1] = "chapter", [2] = "section", [3] = "subsection", [4] = "subsubsection", [5] = "paragraph"}
  local cmd = commands[el.level] or "paragraph"
  return pandoc.RawBlock('latex', '\\' .. cmd .. '{' .. pandoc.utils.stringify(el.content) .. '}')
end

-- Process paragraphs to handle images (without captions)
function Para(el)
  if #el.content == 1 and el.content[1].t == "Image" then
    local img = el.content[1]
    local src = img.src or ""
    
    -- No caption/alt text as requested
    local latex = "\n\\begin{figure}[H]\n\\centering\n\\includegraphics[width=0.8\\textwidth]{" .. src .. "}\n\\end{figure}\n"
    
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
  -- Use pandoc.write to convert the cell contents to LaTeX
  local latex = pandoc.write(pandoc.Pandoc(cell_contents), 'latex')
  
  -- Remove extra newlines and trim whitespace
  latex = latex:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n+", " ")
  
  return latex
end

-- Process tables to simple tabular format with full conversion
function Table(el)
  local latex = "\n\\begin{table}[H]\n\\centering\n\\setLTR\n\\begin{tabular}{"
  
  -- Determine column alignment (all left-aligned 'l' for simplicity)
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

-- Return all filters
return {
  { CodeBlock = CodeBlock },
  { Header = Header },
  { Para = Para },
  { Table = Table },
  { Math = Math },
  { Link = Link },
  { Code = Code }
}
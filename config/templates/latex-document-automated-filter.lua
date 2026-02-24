-- persian-latex-filter.lua
-- Final comprehensive filter for Persian markdown to LaTeX conversion
-- Merges consecutive English words into a single \lr{} block,
-- converts headers to LaTeX sectioning commands without extra labels,
-- and handles images, tables, code, math, links as before.
-- Trailing spaces, a single trailing colon (:), or a Persian comma (،)
-- are moved outside \lr{}.

-- Helper: check if a string is English (ASCII only and contains at least one letter)
local function is_english_str(s)
  if not s:match("^[%z\1-\127]*$") then return false end -- contains non-ASCII
  return s:match("[A-Za-z]") ~= nil
end

-- Helper: check if a string is ASCII punctuation/digits (no letters)
local function is_ascii_nonletter(s)
  if not s:match("^[%z\1-\127]*$") then return false end
  return s:match("[A-Za-z]") == nil
end

-- Helper: test if a string ends with a given suffix (UTF-8 safe)
local function ends_with(str, suffix)
  return str:sub(-#suffix) == suffix
end

-- Merge consecutive English inlines into a single \lr{} block.
-- Trailing spaces, a single trailing colon (:), or a Persian comma (،)
-- are moved outside the block.
local function merge_english_inlines(inlines)
  local result = {}
  local i = 1
  while i <= #inlines do
    local el = inlines[i]
    -- Start of an English run?
    if el.t == "Str" and is_english_str(el.text) then
      local run_text = {el.text}
      local j = i + 1
      while j <= #inlines do
        local next_el = inlines[j]
        if next_el.t == "Space" then
          -- Include space tentatively; trailing spaces will be stripped later.
          table.insert(run_text, " ")
          j = j + 1
        elseif next_el.t == "Str" then
          if is_english_str(next_el.text) then
            table.insert(run_text, next_el.text)
            j = j + 1
          elseif is_ascii_nonletter(next_el.text) then
            -- Include ASCII punctuation only if it's followed by more English or space
            local k = j + 1
            local include_punct = false
            if k <= #inlines then
              local after = inlines[k]
              if after.t == "Space" or (after.t == "Str" and is_english_str(after.text)) then
                include_punct = true
              end
            end
            if include_punct then
              table.insert(run_text, next_el.text)
              j = j + 1
            else
              break
            end
          else
            break -- non-English (Persian) stops the run
          end
        else
          break -- not a Space or Str, stop run
        end
      end
      -- Combine the run into a single string
      local combined = table.concat(run_text, "")
      
      -- Extract trailing punctuation (colon or Persian comma) and spaces
      local content = combined
      local punct = ""
      local spaces = ""
      
      if ends_with(combined, "،") then
        punct = "،"
        local body = combined:sub(1, -3) -- remove the two‑byte comma
        -- capture trailing spaces from the body
        local _, nspaces = body:match("^(.-)(%s*)$")
        content = body:match("^(.-)%s*$") or body
        spaces = nspaces or ""
      elseif ends_with(combined, ":") then
        punct = ":"
        local body = combined:sub(1, -2) -- remove the colon
        local _, nspaces = body:match("^(.-)(%s*)$")
        content = body:match("^(.-)%s*$") or body
        spaces = nspaces or ""
      else
        -- no trailing punctuation, just capture trailing spaces
        local _, nspaces = combined:match("^(.-)(%s*)$")
        content = combined:match("^(.-)%s*$") or combined
        spaces = nspaces or ""
      end
      
      -- Escape LaTeX special characters in the content (not in punctuation or spaces)
      -- Use \textbackslash{} instead of \textbackslash␣ to avoid unwanted space
      local escaped = content:gsub("\\", "\\textbackslash{}"):gsub("([#$%%&_{}])", "\\%1")
      table.insert(result, pandoc.RawInline('latex', '\\lr{' .. escaped .. '}'))
      -- Add punctuation if present (outside \lr{})
      if punct ~= "" then
        table.insert(result, pandoc.Str(punct))
      end
      -- Add trailing spaces as separate Space elements (outside \lr{})
      for _ = 1, #spaces do
        table.insert(result, pandoc.Space())
      end
      i = j
    else
      -- Not a start, copy element as is
      table.insert(result, el)
      i = i + 1
    end
  end
  return result
end

-- Process headers: merge English, then convert to LaTeX sectioning command
function Header(el)
  -- First merge English inlines inside the header
  el.content = merge_english_inlines(el.content)

  -- Choose the appropriate LaTeX command based on level
  local commands = {[1] = "chapter", [2] = "section", [3] = "subsection",
                    [4] = "subsubsection", [5] = "paragraph"}
  local cmd = commands[el.level] or "paragraph"

  -- Convert the modified content to LaTeX (preserves formatting and our \lr{})
  local header_latex = pandoc.write(pandoc.Pandoc({pandoc.Plain(el.content)}), 'latex')
  -- Remove any trailing newline added by pandoc.write
  header_latex = header_latex:gsub("\n$", "")

  -- Return as raw LaTeX block
  return pandoc.RawBlock('latex', '\\' .. cmd .. '{' .. header_latex .. '}')
end

-- Apply merging to all other inline containers (but let Pandoc handle their output)
function Para(el)
  -- Handle image-only paragraphs separately
  if #el.content == 1 and el.content[1].t == "Image" then
    local img = el.content[1]
    local src = img.src or ""
    local latex = "\n\\begin{figure}[H]\n\\centering\n\\includegraphics[width=0.8\\textwidth]{" .. src .. "}\n\\end{figure}\n"
    return pandoc.RawBlock('latex', latex)
  end
  el.content = merge_english_inlines(el.content)
  return el
end

function Plain(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Strong(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Emph(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Underline(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Strikeout(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Superscript(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Subscript(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function SmallCaps(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Span(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Quoted(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Cite(el)
  el.content = merge_english_inlines(el.content)
  return el
end

function Link(el)
  el.content = merge_english_inlines(el.content)
  return el
end

-- Process code blocks to custom codebox environment
function CodeBlock(el)
  local lang = el.classes[1] or "text"
  return pandoc.RawBlock('latex', "\\begin{codebox}{" .. lang .. "}\n" .. el.text .. "\n\\end{codebox}")
end

-- Process inline code to \texttt{} and wrap in \lr{} if ASCII-only
function Code(el)
  -- Normalize smart quotes to straight quotes (using UTF-8 byte sequences)
  local text = el.text
  text = text:gsub("\226\128\152", "'"):gsub("\226\128\153", "'")  -- ' and '
  text = text:gsub("\226\128\156", '"'):gsub("\226\128\157", '"')  -- " and "
  
  -- Escape special LaTeX characters, but handle backslash specially for inline code
  text = text:gsub("\\", "\\textbackslash "):gsub("([#$%%&_{}])", "\\%1")
  local result = '\\texttt{' .. text .. '}'
  -- If the code contains only ASCII characters, wrap it in \lr{} to ensure LTR direction
  if el.text:match("^[%z\1-\127]*$") then
    result = '\\lr{' .. result .. '}'
  end
  return pandoc.RawInline('latex', result)
end

-- Process math to preserve it (no \lr{})
function Math(el)
  if el.mathtype == "InlineMath" then
    return pandoc.RawInline('latex', '$' .. el.text .. '$')
  else
    return pandoc.RawBlock('latex', '$$' .. el.text .. '$$')
  end
end

-- Process images (used in tables)
function Image(el)
  local src = el.src or ""
  return pandoc.RawInline('latex', '\\pandocbounded{\\includegraphics[width=0.45\\textwidth]{' .. src .. '}}')
end

-- Helper for table cells (converts cell content to LaTeX)
local function cell_to_latex(cell_contents)
  -- Note: This does not apply English merging inside tables.
  -- If needed, we could recursively process cell_contents here.
  local latex = pandoc.write(pandoc.Pandoc(cell_contents), 'latex')
  latex = latex:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n+", " ")
  latex = latex:gsub("\\includegraphics%[keepaspectratio%]", "\\includegraphics[width=0.45\\textwidth]")
  return latex
end

-- Process tables to simple tabular format
function Table(el)
  local latex = "\n\\begin{table}[H]\n\\centering\n\\setLTR\n\\begin{tabular}{"
  local ncols = #el.colspecs
  for i = 1, ncols do latex = latex .. "l" end
  latex = latex .. "}\n\\hline\n"

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
  { Plain = Plain },
  { Strong = Strong },
  { Emph = Emph },
  { Underline = Underline },
  { Strikeout = Strikeout },
  { Superscript = Superscript },
  { Subscript = Subscript },
  { SmallCaps = SmallCaps },
  { Span = Span },
  { Quoted = Quoted },
  { Cite = Cite },
  { Link = Link },
  { Table = Table },
  { Math = Math },
  { Code = Code },
  { Image = Image }
}
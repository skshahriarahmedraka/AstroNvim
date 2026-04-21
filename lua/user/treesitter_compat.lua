local M = {}

local html_script_type_languages = {
  importmap = "json",
  module = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

local markdown_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  ts = "typescript",
  uxn = "uxntal",
}

local function first_node(match, capture_id)
  local nodes = match[capture_id]

  if type(nodes) == "table" then return nodes[1] end

  return nodes
end

local function parser_from_markdown_info_string(alias)
  local filetype = vim.filetype.match { filename = "a." .. alias }
  return filetype or markdown_language_aliases[alias] or alias
end

local function get_node_text(node, source, metadata)
  return vim.treesitter.get_node_text(node, source, metadata and { metadata = metadata } or nil)
end

function M.apply()
  if vim.fn.has "nvim-0.12" ~= 1 then return end

  local ok, query = pcall(require, "vim.treesitter.query")
  if not ok then return end

  local opts = { force = true }

  query.add_directive("set-lang-from-mimetype!", function(match, _, source, pred, metadata)
    local node = first_node(match, pred[2])
    if not node then return end

    local type_attr_value = get_node_text(node, source)
    local configured = html_script_type_languages[type_attr_value]

    if configured then
      metadata["injection.language"] = configured
      return
    end

    local parts = vim.split(type_attr_value, "/", {})
    metadata["injection.language"] = parts[#parts]
  end, opts)

  query.add_directive("set-lang-from-info-string!", function(match, _, source, pred, metadata)
    local node = first_node(match, pred[2])
    if not node then return end

    local injection_alias = get_node_text(node, source):lower()
    metadata["injection.language"] = parser_from_markdown_info_string(injection_alias)
  end, opts)

  query.add_directive("downcase!", function(match, _, source, pred, metadata)
    local capture_id = pred[2]
    local node = first_node(match, capture_id)
    if not node then return end

    metadata[capture_id] = metadata[capture_id] or {}
    local text = get_node_text(node, source, metadata[capture_id]) or ""
    metadata[capture_id].text = text:lower()
  end, opts)

  query.add_predicate("nth?", function(match, _, _, pred)
    local node = first_node(match, pred[2])
    local n = tonumber(pred[3])

    if node and n and node:parent() and node:parent():named_child_count() > n then
      return node:parent():named_child(n) == node
    end

    return false
  end, opts)

  query.add_predicate("kind-eq?", function(match, _, _, pred)
    local node = first_node(match, pred[2])
    if not node then return true end

    return vim.tbl_contains({ unpack(pred, 3) }, node:type())
  end, opts)

  query.add_predicate("is?", function(match, _, source, pred)
    local node = first_node(match, pred[2])
    if not node then return true end

    local locals_ok, locals = pcall(require, "nvim-treesitter.locals")
    if not locals_ok then return false end

    local _, _, kind = locals.find_definition(node, source)
    return vim.tbl_contains({ unpack(pred, 3) }, kind)
  end, opts)
end

return M

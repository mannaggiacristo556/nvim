-- Neo-tree source for distant.nvim remote files
local renderer = require("neo-tree.ui.renderer")
local manager = require("neo-tree.sources.manager")
local events = require("neo-tree.events")
local utils = require("neo-tree.utils")

local M = {
  name = "distant",
  display_name = " 󰒍 Remote ",
}

-- Get file icon using nvim-web-devicons
local function get_icon(name, is_dir)
  if is_dir then
    return "", "NeoTreeDirectoryIcon"
  end
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local icon, hl = devicons.get_icon(name, nil, { default = true })
    return icon or "", hl or "NeoTreeFileIcon"
  end
  return "", "NeoTreeFileIcon"
end

-- Convert distant entries to neo-tree items format
local function create_item(entry)
  local full_path = entry.path
  local name = vim.fn.fnamemodify(full_path, ":t")
  local is_dir = entry.file_type == "dir"
  local icon, icon_hl = get_icon(name, is_dir)

  return {
    id = full_path,
    name = name,
    path = full_path,
    type = is_dir and "directory" or "file",
    loaded = not is_dir, -- files are always "loaded", dirs need expansion
    extra = {
      icon = { text = icon, highlight = icon_hl },
    },
  }
end

-- Fetch and display directory contents
local function get_items(state, parent_id, path_to_reveal, callback)
  local path = parent_id or state.path or "/home/celeste"
  state.path = state.path or path

  local ok, api = pcall(require, "distant.api")
  if not ok then
    vim.notify("distant.nvim not loaded", vim.log.levels.ERROR)
    if callback then callback() end
    return
  end

  if not api.is_ready() then
    vim.notify("No distant connection. Use <leader>Dl first.", vim.log.levels.WARN)
    if callback then callback() end
    return
  end

  api.read_dir({ path = path, depth = 1 }, function(err, payload)
    vim.schedule(function()
      if err then
        vim.notify("Distant error: " .. tostring(err), vim.log.levels.ERROR)
        if callback then callback() end
        return
      end

      local entries = payload and payload.entries or {}
      local items = {}

      for _, entry in ipairs(entries) do
        table.insert(items, create_item(entry))
      end

      -- Sort: directories first, then alphabetically
      table.sort(items, function(a, b)
        if a.type ~= b.type then
          return a.type == "directory"
        end
        return a.name:lower() < b.name:lower()
      end)

      -- Create root node
      local root = create_item({ path = path, file_type = "dir" })
      root.loaded = true
      root.children = items

      -- Render the tree
      if parent_id then
        -- Expanding a subdirectory
        local existing_node = state.tree and state.tree:get_node(parent_id)
        if existing_node then
          existing_node.loaded = true
          existing_node.children = items
          for _, child in ipairs(items) do
            child._parent_id = parent_id
          end
          renderer.show_nodes(items, state, parent_id)
        end
      else
        -- Initial render
        renderer.show_nodes({ root }, state)
      end

      if callback then callback() end
    end)
  end)
end

M.navigate = function(state, path, path_to_reveal, callback)
  state.path = path or state.path or "/home/celeste"
  get_items(state, nil, path_to_reveal, callback)
end

M.setup = function(config, global_config)
  -- Nothing special needed
end

M.default_config = {
  follow_current_file = { enabled = false },
}

-- For expanding directories
M.get_items = get_items

return M

-- Commands for neo-tree distant source
local renderer = require("neo-tree.ui.renderer")
local manager = require("neo-tree.sources.manager")
local utils = require("neo-tree.utils")
local source = require("neo-tree.sources.distant")

local M = {}

-- Open file or toggle directory
M.open = function(state)
  local node = state.tree:get_node()
  if not node then return end

  if node.type == "directory" then
    M.toggle_node(state)
  else
    -- Open remote file with distant
    vim.cmd("DistantOpen " .. node:get_id())
  end
end

-- Toggle directory expanded/collapsed
M.toggle_node = function(state)
  local node = state.tree:get_node()
  if not node then return end

  if node.type ~= "directory" then
    M.open(state)
    return
  end

  if node:is_expanded() then
    node:collapse()
    renderer.redraw(state)
  else
    if not node.loaded then
      source.get_items(state, node:get_id(), nil, function()
        node:expand()
        renderer.redraw(state)
      end)
    else
      node:expand()
      renderer.redraw(state)
    end
  end
end

-- Open in split
M.open_split = function(state)
  local node = state.tree:get_node()
  if not node or node.type == "directory" then return end
  vim.cmd("split")
  vim.cmd("DistantOpen " .. node:get_id())
end

-- Open in vsplit
M.open_vsplit = function(state)
  local node = state.tree:get_node()
  if not node or node.type == "directory" then return end
  vim.cmd("vsplit")
  vim.cmd("DistantOpen " .. node:get_id())
end

-- Refresh the tree
M.refresh = function(state)
  manager.refresh("distant")
end

-- Navigate up to parent directory
M.navigate_up = function(state)
  local path = state.path or "/home/celeste"
  local parent = vim.fn.fnamemodify(path:gsub("/$", ""), ":h")
  if parent and parent ~= "" and parent ~= path then
    manager.navigate(state, parent)
  end
end

-- Set root to current node
M.set_root = function(state)
  local node = state.tree:get_node()
  if not node then return end

  if node.type == "directory" then
    manager.navigate(state, node:get_id())
  else
    local parent = vim.fn.fnamemodify(node:get_id(), ":h")
    manager.navigate(state, parent)
  end
end

-- Close node or navigate to parent
M.close_node = function(state)
  local node = state.tree:get_node()
  if not node then return end

  if node.type == "directory" and node:is_expanded() then
    node:collapse()
    renderer.redraw(state)
  else
    -- Navigate to parent node
    local parent_id = vim.fn.fnamemodify(node:get_id():gsub("/$", ""), ":h")
    local parent_node = state.tree:get_node(parent_id)
    if parent_node then
      renderer.focus_node(state, parent_id)
    end
  end
end

-- Close the tree window
M.close_window = function(state)
  renderer.close(state)
end

-- Show help
M.show_help = function(state)
  manager.show_help(state, M)
end

return M

-- Custom components for distant source
local highlights = require("neo-tree.ui.highlights")
local common = require("neo-tree.sources.common.components")

local M = {}

M.icon = function(config, node, state)
  local icon = node.extra and node.extra.icon
  if icon then
    return {
      text = icon.text .. " ",
      highlight = icon.highlight,
    }
  end
  -- Fallback
  if node.type == "directory" then
    return { text = " ", highlight = "NeoTreeDirectoryIcon" }
  end
  return { text = " ", highlight = "NeoTreeFileIcon" }
end

M.name = function(config, node, state)
  local highlight = highlights.FILE_NAME
  if node.type == "directory" then
    highlight = highlights.DIRECTORY_NAME
  end
  return {
    text = node.name,
    highlight = highlight,
  }
end

-- Inherit other components from common
setmetatable(M, { __index = common })

return M

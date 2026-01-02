-- Google Calendar sync plugin (uses gcalcli)
return {
  dir = vim.fn.stdpath("config") .. "/lua/custom/gcal",
  name = "gcal",
  config = function()
    require("custom.gcal").setup({
      calendars = {
        personal = "vmfunc.lc@gmail.com",
        work = "celeste@dashcrystal.com",
      },
      vault_path = vim.fn.expand("~/vault"),
      folder_calendar_map = {
        ["work"] = "work",
        ["personal"] = "personal",
        ["daily"] = "personal",
      },
    })
  end,
}

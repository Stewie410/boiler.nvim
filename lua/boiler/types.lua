---@alias boiler.config.Picker "snacks"|"vim" support picker types

---@class boiler.Config
---@field picker? boiler.config.Picker picker preference
---@field paths? string[] paths to search for boilerplate templates

---@alias boiler.Cache table<string, string[]> available templates by filetype

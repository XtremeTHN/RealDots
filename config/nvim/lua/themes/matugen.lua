local lighten = require("color_utilities").change_hex_lightness

local M = {}

M.background = '#191113'
M.foreground = '#efdee0'
M.cursor = '#efdee0'
M.color00 = '#191113'
M.color01 = lighten('#514346', 0)
M.color02 = '#e4bdc4'
M.color03 = lighten('#9e8c8f', 0)
M.color04 = lighten('#d6c2c5', 0)
M.color05 = '#efdee0'
M.color06 = lighten('#efdee0', 0)
M.color07 = '#191113'
M.color08 = lighten('#ffb4ab', -10)
M.color09 = '#edbe92'
M.color10 = '#ffb1c3'
M.color11 = '#ffdcbe'
M.color12 = '#ffb1c3'
M.color13 = lighten('#713344', 20)
M.color14 = '#ffd9e0'
M.color15 = '#efdee0'

return M

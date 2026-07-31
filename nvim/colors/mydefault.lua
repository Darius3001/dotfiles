-- ~/.config/nvim/colors/mydefault.lua

vim.o.background = "dark"
vim.o.termguicolors = true

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "mydefault"

-- Neovim's built-in default palette.
-- These correspond to the NvimDark* and NvimLight* named colors.
local c = {
  -- Dark variants
  dark_blue    = "#004c73",
  dark_cyan    = "#007373",
  dark_green   = "#005523",
  dark_grey1   = "#07080d",
  dark_grey2   = "#14161b",
  dark_grey3   = "#2c2e33",
  dark_grey4   = "#4f5258",
  dark_magenta = "#470045",
  dark_red     = "#590008",
  dark_yellow  = "#6b5300",

  -- Light variants
  light_blue    = "#a6dbff",
  light_cyan    = "#8cf8f7",
  light_green   = "#b3f6c0",
  light_grey1   = "#eef1f8",
  light_grey2   = "#e0e2ea",
  light_grey3   = "#c4c6cd",
  light_grey4   = "#9b9ea4",
  light_magenta = "#ffcaff",
  light_red     = "#ffc0b9",
  light_yellow  = "#fce094",
}

local set = vim.api.nvim_set_hl

local function hl(group, options)
  set(0, group, options)
end

local function link(group, target)
  set(0, group, { link = target })
end

-- ---------------------------------------------------------------------------
-- Editor UI
-- ---------------------------------------------------------------------------

hl("Normal", {
  fg = c.light_grey2,
  bg = c.dark_grey2,
})

hl("NormalNC", {
  fg = c.light_grey2,
  bg = c.dark_grey2,
})

hl("NormalFloat", {
  fg = c.light_grey2,
  bg = c.dark_grey1,
})

hl("FloatBorder", {
  fg = c.dark_grey4,
  bg = c.dark_grey1,
})

hl("Cursor", {
  fg = c.dark_grey2,
  bg = c.light_grey2,
})

hl("CursorLine", {
  bg = c.dark_grey3,
})

hl("CursorColumn", {
  bg = c.dark_grey3,
})

hl("ColorColumn", {
  bg = c.dark_grey3,
})

hl("LineNr", {
  fg = c.dark_grey4,
})

hl("CursorLineNr", {
  fg = c.light_grey2,
  bold = true,
})

hl("SignColumn", {
  fg = c.dark_grey4,
  bg = c.dark_grey2,
})

hl("FoldColumn", {
  fg = c.dark_grey4,
  bg = c.dark_grey2,
})

hl("Folded", {
  fg = c.light_grey4,
  bg = c.dark_grey1,
})

hl("Visual", {
  bg = c.dark_grey4,
})

hl("Search", {
  fg = c.light_grey1,
  bg = c.dark_yellow,
})

hl("IncSearch", {
  fg = c.dark_grey1,
  bg = c.light_yellow,
})

link("CurSearch", "IncSearch")

hl("MatchParen", {
  bg = c.dark_grey4,
  bold = true,
})

hl("NonText", {
  fg = c.dark_grey4,
})

link("EndOfBuffer", "NonText")
link("Whitespace", "NonText")

hl("WinSeparator", {
  fg = c.dark_grey4,
})

hl("StatusLine", {
  fg = c.light_grey2,
  bg = c.dark_grey4,
})

hl("StatusLineNC", {
  fg = c.light_grey4,
  bg = c.dark_grey3,
})

hl("WinBar", {
  fg = c.light_grey2,
  bg = c.dark_grey1,
  bold = true,
})

hl("WinBarNC", {
  fg = c.light_grey4,
  bg = c.dark_grey1,
})

-- ---------------------------------------------------------------------------
-- Completion menu
-- ---------------------------------------------------------------------------

hl("Pmenu", {
  fg = c.light_grey2,
  bg = c.dark_grey3,
})

hl("PmenuSel", {
  reverse = true,
})

hl("PmenuSbar", {
  bg = c.dark_grey3,
})

hl("PmenuThumb", {
  bg = c.dark_grey4,
})

link("PmenuKind", "Pmenu")
link("PmenuExtra", "Pmenu")
link("PmenuKindSel", "PmenuSel")
link("PmenuExtraSel", "PmenuSel")

-- ---------------------------------------------------------------------------
-- Traditional syntax groups
-- ---------------------------------------------------------------------------

hl("Comment", {
  fg = c.light_grey4,
  italic = true,
})

hl("String", {
  fg = c.light_green,
})

hl("Character", {
  fg = c.light_green,
})

hl("Number", {
  fg = c.light_yellow,
})

hl("Float", {
  fg = c.light_yellow,
})

hl("Boolean", {
  fg = c.light_yellow,
  bold = true,
})

hl("Constant", {
  fg = c.light_blue,
})

hl("Identifier", {
  fg = c.light_blue,
})

hl("Function", {
  fg = c.light_cyan,
})

hl("Statement", {
  fg = c.light_magenta,
  bold = true,
})

hl("Keyword", {
  fg = c.light_magenta,
  bold = true,
})

hl("Conditional", {
  fg = c.light_magenta,
  bold = true,
})

hl("Repeat", {
  fg = c.light_magenta,
  bold = true,
})

hl("Exception", {
  fg = c.light_red,
  bold = true,
})

hl("Operator", {
  fg = c.light_grey3,
})

hl("Type", {
  fg = c.light_blue,
})

hl("StorageClass", {
  fg = c.light_magenta,
})

hl("Structure", {
  fg = c.light_blue,
})

hl("PreProc", {
  fg = c.light_magenta,
})

hl("Include", {
  fg = c.light_magenta,
  bold = true,
})

hl("Special", {
  fg = c.light_cyan,
})

hl("Delimiter", {
  fg = c.light_grey3,
})

hl("Title", {
  fg = c.light_cyan,
  bold = true,
})

hl("Todo", {
  fg = c.dark_grey1,
  bg = c.light_yellow,
  bold = true,
})

-- ---------------------------------------------------------------------------
-- Treesitter
-- ---------------------------------------------------------------------------

link("@comment", "Comment")
link("@string", "String")
link("@character", "Character")
link("@number", "Number")
link("@number.float", "Float")
link("@boolean", "Boolean")

link("@constant", "Constant")
link("@constant.builtin", "Constant")
link("@constant.macro", "Constant")

hl("@variable", {
  fg = c.light_grey2,
})

hl("@variable.builtin", {
  fg = c.light_blue,
  italic = true,
})

hl("@variable.parameter", {
  fg = c.light_grey3,
})

hl("@variable.member", {
  fg = c.light_blue,
})

link("@property", "@variable.member")

link("@function", "Function")
link("@function.call", "Function")
link("@function.method", "Function")
link("@function.method.call", "Function")

hl("@function.builtin", {
  fg = c.light_cyan,
  italic = true,
})

link("@constructor", "Type")

link("@type", "Type")

hl("@type.builtin", {
  fg = c.light_blue,
  italic = true,
})

link("@type.definition", "Type")
link("@type.qualifier", "StorageClass")

link("@keyword", "Keyword")
link("@keyword.function", "Keyword")
link("@keyword.return", "Keyword")
link("@keyword.conditional", "Conditional")
link("@keyword.repeat", "Repeat")
link("@keyword.exception", "Exception")
link("@keyword.operator", "Keyword")

-- This is the distinction you originally wanted:
hl("@keyword.import", {
  fg = c.light_magenta,
  bold = true,
})

hl("@module", {
  fg = c.light_cyan,
})

hl("@module.builtin", {
  fg = c.light_blue,
  italic = true,
})

-- Explicit Python variants, in case the language-specific captures win.
link("@keyword.import.python", "@keyword.import")
link("@module.python", "@module")

link("@operator", "Operator")
link("@punctuation.delimiter", "Delimiter")
link("@punctuation.bracket", "Delimiter")
link("@punctuation.special", "Special")

hl("@attribute", {
  fg = c.light_yellow,
})

link("@string.escape", "Special")
link("@string.regexp", "Special")
link("@string.special", "Special")

link("@markup.heading", "Title")
link("@markup.strong", "Bold")
link("@markup.italic", "Italic")
link("@markup.link", "Underlined")
link("@markup.raw", "String")

-- ---------------------------------------------------------------------------
-- LSP semantic tokens
-- ---------------------------------------------------------------------------

link("@lsp.type.class", "@type")
link("@lsp.type.enum", "@type")
link("@lsp.type.interface", "@type")
link("@lsp.type.struct", "@type")
link("@lsp.type.type", "@type")
link("@lsp.type.typeParameter", "@type")

link("@lsp.type.function", "@function")
link("@lsp.type.method", "@function.method")
link("@lsp.type.property", "@property")
link("@lsp.type.parameter", "@variable.parameter")
link("@lsp.type.variable", "@variable")
link("@lsp.type.namespace", "@module")
link("@lsp.type.decorator", "@attribute")
link("@lsp.type.enumMember", "@constant")
link("@lsp.type.keyword", "@keyword")
link("@lsp.type.number", "@number")
link("@lsp.type.string", "@string")

-- ---------------------------------------------------------------------------
-- Diagnostics
-- ---------------------------------------------------------------------------

hl("DiagnosticError", {
  fg = c.light_red,
})

hl("DiagnosticWarn", {
  fg = c.light_yellow,
})

hl("DiagnosticInfo", {
  fg = c.light_cyan,
})

hl("DiagnosticHint", {
  fg = c.light_blue,
})

hl("DiagnosticOk", {
  fg = c.light_green,
})

hl("DiagnosticUnderlineError", {
  sp = c.light_red,
  undercurl = true,
})

hl("DiagnosticUnderlineWarn", {
  sp = c.light_yellow,
  undercurl = true,
})

hl("DiagnosticUnderlineInfo", {
  sp = c.light_cyan,
  undercurl = true,
})

hl("DiagnosticUnderlineHint", {
  sp = c.light_blue,
  undercurl = true,
})

-- ---------------------------------------------------------------------------
-- Git and diff
-- ---------------------------------------------------------------------------

hl("Added", {
  fg = c.light_green,
})

hl("Changed", {
  fg = c.light_cyan,
})

hl("Removed", {
  fg = c.light_red,
})

hl("DiffAdd", {
  fg = c.light_grey1,
  bg = c.dark_green,
})

hl("DiffChange", {
  fg = c.light_grey1,
  bg = c.dark_grey4,
})

hl("DiffDelete", {
  fg = c.light_red,
  bold = true,
})

hl("DiffText", {
  fg = c.light_grey1,
  bg = c.dark_cyan,
  bold = true,
})

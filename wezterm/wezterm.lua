local wezterm = require("wezterm")
local config = {}

-- ============================================================
-- Identity
-- ============================================================

config.default_domain = "WSL:Ubuntu"

config.window_padding = {
	left = 12,
	right = 12,
	top = 8,
	bottom = 8,
}

config.initial_cols = 140
config.initial_rows = 40

-- Font
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Symbols Nerd Font Mono",
})

config.font_size = 11.5

-- ============================================================
-- Appearance
-- ============================================================

config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.94

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

config.window_frame = {
	active_titlebar_bg = "#11111b",
	inactive_titlebar_bg = "#181825",
	active_titlebar_fg = "#cdd6f4",
	inactive_titlebar_fg = "#6c7086",
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "#313244",
	},
}

-- ============================================================
-- Status Bar
-- ============================================================
wezterm.on("update-right-status", function(window, pane)
	local time = wezterm.strftime("%H:%M")
	window:set_right_status(" " .. time .. " ")
end)

-- ============================================================
-- Bindings
-- ============================================================
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

return config

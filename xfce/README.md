# XFCE theme switcher

Named `.conf` presets applied with `xfconf-query`. Requires Python 3.8+ and
XFCE's `xfconf` package; no Python packages needed. Run `apply` from your XFCE
desktop session as your normal user, not with `sudo`.

```sh
./theme-switcher list
./theme-switcher show dark
./theme-switcher apply dark --dry-run
./theme-switcher apply dark
./theme-switcher apply light
```

Copy a file in `themes/` to create a new preset, then edit its values. Use the
filename without `.conf` as the preset name. Values are unquoted; spaces in
theme names and fonts are supported. Omitted settings stay unchanged. Unknown
keys, sections, and invalid values are rejected before any changes are made.

To keep presets elsewhere:

```sh
./theme-switcher --config-dir ~/.config/xfce-themes apply my-theme
```

## Settings

| Section | Keys |
| --- | --- |
| `[appearance]` | `gtk_theme`, `icon_theme`, `cursor_theme`, `cursor_size`, `font`, `monospace_font`, `prefer_dark` |
| `[window_manager]` | `theme`, `title_font`, `button_layout` |
| `[notifications]` | `theme` (optional, for xfce4-notifyd) |
| `[panel]` | `theme` (optional, saved XFCE Panel Profiles name) |

## Panel profiles

Save a layout using **XFCE Panel Profiles** (`xfce4-panel-profiles`), then
reference its name without `.tar.bz2`:

```ini
[panel]
theme = Windows95
```

The script runs `xfce4-panel-profiles load <archive>` after applying appearance
settings. This replaces the panel layout, including plugins and launchers;
save your existing layout in Panel Profiles first. Omitting `[panel]` leaves
the panel alone. `current.conf` references your saved `Windows95` profile.

Profiles are searched in `$XDG_DATA_HOME/xfce4-panel-profiles` (default:
`~/.local/share/xfce4-panel-profiles`), then in
`xfce4-panel-profiles/layouts` beneath `$XDG_DATA_DIRS` (default:
`/usr/local/share:/usr/share`). Missing profiles or executables are reported
before changing appearance settings. Dry-run prints the load command without
loading the profile.

`cursor_size` is a nonnegative integer (`0` uses the default size). An empty
`cursor_theme` uses the default cursor theme. `prefer_dark` accepts `true`/`false`.
Window button codes: `O` menu, `T` stick, `S` shade, `H` minimize, `M` maximize, `C` close;
`|` separates left and right buttons.

Presets do not install themes or verify that they exist. The bundled presets
use Adwaita and XFWM's Default theme as examples; adjust these to themes
installed on your system. GTK themes and XFWM themes have separate names and
may come in separate packages. You can inspect current values with:

```sh
xfconf-query --channel xsettings --list --verbose
xfconf-query --channel xfwm4 --list --verbose
```

Most changes take effect immediately, but some apps or cursors need an app
restart or logout/login. GTK4/libadwaita apps may ignore GTK theme settings.
The script does not change wallpapers or GTK CSS overrides. Panel layouts
change only when `[panel]` is configured.
Application is not transactional: an xfconf failure can leave earlier settings
applied. Dry-run prints explicit, create-capable commands without contacting
XFCE or changing anything.

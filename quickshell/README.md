# Basic Quickshell bar

A rounded Hyprland bar on every monitor, with a Catppuccin pink–purple–blue gradient frame matching the window borders.

## Run

```sh
qs
```

Quickshell reloads the configuration when you save `shell.qml`.

## Features

- Click a workspace number to switch. Workspaces 1–5 always appear; other open numbered workspaces appear automatically.
- The active workspace has an animated-width gradient pill, separately on each monitor.
- A blue dot below a workspace number means it is active or has windows on another display (including empty active workspaces).
- Active window title, date, and 24-hour clock.
- Blue-tinted volume controls and a gradient clock badge, with smooth hover transitions.
- Click volume to mute; scroll to adjust by 5% (capped at 100%). Uses PipeWire.
- Battery percentage and AC status via UPower, hidden when no battery is present. Low battery turns red.

Change the colors and font near the top of `shell.qml`.

## Optional Hyprland autostart

Add this to your Hyprland configuration:

```ini
exec-once = qs --no-duplicate
```

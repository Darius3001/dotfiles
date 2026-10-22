# Basic Quickshell bar

A small, rounded Hyprland bar on every monitor, using a Catppuccin-inspired palette.

## Run

```sh
qs
```

Quickshell reloads the configuration when you save `shell.qml`.

## Features

- Click a workspace number to switch. Workspaces 1–5 always appear; other open numbered workspaces appear automatically.
- The active workspace is highlighted separately on each monitor.
- Active window title, date, and 24-hour clock.
- Click volume to mute; scroll to adjust by 5% (capped at 100%). Uses PipeWire.
- Battery percentage and AC status via UPower, hidden when no battery is present. Low battery turns red.

Change the colors and font near the top of `shell.qml`.

## Optional Hyprland autostart

Add this to your Hyprland configuration:

```ini
exec-once = qs --no-duplicate
```

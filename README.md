# Hammerspoon Modal Manager
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful, modal-based window management and productivity toolkit built on [Hammerspoon](http://www.hammerspoon.org/), inspired by Vim's modal system.

## Overview

This configuration transforms Hammerspoon into a comprehensive productivity suite with:

- Modal-based window management (similar to Vim's modal editing)
- Application launcher with customizable shortcuts
- Desktop widgets (clock, space number indicator)
- Clipboard management
- Mouse control via keyboard
- Window space management
- Countdown timer with visual alerts
- Translation tools
- Pomodoro timer
- And more...

## Core Concepts

### Modal System

The heart of this configuration is a modal system similar to Vim (with default key binding):

- **Modal Manager** (`Alt + Space`) - The top-level controller that lets you switch between different modes.
- **App Mode** (`Alt + A`) - Quick application launching
- **Resize Mode** (`Alt + R`) - Window management and positioning
- **View Mode** (`Alt + V`) - Mouse control via keyboard
- **Clipboard Mode** (`Alt + C`) - Clipboard history and management
- **Cheatsheet Mode** (`Alt + S`) - Shows available hotkeys

Each mode provides a specific set of functionalities with its own hotkeys, and a visual indicator shows your current mode in the bottom right corner of the screen.

## Installation

1. Install [Hammerspoon](http://www.hammerspoon.org/)
2. Clone this repository:
   ```
   git clone https://github.com/zzuse/hammerspoon.git ~/.hammerspoon
   ```
3. Launch Hammerspoon or reload your configuration

## Updating

To update to the latest version:
```
cd ~/.hammerspoon && git pull
```

## Key Features

### Window Management (Resize Mode)

Access with `Alt + R` to enter resize mode, then use:

| Key | Function |
|-----|----------|
| `F` | Fullscreen |
| `C` | Center window |
| `Shift + C` | Resize & center |
| `H` | Left half of screen |
| `J` | Bottom half of screen |
| `K` | Top half of screen |
| `L` | Right half of screen |
| `Y` | Northwest corner |
| `N` | Southwest corner |
| `M` | Southeast corner |
| `O` | Northeast corner |
| `=` | Stretch outward |
| `-` | Shrink inward |
| `Shift + H/J/K/L` | Move window |
| `[/]` | Focus previous/next window |
| Arrow keys | Move to adjacent monitor |
| `Space` | Move to next monitor |
| `Q` or `Escape` | Exit mode |

### Mouse Control (View Mode)

Access with `Alt + V` to enter view mode, then use:

| Key | Function |
|-----|----------|
| `H/J/K/L` | Scroll left/down/up/right |
| `Ctrl + H/J/K/L` | Move mouse by 50px |
| `Shift + H/J/K/L` | Move mouse by 10px |
| `Ctrl+Shift + H/J/K/L` | Move mouse by 1px |
| `,` | Left mouse click |
| `.` | Right mouse click |
| `Q` or `Escape` | Exit mode |

### Application Launcher (App Mode). It's my everyday use.

Access with `Alt + A` to enter app mode, then use configured shortcuts to launch applications:

| Default Key | Application |
|-------------|-------------|
| `f` | Finder |
| `s` | Safari |
| `t` | Terminal |
| `v` | Activity Monitor |
| `y` | System Settings |

You can customize these in your private configuration. see `private/awesomeconfig.lua`

### Desktop Widgets

- **Digital Clock** - Shows a dim green time in the top left corner of every space, even in game mode.
- **Space Number** - Shows current space number in the top right corner
- **Caffeinator** - Prevents sleep, controlled by a menu bar icon

### Global Shortcuts

| Key | Function |
|-----|----------|
| `Alt + M` | Toggle modal manager |
| `Alt + Z` | Toggle Hammerspoon console |
| `Alt + I` | Window hints (shows window labels) |
| `Alt + T` | Start countdown timer |
| `Alt + P` | Pause/resume countdown timer |
| `Ctrl+Alt+Cmd + T` | Toggle digital clock |
| `Ctrl+Alt+Cmd + D` | DeepL translate clipboard |
| `Ctrl+Alt+Cmd + S` | Start Pomodoro timer |
| `Ctrl+Alt+Cmd + P` | Pause Pomodoro timer |
| `Ctrl+Alt+Cmd + R` | Resume Pomodoro timer |
| `Ctrl+Alt+Cmd + C` | Reload Hammerspoon configuration |
| `Shift+Alt + 1` | Move window to left space |
| `Shift+Alt + 3` | Move window to right space |

## Customization

Create or modify `~/.hammerspoon/private/awesomeconfig.lua` to customize:

- Hotkeys for each mode
- Application shortcuts
- Widget appearance
- Default behaviors

## Project Structure

```
hammerspoon/
├── modes/           # Mode-specific functionality
├── private/         # Personal configurations
├── resources/       # Images and sounds
├── Spoons/          # Plugins (Spoons)
├── basicmode.lua    # Core modal definitions
├── init.lua         # Main entry point
├── modalmgr.lua     # Modal manager
└── README.md        # This file
`init.lua` ==> private config (`awesomeconfig.lua`) ==> modalmgr(call `basicmode.lua`) ==> loadSpoon plugins
```

## Plugins (Spoons)

This configuration includes several Spoons:

- **AClock** - Digital clock display
- **SpaceNumber** - Space number indicator in every space. see my https://github.com/zzuse/SpaceNumber.spoon
- **CountDownNumber** - Visual countdown timer
   1. A countdown number from chooser dialog
   ![chooser1](resources/count_down_1.jpg)
   2. Result can be obtained from input box if no valid option
   ![chooser2](resources/count_down_2.jpg)
   3. Start a countdown
   ![countdown](resources/count_down_3.jpg)
   4. At last there will be a completion sound alert.
- **Cherry** - Pomodoro timer
- **DeepLTranslate** - Translation tool
- **WindowGrid** - Visual window management
- **Emojis** - Emoji picker
- **ReloadConfiguration** - Easy config reloading
- **hcalendar** - calendar by default
   ![hcal](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-hcal.png)

## Contributing

Feel free to submit issues and enhancement requests!

## Credits

This configuration is based on and inspired by various Hammerspoon configurations in the community. Special thanks to the Hammerspoon developers and contributors.
* [https://github.com/ashfinal/awesome-hammerspoon](https://github.com/ashfinal/awesome-hammerspoon)
* [https://github.com/zzamboni/oh-my-hammerspoon](https://github.com/zzamboni/oh-my-hammerspoon)
* [https://github.com/scottcs/dot_hammerspoon](https://github.com/scottcs/dot_hammerspoon)
* [https://github.com/dharmapoudel/hammerspoon-config](https://github.com/dharmapoudel/hammerspoon-config)
* [http://tracesof.net/uebersicht/](http://tracesof.net/uebersicht/)
* [sample-configurations](https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations)
* [github move spaces Issues](https://github.com/Hammerspoon/hammerspoon/issues/3636#issuecomment-2384239506)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
# Cloned and then modified from Awesome-hammerspoon. It is very personal and may not suit your needs. 

## Add private dir for personal use Model hotkeys and AppLaunchers. 
## Show hot key when enter each mode  
## Caffeine 
## AppLauncher, Clipboard, Mouse control
## showavailableHotkey and Cheatsheet, (you don't need to remember lots of keybindings, just call cheatsheet.)
## resize(not useful cause I have yabai)
## remove DownloadMode, and lots
## modify AClock size and location and many
## Plugins: AClock, CountDown, Emojis, WindowGrid, SpoonInstall, DeepLTranslate, Cherry, Reload Plugins
## Custom commands

Awesome-hammerspoon is my collection of lua scripts for [Hammerspoon](http://www.hammerspoon.org/). It has highly modal-based, vim-styled key bindings, provides some functionality like desktop widgets, window management, application launcher, dictionary translation, cheatsheets... etc.


## Get started

1. Install [Hammerspoon](http://www.hammerspoon.org/) first.
2. `git clone https://github.com/zzuse/hammerspoon.git ~/.hammerspoon`
3. Reload the configutation.

and you're set.

## Keep update

`cd ~/.hammerspoon && git pull`

## Details 
#### `init.lua` is the main entry point
1. init.lua ==> private config (awesomeconfig.lua) ==> modalmgr(call basicmode.lua) ==> loadSpoon plugins  
2. The modalmgr controls entering appMODE, clipboardMODE, cheatsheetMODE, resizeMODE, viewMODE, and showTime

| Key bindings                | Movement                   |
|-----------------------------|----------------------------|
| <kbd>⌥</kbd> + <kbd>M</kbd> | Mode on/off                |
| <kbd>⌥</kbd> + <kbd>A</kbd> | Enter `app` mode           |
| <kbd>⌥</kbd> + <kbd>C</kbd> | Enter `clipboard` mode     |
| <kbd>⌥</kbd> + <kbd>R</kbd> | Enter `resize` mode        |
| <kbd>⌥</kbd> + <kbd>S</kbd> | Enter `cheatsheet` mode    |
| <kbd>⌥</kbd> + <kbd>T</kbd> | Show current time          |
| <kbd>⌥</kbd> + <kbd>V</kbd> | Enter `view` mode          |
| <kbd>⌥</kbd> + <kbd>I</kbd> | Windows Hint               |
| <kbd>⌥</kbd> + <kbd>Z</kbd> | Toggle Hammerspoon console |
| <kbd>⌥</kbd> + <kbd>G</kbd> | Plugin Window grid         |
| <kbd>⌥</kbd> + <kbd>E</kbd> | Plugin Emojis              |
| ctrl + alt + cmd + C        | spoon.ReloadConfiguration  |
|     shift ctrl + E          | send EXIT to terminal      |
|     shift ctrl + H          | hide desktop file          |
| cmd shift ctrl + H          | show desktop file          |
| ctrl + alt + cmd + D        | DeepL Translate            |
| ctrl + alt + cmd + S        | pomodoro timer tart        |
| ctrl + alt + cmd + P        | pomodoro timer pause       |
| ctrl + alt + cmd + R        | pomodoro timer resume      |
| ctrl + alt + cmd + T        | Count down timer           |


3. not need to speak app mode, it is straightforward, just launch APPs.
4. if you enter viewMODE(ALT+V), you can using your H/I/J/K to scroll your mouse.

| Key bindings                | Movement                   |
|-----------------------------|----------------------------|
| H                       | Scroll Leftward                |
| L                       | Scroll Rightward               |
| J                       | Scroll Downward                |
| K                       | Scroll Upward                  |
| ctrl , H                | Move Mouse Leftward by 50px    |
| ctrl , L                | Move Mouse Rightward by 50px   |
| ctrl , J                | Move Mouse Downward by 50px    |
| ctrl , K                | Move Mouse Upward by 50px      |
| shift', 'H',            | 'Move Mouse Leftward by 10px'  |
| shift', 'L',            | 'Move Mouse Rightward by 10px  |
| shift', 'K',            | 'Move Mouse Upward by 10px',   |
| shift', 'J',            | 'Move Mouse Downward by 10px'  |
| 'ctrl','shift', 'H',    | 'Move Mouse Leftward by 1px',  |
| 'ctrl','shift', 'L',    | 'Move Mouse Rightward by 1px'  |
| 'ctrl','shift', 'K',    | 'Move Mouse Upward by 1px', f  |
| 'ctrl','shift', 'J',    | 'Move Mouse Downward by 1px',  |
| ','                     | 'Left Mouse Click',            |
| '.'                     | 'Right Mouse Click'            |
| Q                       | EXIT                           |

5. if you enter resizeMODE, you can using your Y/O/I/M/... to stretch your window.

| Key bindings                | Movement                   |
|-----------------------------|----------------------------|
| 'shift', 'Y',               |'Shrink Leftward'           |
| 'shift', 'O',               |'Stretch Rightward'         |
| 'shift', 'M',               |'Stretch Downward'          |
| 'shift', 'I',               |'Shrink Upward'             |
|  'F',                       |'Fullscreen'                |
|  'C',                       |'Center Window'             |
| 'shift', 'C',               |'Resize & Center'           |
|  'H',                       |'Lefthalf of Screen'        |
|  'J',                       |'Downhalf of Screen'        |
|  'K',                       |'Uphalf of Screen'          |
|  'L',                       |'Righthalf of Screen'       |
|  'Y',                       |'NorthWest Corner'          |
|  'N',                       |'SouthWest Corner'          |
|  'M',                       |'SouthEast Corner',         |
|  'O',                       |'NorthEast Corner',         |
|  '=',                       |'Stretch Outward',          |
|  '-',                       |'Shrink Inward',            |
| 'shift', 'H',               |'Move Leftward',            |
| 'shift', 'L',               |'Move Rightward',           |
| 'shift', 'J',               |'Move Downward',            |
| 'shift', 'K',               |'Move Upward',              |
| '[',                        |'Focus Westward',           |
| ']',                        |'Focus Eastward',           |
| 'up',                       |'Move to monitor above'     |
| 'down',                     |'Move to monitor below'     |
| 'right',                    |'Move to monitor right'     |
| 'left',                     |'Move to monitor left',     |
| 'space',                    |'Move to next monitor'      |
| Q                           | EXIT                       |

# Below is the original author's description, not my personal use.
--------------------------
## What's modal-based key bindings?

### 1. Desktop Widgets

<details>
<summary>More details</summary>

As you may have noticed, there are two clean, nice-looking desktop widgets, analogclock and calendar. Usually we don't interact with them, but I do hope you like them.

![widgets](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-deskwidgets.png)

**UPDATE:** Add new widget `hcalendar` and make it default module. The design comes from [here](https://github.com/ashikahmad/horizontal-calendar-widget).

![hcal](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-hcal.png)

</details>
...


## Thanks to

<details>
<summary>More details</summary>

[http://www.hammerspoon.org/](http://www.hammerspoon.org/)

[https://github.com/zzamboni/oh-my-hammerspoon](https://github.com/zzamboni/oh-my-hammerspoon)

[https://github.com/scottcs/dot_hammerspoon](https://github.com/scottcs/dot_hammerspoon)

[https://github.com/dharmapoudel/hammerspoon-config](https://github.com/dharmapoudel/hammerspoon-config)

[http://tracesof.net/uebersicht/](http://tracesof.net/uebersicht/)

</details>

## Welcome to

Share your scripts and thoughts.

: )

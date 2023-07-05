# Cloned and then modified from Awesome-hammerspoon. It is very personal and may not suit your needs. 

## Add private dir for personal use Model hotkeys and AppLaunchers. 
## Show hot key when enter each mode  
## More spoons 
## Caffeine 
## Beautify 
## remove personal not used functions 
![modes](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-modes.png)

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
1. init.lua ==> private config ==> basicmode ==> modalmgr ==> loadSpoon
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
| <kbd>⌥</kbd> + <kbd>Z</kbd> | Toggle Hammerspoon console |
| ctrl + alt + cmd + C        | spoon.ReloadConfiguration  |
|     shift ctrl + E          | send EXIT to terminal      |
|     shift ctrl + H          | hide desktop file          |
| cmd shift ctrl + H          | show desktop file          |
| ctrl + alt + cmd + D        | DeepL Translate            |
| ctrl + alt + cmd + S        | pomodoro timer tart        |
| ctrl + alt + cmd + P        | pomodoro timer pause       |
| ctrl + alt + cmd + R        | pomodoro timer resume      |
| <kbd>⌥</kbd> + <kbd>G</kbd> | window grid                |
| <kbd>⌥</kbd> + <kbd>E</kbd> | Emojis                     |


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

4. if you enter resizeMODE, you can using your Y/O/I/M/... to stretch your window.

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

<details>
<summary>More details</summary>

Well... simply to say, it allows you using <kbd>S</kbd> key to resize windows in `resize` mode, but in `app` mode, to launch Safari, in `timer` mode, to set a 10-mins timer... something like that. During all progress, you don't have to press extra keys.
</p>

And this means a lot.

* It's scene-wise, you can use same key bindings to do different jobs in different scenes. You don't worry to run out of your hotkey bindings, and twist your fingers to press <kbd>⌘</kbd> + <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>⇧</kbd> + <kbd>C</kbd> in the end.

* Less keystrokes, less memory pressure. You can press <kbd>⌥</kbd> + <kbd>A</kbd> to enter `app` mode, release, then press single key <kbd>S</kbd> to launch Safari, or <kbd>C</kbd> to lauch Chrome. Sounds good? You keep your pace, no rush.

* Easy to extend, you can create your own modals if you like. For example, `Finder` mode, in which you press <kbd>T</kbd> to open Terminal here, press <kbd>S</kbd> to send files to predefined path, press <kbd>C</kbd> to upload images to cloud storage.

**NOTICE:** After your work you'd better quit current mode back to normal. Or, you carefully pick your key bindings to avoid conflict with other hotkeys.

</details>

## How to use?

So, following above procedures, you have reloaded Hammerspoon's configutation. Let's see what we've got here.

### 1. Desktop Widgets

<details>
<summary>More details</summary>

As you may have noticed, there are two clean, nice-looking desktop widgets, analogclock and calendar. Usually we don't interact with them, but I do hope you like them.

![widgets](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-deskwidgets.png)

**UPDATE:** Add new widget `hcalendar` and make it default module. The design comes from [here](https://github.com/ashikahmad/horizontal-calendar-widget).

![hcal](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-hcal.png)

</details>

### 2. Mode Block

<details>
<summary>More details</summary>

There is also a small gray block in the bottom right corner, maybe displaying current netspeed. Well, it's actually **mode block**. Want to know in which mode you are? Give it a glance. When Hammerspoon starts, or there's no work to do, it shows `DOCK MODE` in black background. But alway displaying the black block is a little boring, so we use it for netspeed monitor if there's no activity for 5 secs.

**Mode block** holds the entrance to other modes, you can use <kbd>⌥</kbd> + <kbd>space</kbd> to toggle its display. Then use <kbd>⌥</kbd> + <kbd>R</kbd> to enter `resize` mode, or use <kbd>⌥</kbd> + <kbd>A</kbd> to enter `app` mode... etc.

Key bindings available:

| Key bindings                | Movement                   |
|-----------------------------|----------------------------|
| <kbd>⌥</kbd> + <kbd>A</kbd> | Enter `app` mode           |
| <kbd>⌥</kbd> + <kbd>C</kbd> | Enter `clipboard` mode     |
| <kbd>⌥</kbd> + <kbd>D</kbd> | Enter `download` mode      |
| <kbd>⌥</kbd> + <kbd>G</kbd> | Launch hammer search       |
| <kbd>⌥</kbd> + <kbd>I</kbd> | Enter `timer` mode         |
| <kbd>⌥</kbd> + <kbd>R</kbd> | Enter `resize` mode        |
| <kbd>⌥</kbd> + <kbd>S</kbd> | Enter `cheatsheet` mode    |
| <kbd>⌥</kbd> + <kbd>T</kbd> | Show current time          |
| <kbd>⌥</kbd> + <kbd>v</kbd> | Enter `view` mode          |
| <kbd>⌥</kbd> + <kbd>Z</kbd> | Toggle Hammerspoon console |
| <kbd>⌥</kbd> + <kbd>⇥</kbd> | Show window hints          |

*In most modes, you can use <kbd>Q</kbd>, or <kbd>⎋</kbd> to quit back to DOCK mode. And switch from one mode to another directly.*

</details>

### 3. Window Management(resize mode) <kbd>⌥</kbd> + <kbd>R</kbd>

<details>
<summary>More details</summary>

![winresize](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-winresize.gif)

Use <kbd>[/]</kbd> to cycle through active windows.

Use <kbd>H/J/K/L</kbd> to resize windows to 1/2 of screen.

Use <kbd>Y/U/I/O</kbd> to resize windows to 1/4 of screen.

Use <kbd>⇧</kbd> + <kbd>H/J/K/L</kbd> to **move** windows around.

Use <kbd>⇧</kbd> + <kbd>Y/U/I/O</kbd> to **resize** windows.

Use <kbd>=</kbd>, <kbd>-</kbd> to expand/shrink the window size.

Use <kbd>F</kbd> to put windows to fullscreen, use <kbd>C</kbd> to put windows to center of screen, use <kbd>⇧</kbd> + <kbd>C</kbd> to resize windows to predefined size and center them.

</details>


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

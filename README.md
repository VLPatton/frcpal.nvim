# FRC Command Palette for NeoVim
## frcpal.nvim
This is a plugin I wrote for myself because I dislike using VS Code for everything in FRC.
Please fork if you have a feature request that you would like to implement.

## Usage
Install through `packer.nvim`:

```lua
use 'VLPatton/frcpal.nvim'
```

From there, you can configure your own key binds in a separate file:

```lua
local frcpal = require('frcpal')

vim.keymap.set('n', '<leader>pb', function() frcpal.gradle('build') end) -- pb for Project Build
vim.keymap.set('n', '<leader>pd', function() frcpal.gradle('deploy') end) -- pd for Project Deploy
vim.keymap.set('n', '<leader>pD', frcpal.get_vendordep) -- pD for Project Dependencies
```

## License Notice
This project is NOT AFFILIATED in any capacity with *FIRST*, *FIRST* Robotics Competition, or any related organizations.
Please DO NOT submit issues to *FIRST* regarding this plugin; issues should be submitted through Github in this repo.

This project is licensed under the GNU Lesser General Public License version 3.
The license is included under `COPYING.md` and `COPYING.LESSER.md`.

Copyright (C) 2023 VLPatton

## Features
* Gradle wrapper with custom commands for keybinds
* Terminal buffer integration
* Fetching vendordep JSON files from remote URI

## TODO
* Add ability to create new project

# FRC Command Palette for NeoVim
## frcpal.nvim
This is a plugin I wrote for myself because I dislike using VS Code for everything in FRC.

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

## Features
* Gradle wrapper with custom commands for keybinds
* Fetching vendordep JSON files from remote URI

## TODO
* Integrate with `toggleterm.nvim` (maybe)
* Add ability to create new project through 

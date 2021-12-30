# telescope-extended-commands.nvim

A [Telescope](https://github.com/nvim-telescope/telescope.nvim) extension that
extends builtin commands finder for. You can pick both user-defined, and
built-in, commands. The aim is also that for commands where it makes sense, you
should be able to filter on sub-commands, e.g. `references` should match
`Telescope lsp_references`.

## Setup

To install the extension, do

```lua
require('telescope').load_extension('extcommands')
```

## Usage

Call it using the `Telescope` command:

```vim
:Telescope extended_commands
```

Pressing enter on the command executes it.

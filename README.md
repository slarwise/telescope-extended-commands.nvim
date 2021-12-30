# telescope-extended-commands.nvim

A [Telescope](https://github.com/nvim-telescope/telescope.nvim) extension that
extends the builtin commands finder. You can pick both user-defined and built-in
commands. Commands that take a sub-command, such as Telescope, can be filtered
on their sub-commands. For example, `lsp_references` matches
`Telescope lsp_references`, which can then be executed.

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

Pressing enter on the command executes it. `<C-E>` lets you edit the command.

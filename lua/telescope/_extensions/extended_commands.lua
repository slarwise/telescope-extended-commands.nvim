local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error "This plugins requires nvim-telescope/telescope.nvim"
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local make_entry = require "telescope.make_entry"

local extended_commands = function(opts)
    opts = opts or {}

    local command_names = vim.fn.getcompletion("", "command")

    local user_commands = vim.api.nvim_get_commands {}
    for name, values in pairs(user_commands) do
        -- Including customlist took a long time
        -- if vim.tbl_contains({ "custom", "customlist" }, values.complete) then
        if vim.tbl_contains({ "custom" }, values.complete) then
            local custom_completions = vim.fn.getcompletion(name .. " ", "cmdline")
            for _, sub_command in ipairs(custom_completions) do
                table.insert(command_names, name .. " " .. sub_command)
            end
        end
    end

    pickers.new(opts, {
        prompt_title = "Commands",
        finder = finders.new_table(command_names),
        sorter = conf.generic_sorter(opts),

        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                if selection == nil then
                    print "[telescope] Nothing currently selected"
                    return
                end

                actions.close(prompt_bufnr)
                local cmd = selection.value

                vim.cmd(cmd)
            end)

            map("n", "<C-e>", actions.edit_command_line)
            map("i", "<C-e>", actions.edit_command_line)

            return true
        end,
    }):find()
end

return telescope.register_extension {
    exports = { extended_commands = extended_commands },
}

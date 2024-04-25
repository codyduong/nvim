---@type ChadrcConfig
local M = {}

M.ui = { theme = 'dark_horizon' }

M.plugins = {
    override = {
        ["NvChad/nvterm"] = {
            terminals = {
                type_opts = {
                    float = {
                        shell = "pwsh", -- PowerShell as the default shell for floating terminal
                    },
                    horizontal = {
                        shell = "pwsh", -- PowerShell as the default shell for horizontal splits
                    },
                    vertical = {
                        shell = "pwsh", -- PowerShell as the default shell for vertical splits
                    },
                },
            },
        },
    },
}

return M

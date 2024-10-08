local config = {
  formatters_by_ft = {
    lua = { "stylua" },

    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    graphql = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },

    python = { "isort", "black" },

    markdown = { "prettierd" },
    yaml = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },

    bash = { "shellharden", "shfmt" },
    -- ps1 = { "psscriptanalyzer" },
    -- psd1 = { "psscriptanalyzer" },
    -- psm1 = { "psscriptanalyzer" },
    rust = { "rustfmt" }
  },
  -- format_on_save = {
  -- 	lsp_fallback = true,
  -- 	async = false,
  -- 	timeout_ms = 500,
  -- 	callback = function()
  -- 		require("lint").try_lint()
  -- 		-- ^^ try_lint is synchronous, so finally use lsp
  -- 		if vim.lsp.buf.server_capabilities.documentFormattingProvider then
  -- 			vim.lsp.buf.format({
  -- 				async = false,
  -- 			})
  -- 		end
  -- 		vim.cmd("e!")
  -- 		vim.cmd("EslintFixAll")
  -- 		print("we did it")
  -- 	end,
  -- },
  format_after_save = {
    lsp_fallback = true,
  },
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,

  -- this doesn't work, TODO
  -- formatters = {
  -- 	psscriptanalyzer = {
  -- 		command = "pwsh",
  -- 		args = {
  -- 			"-NoLogo",
  -- 			"-NoProfile",
  -- 			"-Command",
  -- 			"Invoke-ScriptAnalyzer",
  -- 			"-Path",
  -- 			"${INPUT}",
  -- 			"-Recurse",
  -- 			"-ReportSummary",
  -- 			"-Severity",
  -- 			"Error,Warning,Information",
  -- 			"-OutputFormat",
  -- 			"JSON",
  -- 		},
  -- 		parser = function(output)
  -- 			local diagnostics = {}
  -- 			local findings = vim.json.decode(output)
  -- 			for _, diag in ipairs(findings) do
  -- 				table.insert(diagnostics, {
  -- 					row = diag.ScriptRegion.StartLineNumber,
  -- 					col = diag.ScriptRegion.StartColumnNumber,
  -- 					end_row = diag.ScriptRegion.EndLineNumber,
  -- 					end_col = diag.ScriptRegion.EndColumnNumber,
  -- 					message = diag.Message,
  -- 					severity = vim.diagnostic.severity[diag.Severity:lower()],
  -- 				})
  -- 			end
  -- 			return diagnostics
  -- 		end,
  -- 		stdin = false,
  -- 	},
  -- },
}

return config

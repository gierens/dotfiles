return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      harper_ls = {
        filetypes = { "tex" },
        settings = {
          ["harper-ls"] = {
            -- userDictPath = "",
            -- workspaceDictPath = "",
            -- fileDictPath = "",
            linters = {
              -- SpellCheck = true,
              -- SpelledNumbers = false,
              -- AnA = true,
              SentenceCapitalization = false,
              -- UnclosedQuotes = true,
              -- WrongApostrophe = false,
              -- LongSentences = true,
              -- RepeatedWords = true,
              Spaces = false,
              -- CorrectNumberSuffix = true
              ToDoHyphen = false,
            },
            -- codeActions = {
            --   ForceStable = false
            -- },
            -- markdown = {
            --   IgnoreLinkTitle = false
            -- },
            -- diagnosticSeverity = "hint",
            -- isolateEnglish = false,
            -- dialect = "American",
            -- maxFileLength = 120000,
            -- ignoredLintsPath = "",
            -- excludePatterns = {}
          }
        }
      }
    }
  }
}

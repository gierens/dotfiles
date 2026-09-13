return {
    "mrcjkb/rustaceanvim",
    opts = {
        server = {
            -- cmd = { "verus-analyzer"},
            default_settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        -- allFeatures = false,
                    }
                }
            }
        }
    }
}

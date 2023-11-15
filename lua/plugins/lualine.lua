local crypto = require('plugins.crypto_price')

require('lualine').setup({
  options = {
    theme = 'tokyonight'
  },
  sections = {
        lualine_c = {
            'filename', 'lsp_progress'
        },
        lualine_x = {
            {
                crypto.btc_price,
                color = { bg = '#ffb86c', fg = '#4b361f', gui = 'bold' }
            },
            {
                crypto.eth_price,
                color = { bg = '#8be9fd', fg = '#365b63', gui = 'bold' }
            },
            {
                'filetype'
            }

        }
    }
})


return {
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function ()
        local alpha = require'alpha'
        local theme = require'alpha.themes.theta'
        alpha.setup(theme.config)
    end,
    opts = { position =  'center' },
}

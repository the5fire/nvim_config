-- fetch eth price from coingecko
-- Define a Lua function that wraps vim.fn.json_decode
--

local M = {}
-- create table of crypto symbols to unicode symbols
local cointable = {
    ["BTC"] = "₿",
    ["ETH"] = "Ξ",
}


local function get_coin_price(coin)
    local Job = require("plenary.job")
    local job = Job:new({
        command = "bash",
        args = { "-c", "export HTTPS_PROXY=\"http://127.0.0.1:1087\" && curl -s \"https://api.binance.com/api/v3/ticker/price?symbol=" .. coin .. "USDT\"" },
        on_exit = function(j, return_val)
            if return_val == 0 then
                vim.schedule(function()
                    local coin_price = vim.fn.json_decode(j:result())["price"]
                    -- round to 2 decimal placeholder_snip
                    coin_price = string.format("%s %.1f", cointable[coin], coin_price)
                    coin_lowercase = string.lower(coin)
                    vim.g[coin_lowercase .. "_price"] = coin_price
                end)
            end
        end
    }):start()
end

local timer = vim.loop.new_timer()
timer:start(0, 2000, function()
    get_coin_price("BTC")
    get_coin_price("ETH")
end)

function M.eth_price()
    return vim.g.eth_price
end

function M.btc_price()
    return vim.g.btc_price
end

return M

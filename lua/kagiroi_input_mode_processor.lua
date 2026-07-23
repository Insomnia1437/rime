-- 按当前 schema 的默认模式初始化 Kagiroi，同时复用上游罗马字处理器。

local kagiroi_kana_speller = require("kagiroi/kagiroi_kana_speller")
local M = {}

function M.init(env)
    kagiroi_kana_speller.init(env)
    local context = env.engine.context
    local config = env.engine.schema.config
    local mode = config:get_string("personal_kagiroi/default_kana_mode") or "hiragana"
    local ascii_width = config:get_string("personal_kagiroi/default_ascii_width")

    context:set_option("hiragana", mode == "hiragana")
    context:set_option("katakana", mode == "katakana")
    context:set_option("hw_katakana", mode == "hw_katakana")
    context:set_option("emoji", true)
    context:set_option("ascii_punct", false)

    -- 标准日语固定从半角英数开始；全角/半角专用方案由其菜单开关决定。
    if ascii_width == "half" then
        context:set_option("full_shape", false)
    end
end

function M.fini(env)
    kagiroi_kana_speller.fini(env)
end

function M.func(key_event, env)
    return kagiroi_kana_speller.func(key_event, env)
end

return M

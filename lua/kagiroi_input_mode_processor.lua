-- 在全角英数模式下跳过 Kagiroi 的罗马字转假名处理。
-- 其他模式完整复用上游 Kagiroi 处理器，避免维护一份分叉实现。

local kagiroi_kana_speller = require("kagiroi/kagiroi_kana_speller")
local kNoop = 2
local M = {}

function M.init(env)
    kagiroi_kana_speller.init(env)
end

function M.fini(env)
    kagiroi_kana_speller.fini(env)
end

function M.func(key_event, env)
    if env.engine.context:get_option("full_shape") then
        return kNoop
    end
    return kagiroi_kana_speller.func(key_event, env)
end

return M

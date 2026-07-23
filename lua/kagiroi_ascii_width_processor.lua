-- 让日语全角/半角方案中的 Shift 英数输入遵循 full_shape 开关。
-- 半角时交给 ascii_composer；全角时在它之前直接提交全角 ASCII。

local kAccepted = 1
local kNoop = 2
local M = {}

local function to_fullwidth(codepoint)
    if codepoint == 0x20 then
        return "　"
    end
    if codepoint >= 0x21 and codepoint <= 0x7E then
        return utf8.char(codepoint + 0xFEE0)
    end
    return nil
end

function M.func(key_event, env)
    if key_event:release() or key_event:ctrl() or key_event:alt() or key_event:super() then
        return kNoop
    end

    local context = env.engine.context
    if not context:get_option("full_shape") then
        return kNoop
    end

    local keycode = key_event.keycode
    local output = to_fullwidth(keycode)
    if not output then
        return kNoop
    end

    -- Shift 切到英数状态后，字母、数字、空格和符号全部直接按全角提交。
    if context:get_option("ascii_mode") then
        env.engine:commit_text(output)
        return kAccepted
    end

    -- 日语状态下的裸数字也遵循宽度；组合输入时数字仍用于选词。
    if keycode >= 0x30 and keycode <= 0x39 and not context:is_composing() then
        env.engine:commit_text(output)
        return kAccepted
    end

    return kNoop
end

return M

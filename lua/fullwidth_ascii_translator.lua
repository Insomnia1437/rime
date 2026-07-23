-- 将组合输入中的 ASCII 英文字母和数字转换为全角形式。
-- 仅在 Kagiroi 的 full_shape（英数全角）字符模式下产生候选。
-- 标点和空格继续由 Kagiroi 的 punctuator 处理。

local M = {}

function M.func(input, seg, env)
    if input == "" or not env.engine.context:get_option("full_shape") then
        return
    end

    local output = {}
    for _, codepoint in utf8.codes(input) do
        if codepoint >= 0x21 and codepoint <= 0x7E then
            table.insert(output, utf8.char(codepoint + 0xFEE0))
        elseif codepoint == 0x20 then
            table.insert(output, "　")
        else
            table.insert(output, utf8.char(codepoint))
        end
    end

    yield(Candidate("fullwidth_ascii", seg.start, seg._end, table.concat(output), ""))
end

return M

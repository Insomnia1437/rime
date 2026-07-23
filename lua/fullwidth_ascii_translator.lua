-- 将组合输入中的 ASCII 英文字母和数字转换为全角形式。
-- 标点和空格由 jaroomaji_fullwidth.schema.yaml 的 punctuator 处理。

local M = {}

function M.func(input, seg)
    if input == "" then
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

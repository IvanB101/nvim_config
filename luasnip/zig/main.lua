local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
	s({ trig = ";c", snippetType = "autosnippet", desc = "c array" }, t("[*c]")),
	s(
		{ trig = "extern", desc = "extern struct" },
		fmta(
			[[
            const <> = extern struct {
                <>
            };
        ]],
			{ i(1), i(0) }
		)
	),
	s(
		{ trig = "inline", desc = "inline fn" },
		fmta(
			[[
            inline fn <>(<>) <> {
                <>
            };
        ]],
			{ i(1), i(2), i(3), i(0) }
		)
	),
	s(
		{ trig = "export", desc = "export fn" },
		fmta(
			[[
            export fn <>(<>) <> {
                <>
            };
        ]],
			{ i(1), i(2), i(3), i(0) }
		)
	),
	s(
		{ trig = "sinit", desc = "struct with init and deinit functions" },
		fmta(
			[[
            const <> = struct {
                const Self = @This();

                pub fn init() Self {

                }

                pub fn deinit(self: *Self) void {

                }
            };
        ]],
			{ i(1) }
		)
	),
}

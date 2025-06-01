return {
	s(
		{ trig = "main", desc = "typename arg" },
		fmta(
			[[
        int main(int argc, const char * argv[]) {
            <>
            return 0;
        }
        ]],
			{ i(0) }
		)
	),
	-- to avoid priority conflics with class keyword
	s(
		{ trig = "type", desc = "class template" },
		fmta(
			[[
        class <> {
            private:
                <>
            public:
        };
        ]],
			{ i(1), i(0) }
		)
	),
	s(
		{ trig = "head", desc = "header" },
		fmta(
			[[
        #pragma once

        namespace <> {
            <>
        };
        ]],
			{ i(1), i(0) }
		)
	),
	s(
		{ trig = "impl", desc = "implementation file" },
		fmta(
			[[
        #include "<>"

        namespace <> {
            <>
        };
        ]],
			{ i(1), i(2), i(0) }
		)
	),
}

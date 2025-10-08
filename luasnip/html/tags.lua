local snippets = {
	s({ trig = "hr" }, t("<hr>")),
	s({ trig = "img" }, fmt('<img src="{}">', { i(1) })),
	s({ trig = "input" }, fmt('<input type="{}" id="{}" name="{}">', { i(1), i(2), i(3) })),
	s({ trig = "inputval" }, fmt('<input type="{}" id="{}" name="{}" value="{}">', { i(1), i(2), i(3), i(4) })),
	s({ trig = "label" }, fmt('<label for="{}">{}</label>', { i(1), i(2) })),
	s(
		{ trig = "html5" },
		fmt(
			[[
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>{}</title>
            <link rel="stylesheet" href="styles.css">
        </head>

        <body>
        {}
        </body>

        </html>
    ]],
			{ i(1), i(0) }
		)
	),
}

local tags = {
	"dd",
	"dl",
	"dt",
	"div",
	"form",
	"h1",
	"h2",
	"h3",
	"h4",
	"h5",
	"h6",
	"li",
	"ol",
	"p",
	"table",
	"td",
	"th",
	"tr",
	"ul",
}

for _, tag in ipairs(tags) do
	snippets[#snippets + 1] = s({ trig = tag }, fmt(string.format("<%s>{}</%s>", tag, tag), { i(1) }))
end

return snippets

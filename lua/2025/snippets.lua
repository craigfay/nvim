local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node


-- Shortcut to open this file using CTRL-s
vim.keymap.set("n", "<C-s>", "<cmd>tabe ~/.config/nvim/lua/2025/snippets.lua<CR>")



ls.add_snippets("zig", {
    s("print", fmt(
        [[
            std.debug.print("{{any}}\n", .{{ {} }});
        ]], { i(1) }
    ));
    s("struct", fmt(
        [[
            pub const {} = struct {{
                {}
            }};
        ]], { i(1, "Name"), i(2),
    }));
    s("for", fmt(
        [[
            for ({}, 0..) |{}, {}| {{
                {}
            }}
        ]], { i(1, "items"), i(2, "item"), i(3, "idx"), i(4), }
    ));
})

ls.add_snippets("javascript", {
    s("dependsOn", fmt(
        [[
            BI.dependsOn(["{}"], {{ timeLimit: {} }}).then(() => {{
              {}
            }});
        ]], { i(1), i(2, "5000"), i(3) }
    ))
})

ls.add_snippets("javascript", {
    s("wrapWithOneTrust", fmt(
        [[
            BI.wrapWithOneTrust({{
              fn: {},
              featureName: '{}',
              categories: [{}],
            }});
        ]], { i(1, "callback"), i(2, "featureName"), i(3, "4, 7") }
    ))
})

ls.add_snippets("javascript", {
    s("addEventListenerFactory", fmt(
        [[
            uniVideo.addEventListenerFactory(function() {{
              let didStart = false;

              return function eventListener(_e, data) {{
                const {{ eventType, videoData, videoState }} = data;
              }}
            }});
        ]], {}
    ))
})

ls.add_snippets("javascript", {
    s("adobeTrack", fmt(
        [[
            function track(situation, actionContextData) {{
              s.contextData = s.extendArray(s.contextData, actionContextData);
              s.tl(true, 'o', situation);

              for (var item in actionContextData) {{
                delete s.contextData[item];
              }}
            }}
        ]], {}
    ))
})

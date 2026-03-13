local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Output tags
  s("ee", fmt("<%= {} %>", { i(1) })),
  s("ep", fmt("<% {} %>", { i(1) })),

  -- Control flow - if/unless/else
  s(
    "eif",
    fmt(
      [[
<% if {} %>
  {}
<% end %>
]],
      { i(1, "condition"), i(2) }
    )
  ),

  s(
    "eunless",
    fmt(
      [[
<% unless {} %>
  {}
<% end %>
]],
      { i(1, "condition"), i(2) }
    )
  ),

  s("eelse", t("<% else %>")),

  s("eelsif", fmt("<% elsif {} %>", { i(1, "condition") })),

  s("eend", t("<% end %>")),

  -- Case/when
  s(
    "ecase",
    fmt(
      [[
<% case {} %>
<% when {} %>
  {}
<% else %>
  {}
<% end %>
]],
      { i(1, "variable"), i(2, "value"), i(3), i(4) }
    )
  ),

  s("ewhen", fmt("<% when {} %>", { i(1, "value") })),

  -- Loops
  s(
    "eeach",
    fmt(
      [[
<% {}.each do |{}| %>
  {}
<% end %>
]],
      { i(1, "@items"), i(2, "item"), i(3) }
    )
  ),

  s(
    "efor",
    fmt(
      [[
<% for {} in {} %>
  {}
<% end %>
]],
      { i(1, "item"), i(2, "@items"), i(3) }
    )
  ),

  -- Rails helpers - Links
  s("elink", fmt([[<%= link_to "{}", {} %>]], { i(1, "Text"), i(2, "path") })),

  s(
    "elinkblock",
    fmt(
      [[
<%= link_to {} do %>
  {}
<% end %>
]],
      { i(1, "path"), i(2) }
    )
  ),

  -- Rails helpers - Forms
  s(
    "eform",
    fmt(
      [[
<%= form_for {} do |f| %>
  {}
<% end %>
]],
      { i(1, "@model"), i(2) }
    )
  ),

  s(
    "eformwith",
    fmt(
      [[
<%= form_with model: {} do |f| %>
  {}
<% end %>
]],
      { i(1, "@model"), i(2) }
    )
  ),

  -- Form fields
  s("efield", fmt([[<%= f.text_field :{} %>]], { i(1, "name") })),
  s("earea", fmt([[<%= f.text_area :{} %>]], { i(1, "name") })),
  s("echeck", fmt([[<%= f.check_box :{} %>]], { i(1, "name") })),
  s("eradio", fmt([[<%= f.radio_button :{}, {} %>]], { i(1, "name"), i(2, "value") })),
  s("eselect", fmt([[<%= f.select :{}, {} %>]], { i(1, "name"), i(2, "options") })),
  s("esubmit", fmt([[<%= f.submit "{}" %>]], { i(1, "Submit") })),
  s("elabel", fmt([[<%= f.label :{} %>]], { i(1, "name") })),

  -- Rails helpers - Images and assets
  s("eimage", fmt([[<%= image_tag "{}" %>]], { i(1, "path") })),

  -- Rails helpers - Content
  s("erender", fmt([[<%= render "{}" %>]], { i(1, "partial") })),
  s(
    "erenderp",
    fmt([[<%= render partial: "{}", locals: {{ {}: {} }} %>]], { i(1, "partial"), i(2, "key"), i(3, "value") })
  ),
  s(
    "econtent",
    fmt(
      [[<%= content_for :{} do %>
  {}
<% end %>]],
      { i(1, "name"), i(2) }
    )
  ),
  s("eyield", fmt([[<%= yield :{} %>]], { i(1, "name") })),

  -- Rails helpers - Other
  s("et", fmt([[<%= t("{}.{}") %>]], { i(1, "scope"), i(2, "key") })),

  -- HTML with ERB output
  s("ediv", fmt([[<div class="{}"><%= {} %></div>]], { i(1, "class"), i(2) })),
  s("espan", fmt([[<span class="{}"><%= {} %></span>]], { i(1, "class"), i(2) })),

  -- Comments
  s("ec", fmt([[<%# {} %>]], { i(1, "comment") })),

  -- Debug
  s("edebug", fmt([[<%= debug {} %>]], { i(1, "@object") })),
}

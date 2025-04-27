module ColorScheme

using ColorSchemes: ColorScheme as ColorSchem

using Colors: RGB

const BR_ = "#0000ff", "#ffffff", "#ff0000"

const IB_ = "#8a3ffc",
"#33b1ff",
"#007d79",
"#ff7eb6",
"#fa5d67",
"#fff1f1",
"#6fdc8c",
"#4589ff",
"#d12771",
"#d2a106",
"#08bdba",
"#bae6ff",
"#ba4e00",
"#d4bbff"

function make(st_)

    ColorSchem([parse(RGB, st) for st in st_])

end

end

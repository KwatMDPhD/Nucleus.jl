module ColorScheme

using ColorSchemes: ColorScheme as ColorSchem

using Colors: Colorant

# Plotly.js
const P1_ = "#1f77b4",
"#ff7f0e",
"#2ca02c",
"#d62728",
"#9467bd",
"#8c564b",
"#e377c2",
"#7f7f7f",
"#bcbd22",
"#17becf"

# Plotly.py
const P2_ = "#636efa",
"#ef553b",
"#00cc96",
"#ab63fa",
"#ffa15a",
"#19d3f3",
"#ff6692",
"#b6e880",
"#ff97ff",
"#fecb52"

# IBM Light
const I1_ = "#6929c5",
"#1192e8",
"#005d5d",
"#9f1853",
"#fa4d56",
"#570408",
"#198038",
"#002d9c",
"#ee538b",
"#b28600",
"#009d9a",
"#012749",
"#8a3800",
"#a56eff"

# IBM Dark
const I2_ = "#8a3ffc",
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

# Dutch Field
const DU_ = "#e60049",
"#0bb4ff",
"#50e991",
"#e6d800",
"#9b19f5",
"#ffa300",
"#dc0ab4",
"#b3d4ff",
"#00bfa0"

# River Night
const RI_ = "#b30000",
"#7c1158",
"#4421af",
"#1a53ff",
"#0d88e6",
"#00b7c7",
"#5ad45a",
"#8be04e",
"#ebdc78"

# Retro Metro
const RE_ = "#ea5545",
"#f46a9b",
"#ef9b20",
"#edbf33",
"#ede15b",
"#bdcf32",
"#87bc45",
"#27aeef",
"#b33dc6"

const BR_ = "#0000ff", "#ffffff", "#ff0000"

function make(co_)

    ColorSchem([parse(Colorant, co) for co in co_])

end

end

module Color

using Colors: Colorant, coloralpha, hex

const DA = "#27221f"

const LI = "#ebf6f7"

const HU = "#fbb92d"

const IN = "#4e40d8"

const VI = "#9017e6"

const CH = "#a40522"

const MO = "#f47983"

const TU = "#20d9ba"

const GR = "#92ff93"

const RE = "#ff1993"

const BL = "#1992ff"

const A1 = "#00936e"

const A2 = "#ffd96a"

const S1 = "#8c1515"

const S2 = "#175e54"

function make(co::Colorant)

    "#$(hex(co, :rrggbbaa))"

end

function make(co)

    make(parse(Colorant, co))

end

function make(co, fr)

    make(coloralpha(parse(Colorant, co), fr))

end

end

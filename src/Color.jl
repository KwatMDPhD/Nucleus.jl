module Color

using Colors: Colorant, RGB, coloralpha, hex

const DA = "#27221f"

const LI = "#ebf6f7"

const HU = "#fbb92d"

const IN = "#4e40d8"

const VI = "#9017e6"

const SC = "#a40522"

const PE = "#f47983"

const TU = "#20d9ba"

const GR = "#92ff93"

const RE = "#ff1993"

const BL = "#1992ff"

const SP = "#00936e"

const FA = "#ffd96a"

const OR = "#fc7f31"

function make(co::Colorant)

    "#$(hex(co, :rrggbbaa))"

end

function make(st, pr = 1)

    make(coloralpha(parse(RGB, st), pr))

end

end

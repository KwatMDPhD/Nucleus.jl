using Nucleus

# ---- #

const YC_ = "Aa", "Bb"

const XC_ = "Cc", "Dd", "Ee"

const N1 = [
    0.999 3 5
    2 4 6.001
]

# ---- #

for N2 in (N1,)

    @info Nucleus.HeatPlot.make(YC_, XC_, N2)

end

# ---- #

for N2 in (N1,)

    Nucleus.HeatPlot.writ("", YC_, XC_, N2)

end

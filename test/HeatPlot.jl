using Nucleus

# ---- #

const YC_ = "Aa", "Bb"

const XC_ = "Cc", "Dd", "Ee"

const N = [
    0.999 3 5
    2 4 6.001
]

# ---- #

for N in (N,)

    @info Nucleus.HeatPlot.make(YC_, XC_, N)

end

# ---- #

for N in (N,)

    Nucleus.HeatPlot.writ("", YC_, XC_, N)

end

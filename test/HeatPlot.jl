using Nucleus

# ---- #

const yc_ = "Aa", "Bb"

const xc_ = "Cc", "Dd", "Ee"

const N = [
    0.999 3 5
    2 4 6.001
]

# ---- #

for N in (N,)

    @info Nucleus.HeatPlot.make(yc_, xc_, N)

    Nucleus.HeatPlot.writ("", yc_, xc_, N)

end

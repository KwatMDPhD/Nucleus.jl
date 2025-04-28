using Nucleus

# ---- #
# TODO

Nucleus.HeatPlot.make

# ---- #

const N = [
    1 3 5
    2 4 6
]

for N in (N, -N)

    Nucleus.HeatPlot.writ("", ("Aa", "Bb"), ("Cc", "Dd", "Ee"), N)

end

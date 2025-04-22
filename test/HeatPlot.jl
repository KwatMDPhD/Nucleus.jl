using Nucleus

# ---- #
# TODO

Nucleus.HeatPlot.make

# ---- #

const P = [
    1 3 5
    2 4 6
]

for N in (P, -P)

    Nucleus.HeatPlot.writ("", ("Aa", "Bb"), ("Cc", "Dd", "Ee"), N)

end

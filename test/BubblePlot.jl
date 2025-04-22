using Nucleus

# ---- #

const P = [
    1 3 5
    2 4 6
] * 40

for (S, C) in ((P, P), (P, -P))

    Nucleus.BubblePlot.writ("", ("Aa", "Bb"), ("Cc", "Dd", "Ee"), S, C)

end

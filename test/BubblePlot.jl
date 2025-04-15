using Nucleus

# ---- #

const N = [
    0.999 3 5
    2 4 6.001
] * 40

for (S, C) in ((N, N), (N, reverse(N)))

    Nucleus.BubblePlot.writ("", ("Aa", "Bb"), ("Cc", "Dd", "Ee"), S, C)

end

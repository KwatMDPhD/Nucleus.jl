using Nucleus

# ---- #

const YC_ = "Aa", "Bb"

const XC_ = "Cc", "Dd", "Ee"

const S1 = [
    0.999 3 5
    2 4 6.001
]

for (S2, C) in ((S1 * 40, S1), (S1 * 40, reverse(S1)))

    Nucleus.BubblePlot.writ("", YC_, XC_, S2, C)

end

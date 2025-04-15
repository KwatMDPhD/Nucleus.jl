using Nucleus

# ---- #

const YC_ = "Aa", "Bb"

const XC_ = "Cc", "Dd", "Ee"

const S = [
    0.999 3 5
    2 4 6.001
] * 40

for (S, C) in ((S, S), (S, reverse(S)))

    Nucleus.BubblePlot.writ("", YC_, XC_, S, C)

end

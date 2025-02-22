using Nucleus

# ---- #

const yc_ = "Aa", "Bb"

const xc_ = "Cc", "Dd", "Ee"

const S = [
    0.999 3 5
    2 4 6.001
]

for (S, C) in ((S * 40, S), (S * 40, reverse(S)))

    Nucleus.BubblePlot.writ("", yc_, xc_, S, C)

end

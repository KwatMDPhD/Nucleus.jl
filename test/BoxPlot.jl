using Nucleus

# ---- #

Nucleus.BoxPlot.writ(
    "",
    ["Aa", "Bb"],
    ["Cc", "Dd", "Cc", "Dd", "Cc"],
    [
        1 3 5 7 9
        2 4 6 8 10
    ],
    "Significance",
    [0.02, 0.08],
    Dict("Cc" => "#ff0000", "Dd" => "#0000ff"),
)

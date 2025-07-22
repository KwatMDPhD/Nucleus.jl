using Nucleus

# ---- #

Nucleus.BoxPlot.writ(
    "",
    ["Aa", "Bb"],
    [
        2 4 6 8 10
        1 3 5 7 9
    ],
    "Significance",
    [0.02, 0.08],
    ("Cc", "Dd", "Cc", "Dd", "Cc"),
    ("#ff0000", "#0000ff"),
)

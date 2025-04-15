using Nucleus

# ---- #

function writ(na_, yc__)

    Nucleus.Plotly.writ(
        "",
        map((na, yc_) -> Dict("name" => na, "y" => yc_, "mode" => "lines"), na_, yc__),
    )

end

# ---- #

const I1_ = [0, 1, 2, 3, 5, 9, 5, 3, 2, 1, 0]

const I2_ = [0, 1, 2, 3, 5, 18, 7, 5, 4, 3, 2]

# ---- #

for (p1_, p2_) in ((I1_, I2_),)

    writ((1, 2, "KLD"), (p1_, p2_, map(Nucleus.Information.make, p1_, p2_)))

end

# ---- #

for (p1_, p2_) in ((I1_, I2_),)

    writ(
        (1, 2, "TD"),
        (p1_, p2_, map(Nucleus.Information.make_thermodynamic_depth, p1_, p2_)),
    )

end

# ---- #

for (p1_, p2_) in ((I1_, I2_),)

    writ(
        (1, 2, "TB"),
        (p1_, p2_, map(Nucleus.Information.make_thermodynamic_breadth, p1_, p2_)),
    )

end

# ---- #

for (p1_, p2_) in ((I1_, I2_),)

    p3_ = (p1_ + p2_) * 0.5

    writ(
        (1, 2, 3, "AKLD"),
        (
            p1_,
            p2_,
            p3_,
            map(
                Nucleus.Information.make_antisymmetric_kullback_leibler_divergence,
                p1_,
                p2_,
                p3_,
            ),
        ),
    )

end

# ---- #

for (p1_, p2_) in ((I1_, I2_),)

    p3_ = (p1_ + p2_) * 0.5

    writ(
        (1, 2, 3, "SKLD"),
        (
            p1_,
            p2_,
            p3_,
            map(
                Nucleus.Information.make_symmetric_kullback_leibler_divergence,
                p1_,
                p2_,
                p3_,
            ),
        ),
    )

end

# ---- #

for (p1_, p2_) in ((I1_, I2_),)

    writ(
        (1, 2, "JS"),
        (p1_, p2_, map(Nucleus.Information.make_jensen_shannon_divergence, p1_, p2_)),
    )

end

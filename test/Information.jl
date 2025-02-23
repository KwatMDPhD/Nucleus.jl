using Nucleus

# ---- #

function writ(na_, yc__)

    Nucleus.Plotly.writ(
        "",
        map((na, yc_) -> Dict("name" => na, "y" => yc_, "mode" => "lines"), na_, yc__),
    )

end

# ---- #

const N1_ = [0, 1, 2, 3, 5, 9, 5, 3, 2, 1, 0]

const N2_ = [0, 1, 2, 3, 5, 18, 7, 5, 4, 3, 2]

# ---- #

for (n1_, n2_) in ((N1_, N2_),)

    n3_ = map(Nucleus.Information.make, n1_, n2_)

    writ((1, 2, "KLD"), (n1_, n2_, n3_))

end

# ---- #

for (n1_, n2_) in ((N1_, N2_),)

    n3_ = map(Nucleus.Information.make_thermodynamic_depth, n1_, n2_)

    writ((1, 2, "TD"), (n1_, n2_, n3_))

end

# ---- #

for (n1_, n2_) in ((N1_, N2_),)

    n3_ = map(Nucleus.Information.make_thermodynamic_breadth, n1_, n2_)

    writ((1, 2, "TB"), (n1_, n2_, n3_))

end

# ---- #

for (n1_, n2_) in ((N1_, N2_),)

    n3_ = (n1_ + n2_) * 0.5

    n4_ = map(
        Nucleus.Information.make_antisymmetric_kullback_leibler_divergence,
        n1_,
        n2_,
        n3_,
    )

    writ((1, 2, 3, "AKLD"), (n1_, n2_, n3_, n4_))

end

# ---- #

for (n1_, n2_) in ((N1_, N2_),)

    n3_ = (n1_ + n2_) * 0.5

    n4_ = map(Nucleus.Information.make_symmetric_kullback_leibler_divergence, n1_, n2_, n3_)

    writ((1, 2, 3, "SKLD"), (n1_, n2_, n3_, n4_))

end

# ---- #

for (n1_, n2_) in ((N1_, N2_),)

    n3_ = map(Nucleus.Information.make_jensen_shannon_divergence, n1_, n2_)

    writ((1, 2, "JS"), (n1_, n2_, n3_))

end

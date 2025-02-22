using Test: @test

using Nucleus

# ---- #

function writ(na_, yc_, fu)

    Nucleus.Plotly.writ(
        "",
        map((na, yc) -> Dict("name" => na, "y" => yc, "mode" => "lines"), na_, yc_),
        Dict("title" => Dict("text" => string(fu))),
    )

end

# ---- #

for (n1_, n2_) in (([1, 2, 3], [2, 3, 4]), (rand(16), rand(16)))

    for fu in (
        Nucleus.Information.make_kullback_leibler_divergence,
        Nucleus.Information.make_thermodynamic_depth,
        Nucleus.Information.make_thermodynamic_breadth,
        Nucleus.Information.make_jensen_shannon_divergence,
    )

        writ((1, 2, "Result"), (n1_, n2_, map(fu, n1_, n2_)), fu)

    end

    for fu in (
        Nucleus.Information.make_antisymmetric_kullback_leibler_divergence,
        Nucleus.Information.make_symmetric_kullback_leibler_divergence,
    )

        n3_ = (n1_ + n2_) * 0.5

        writ((1, 2, 3, "Result"), (n1_, n2_, n3_, map(fu, n1_, n2_, n3_)), fu)

    end

end

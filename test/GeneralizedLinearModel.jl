using Test: @test

using Omics

# ---- #

for (n1_, n2_, re) in (
    (
        [1, 0, 1, 0, 1, 0],
        [2, -2, 2, -2, 2, -2],
        [
            2.350462774501466e-8,
            2.6465526525409428e-5,
            0.028938590409553988,
            0.971061409590446,
            0.9999735344734746,
            0.9999999764953722,
        ],
    ),
    (
        [0, 1, 0, 1, 0, 1],
        [2, -2, 2, -2, 2, -2],
        [
            0.9999999764953722,
            0.9999735344734746,
            0.9710614095904461,
            0.028938590409554002,
            2.6465526525409428e-5,
            2.350462774501466e-8,
        ],
    ),
    (rand(0:1, 10), randn(10), nothing),
    (rand(0:1, 100), randn(100), nothing),
    (rand(0:1, 1000), randn(1000), nothing),
    (rand(0:1, 10000), randn(10000), nothing),
)

    id_ = sortperm(n2_)

    n1_ = n1_[id_]

    n2_ = n2_[id_]

    xc_ = map(id -> "Sa$id", id_)

    p1_, p2_, p3_ = Omics.GeneralizedLinearModel.predic(
        Omics.GeneralizedLinearModel.fit(n1_, n2_),
        Omics.Grid.make(n2_, lastindex(n1_)),
    )

    if !isnothing(re)

        @test p1_ == re

    end

    Omics.GeneralizedLinearModel.plot(
        "",
        "Sample",
        xc_,
        "Target",
        n1_,
        "Feature",
        n2_,
        p1_,
        p2_,
        p3_,
    )

end

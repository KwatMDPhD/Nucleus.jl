using Random: seed!

using Statistics: cor

using Test: @test

using Omics

# ---- #

const U1 = U2 = 10

const U3 = 8

const ST = 3.0

const N1_ = rand(8)

const N = randn(U3 * 2, 8)

const N2_ = [2, 2, 1, 1]

const N3_ = [3, 3, 2, 2, 1, 1]

for (id, (nu_, N, u1, u2, u3, st)) in enumerate((
    #
    (randn(4), randn(4, 4), U1, U2, 1, ST),
    (randn(4), randn(4, 4), U1, U2, 2, ST),
    (randn(4), randn(4, 4), U1, U2, 3, ST),
    #
    (randn(1000), randn(2, 1000), U1, U2, U3, ST),
    #
    (randn(1000), randn(100, 1000), 0, 0, U3, ST),
    (randn(1000), randn(100, 1000), U1, 0, U3, ST),
    (randn(1000), randn(100, 1000), 0, U2, U3, ST),
    (randn(1000), randn(100, 1000), U1, U2, U3, ST),
    #
    (N1_, N, U1, U2, U3, 0.0),
    (N1_, N, U1, U2, U3, 1.0),
    (N1_, N, U1, U2, U3, 2.0),
    (N1_, N, U1, U2, U3, ST),
    (N1_, N, U1, U2, U3, 4.0),
    #
    (N2_, [2 1 2 1], U1, U2, U3, ST),
    (N2_, [3 2 1 3], U1, U2, U3, ST),
    #
    (N3_, [2 1 2 1 2 1], U1, U2, U3, ST),
    (N3_, [3 2 1 3 2 1], U1, U2, U3, ST),
    #
    (vcat(fill(3, 8), fill(2, 8), fill(1, 8)), randn(20, 24), U1, U2, 10, ST),
    #
    (
        [1.4, 1.3, 0.2, 0.1],
        [
            NaN NaN NaN NaN
            0 0 1 1
            1 NaN 3 4
            0.1 0.2 0.8 0.9
            0.5 0.5 0.5 0.5
            0.7 0.3 0.6 0.4
            1 2 NaN 4
            1 1 0 0
        ],
        U1,
        U2,
        U3,
        ST,
    ),
))

    R = Omics.Match.go(cor, nu_, N; u1, u2)

    Omics.MatchPlot.writ(
        joinpath(tempdir(), string(id)),
        "Sample",
        map(id -> "Sa$id", axes(N, 2)),
        "Target",
        nu_,
        "Feature",
        map(id -> "Fe$id", axes(N, 1)),
        N,
        R;
        u1 = u3,
        st,
    )

end

# ---- #

seed!(20250217)

const N4_ = rand(8)

const BU_ = Tuple{String, Vector{String}, Matrix{Float64}, Matrix{Float64}}[]

const XC_ = map(id -> "Sa$id", eachindex(N4_))

for i1 in 1:2

    N = randn(16, lastindex(N4_))

    R = Omics.Match.go(cor, N4_, N)

    ya = "Set $i1"

    yc_ = map(i2 -> "Fe$i1.$i2", axes(N, 1))

    Omics.MatchPlot.writ(
        joinpath(tempdir(), ya),
        "Sample",
        XC_,
        "Target",
        N4_,
        ya,
        yc_,
        N,
        R,
    )

    push!(BU_, (ya, yc_, N, R))

end

Omics.MatchPlot.writ(
    joinpath(tempdir(), "Set.html"),
    "Sample",
    XC_,
    "Target",
    N4_,
    BU_,
    (
        ("Set 1", ["Fe1.7", "Fe1.16"]),
        ("Set 1", ["Fe1.16", "Fe1.7"]),
        ("Set 2", ["Fe2.3", "Fe2.5", "Fe2.11"]),
    ),
)

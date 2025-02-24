using Test: @test

using Nucleus

include("_.jl")

# ---- #

const I1_ = [-1, 0, 0, 1, 1, 1, 2]

const I2_ = [1, 2, 3, 4, 5, 6, 7, 8, 9, 100]

const I3 = [
    -1 0 1 2
    0 1 1 3
]

# ---- #

# 32.570 ns (2 allocations: 144 bytes)
# 46.891 ns (2 allocations: 144 bytes)
# 32.612 ns (2 allocations: 144 bytes)
# 47.937 ns (2 allocations: 144 bytes)
# 63.138 ns (2 allocations: 144 bytes)
# 12.167 μs (5 allocations: 8.08 KiB)
# 532.125 μs (5 allocations: 78.33 KiB)

const ZE_ = zeros(Int, 10)

const ON_ = ones(Int, 10)

for (nu_, fr_, re) in (
    (ZE_, (1,), ON_),
    (ZE_, (0.5, 1), ON_),
    (I2_, (1,), ON_),
    (I2_, (0.5, 1), [1, 1, 1, 1, 1, 2, 2, 2, 2, 2]),
    (I2_, (1 / 3, 2 / 3, 1), [1, 1, 1, 1, 2, 2, 3, 3, 3, 3]),
    (randn(1000), 0:0.1:1, nothing),
    (randn(10000), 0:0.1:1, nothing),
)

    co = copy(nu_)

    Nucleus.RankNormalization.update!(co, fr_)

    #@btime Nucleus.RankNormalization.update!(co, $fr_) setup = co = copy($nu_)

    @test isnothing(re) || is_egal(co, re)

end

# ---- #

# 43.517 ns (4 allocations: 224 bytes)
# 50.303 ns (4 allocations: 288 bytes)
# 243.056 ns (6 allocations: 352 bytes)
# 14.750 μs (9 allocations: 19.94 KiB)
# 270.500 μs (9 allocations: 195.81 KiB)

for (n1_, re) in (
    (I1_, [1, 2, 2, 3, 3, 3, 4]),
    (I2_, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
    (
        I3,
        [
            1 2 3 4
            2 3 3 5
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    @test isnothing(re) || is_egal(Nucleus.RankNormalization.make_1223(n1_), re)

    #@btime Nucleus.RankNormalization.make_1223($n1_)

end

# ---- #

# 43.391 ns (4 allocations: 224 bytes)
# 50.481 ns (4 allocations: 288 bytes)
# 235.824 ns (6 allocations: 352 bytes)
# 14.250 μs (11 allocations: 27.97 KiB)
# 267.416 μs (11 allocations: 301.72 KiB)

for (n1_, re) in (
    (I1_, [1, 2, 2, 4, 4, 4, 7]),
    (I2_, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
    (
        I3,
        [
            1 2 4 7
            2 4 4 8
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    @test isnothing(re) || is_egal(Nucleus.RankNormalization.make_1224(n1_), re)

    #@btime Nucleus.RankNormalization.make_1224($n1_)

end

# ---- #

# 46.086 ns (4 allocations: 224 bytes)
# 57.165 ns (4 allocations: 288 bytes)
# 245.183 ns (6 allocations: 352 bytes)
# 15.833 μs (9 allocations: 19.94 KiB)
# 263.334 μs (9 allocations: 195.69 KiB)

for (n1_, re) in (
    (I1_, [1, 2.5, 2.5, 5, 5, 5, 7]),
    (I2_, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10.0]),
    (
        I3,
        [
            1 2.5 5 7
            2.5 5 5 8
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    @test isnothing(re) || is_egal(Nucleus.RankNormalization.make_125254(n1_), re)

    #@btime Nucleus.RankNormalization.make_125254($n1_)

end

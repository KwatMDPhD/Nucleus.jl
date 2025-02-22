using Random: seed!

using Test: @test

using Nucleus

# ---- #

const I1_ = [-1, 0, 0, 1, 1, 1, 2]

const I2_ = [1, 2, 3, 4, 5, 6, 7, 8, 9, 100]

const I3 = [
    -1 0 1 2
    0 1 1 3
]

# ---- #

# 47.022 ns (2 allocations: 144 bytes)
# 87.196 ns (2 allocations: 144 bytes)
# 44.382 ns (2 allocations: 144 bytes)
# 89.366 ns (2 allocations: 144 bytes)
# 66.342 ns (2 allocations: 144 bytes)
# 12.000 μs (5 allocations: 8.08 KiB)
# 521.750 μs (5 allocations: 78.33 KiB)

const ZE_ = zeros(Int, 10)

const ON_ = ones(Int, 10)

for (nu_, qu_, re) in (
    (ZE_, (1,), ON_),
    (ZE_, (0.5, 1), ON_),
    (I2_, (1,), ON_),
    (I2_, (0.5, 1), [1, 1, 1, 1, 1, 2, 2, 2, 2, 2]),
    (I2_, (1 / 3, 2 / 3, 1), [1, 1, 1, 1, 2, 2, 3, 3, 3, 3]),
    (randn(1000), 0:0.1:1, nothing),
    (randn(10000), 0:0.1:1, nothing),
)

    co = copy(nu_)

    Nucleus.RankNormalization.update!(co, qu_)

    #@btime Nucleus.RankNormalization.update!(co, $qu_) setup = co = copy($nu_)

    if !isnothing(re)

        @test eltype(co) == eltype(re)

        @test co == re

    end

end

# ---- #

# 45.455 ns (4 allocations: 224 bytes)
# 50.397 ns (4 allocations: 288 bytes)
# 246.687 ns (6 allocations: 352 bytes)
# 14.791 μs (11 allocations: 28.09 KiB)
# 266.292 μs (9 allocations: 195.81 KiB)

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

    n2_ = Nucleus.RankNormalization.make_1223(n1_)

    #@btime Nucleus.RankNormalization.make_1223($n1_)

    if !isnothing(re)

        @test eltype(n2_) == eltype(re)

        @test n2_ == re

    end

end

# ---- #

# 45.581 ns (4 allocations: 224 bytes)
# 50.659 ns (4 allocations: 288 bytes)
# 236.463 ns (6 allocations: 352 bytes)
# 14.167 μs (9 allocations: 19.94 KiB)
# 267.584 μs (11 allocations: 302.47 KiB)

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

    n2_ = Nucleus.RankNormalization.make_1224(n1_)

    #@btime Nucleus.RankNormalization.make_1224($n1_)

    if !isnothing(re)

        @test eltype(n2_) == eltype(re)

        @test n2_ == re

    end

end

# ---- #

# 49.975 ns (4 allocations: 224 bytes)
# 58.054 ns (4 allocations: 288 bytes)
# 246.023 ns (6 allocations: 352 bytes)
# 14.916 μs (11 allocations: 28.22 KiB)
# 269.083 μs (11 allocations: 302.84 KiB)

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

    n2_ = Nucleus.RankNormalization.make_125254(n1_)

    #@btime Nucleus.RankNormalization.make_125254($n1_)

    if !isnothing(re)

        @test eltype(n2_) == eltype(re)

        @test n2_ == re

    end

end

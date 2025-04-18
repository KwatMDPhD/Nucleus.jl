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

# 20.477 ns (2 allocations: 144 bytes)
# 27.025 ns (2 allocations: 144 bytes)
# 20.624 ns (2 allocations: 144 bytes)
# 27.234 ns (2 allocations: 144 bytes)
# 32.990 ns (2 allocations: 144 bytes)
# 7.342 μs (5 allocations: 8.20 KiB)
# 120.917 μs (5 allocations: 96.20 KiB)

const ZE_ = zeros(Int, 10)

const ON_ = ones(Int, 10)

for (nu_, pr_, re) in (
    (ZE_, (1,), ON_),
    (ZE_, (0.5, 1), ON_),
    (I2_, (1,), ON_),
    (I2_, (0.5, 1), [1, 1, 1, 1, 1, 2, 2, 2, 2, 2]),
    (I2_, (1 / 3, 2 / 3, 1), [1, 1, 1, 1, 2, 2, 3, 3, 3, 3]),
    (randn(1000), 0:0.1:1, nothing),
    (randn(10000), 0:0.1:1, nothing),
)

    co_ = copy(nu_)

    Nucleus.RankNormalization.update!(co_, pr_)

    #@btime Nucleus.RankNormalization.update!(co_, $pr_) setup = co_ = copy($nu_)

    @test isnothing(re) || is_egal(co_, re)

end

# ---- #

function test(fu, nu_, re)

    @test isnothing(re) || is_egal(fu(nu_), re)

    #@btime $fu($nu_)

end

# ---- #

# 25.770 ns (4 allocations: 224 bytes)
# 29.075 ns (4 allocations: 288 bytes)
# 142.911 ns (6 allocations: 352 bytes)
# 8.916 μs (11 allocations: 28.72 KiB)
# 119.083 μs (9 allocations: 256.19 KiB)

for (nu_, re) in (
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

    test(Nucleus.RankNormalization.make_1223, nu_, re)

end

# ---- #

# 25.519 ns (4 allocations: 224 bytes)
# 29.242 ns (4 allocations: 288 bytes)
# 143.939 ns (6 allocations: 352 bytes)
# 8.917 μs (11 allocations: 28.72 KiB)
# 131.500 μs (11 allocations: 384.22 KiB)

for (nu_, re) in (
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

    test(Nucleus.RankNormalization.make_1224, nu_, re)

end

# ---- #

# 28.141 ns (4 allocations: 224 bytes)
# 32.445 ns (4 allocations: 288 bytes)
# 146.355 ns (6 allocations: 352 bytes)
# 9.500 μs (11 allocations: 28.72 KiB)
# 121.167 μs (9 allocations: 256.19 KiB)

for (nu_, re) in (
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

    test(Nucleus.RankNormalization.make_125254, nu_, re)

end

using Test: @test

using Nucleus

include("_.jl")

# ---- #

const N1_ = [-1, 0, 0, 1, 1, 1, 2]

const N2_ = [1, 2, 3, 4, 5, 6, 7, 8, 9, 100]

const N = [
    -1 0 1 2
    0 1 1 3
]

const R1_ = randn(1000)

const R2_ = randn(10000)

# ---- #

# 20.603 ns (2 allocations: 144 bytes)
# 27.108 ns (2 allocations: 144 bytes)
# 20.603 ns (2 allocations: 144 bytes)
# 27.151 ns (2 allocations: 144 bytes)
# 32.738 ns (2 allocations: 144 bytes)
# 7.350 μs (5 allocations: 8.20 KiB)
# 140.667 μs (5 allocations: 96.20 KiB)

const N4_ = zeros(Int, 10)

const N5_ = ones(Int, 10)

for (n1_, pr_, re) in (
    (N4_, (1,), N5_),
    (N4_, (0.5, 1), N5_),
    (N2_, (1,), N5_),
    (N2_, (0.5, 1), [1, 1, 1, 1, 1, 2, 2, 2, 2, 2]),
    (N2_, (1 / 3, 2 / 3, 1), [1, 1, 1, 1, 2, 2, 3, 3, 3, 3]),
    (R1_, 0:0.1:1, nothing),
    (R2_, 0:0.1:1, nothing),
)

    co_ = copy(n1_)

    Nucleus.RankNormalization.update!(co_, pr_)

    #@btime Nucleus.RankNormalization.update!(co_, $pr_) setup = co_ = copy($n1_)

    @test isnothing(re) || is_egal(co_, re)

end

# ---- #

function test(fu, nu_, re)

    @test isnothing(re) || is_egal(fu(nu_), re)

    #@btime $fu($nu_)

end

# ---- #

const IN_ = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# ---- #

# 25.937 ns (4 allocations: 224 bytes)
# 29.188 ns (4 allocations: 288 bytes)
# 144.431 ns (6 allocations: 352 bytes)
# 9.250 μs (9 allocations: 20.19 KiB)
# 136.375 μs (9 allocations: 256.19 KiB)

for (nu_, re) in (
    (N1_, [1, 2, 2, 3, 3, 3, 4]),
    (N2_, IN_),
    (
        N,
        [
            1 2 3 4
            2 3 3 5
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RankNormalization.make_1223, nu_, re)

end

# ---- #

# 26.062 ns (4 allocations: 224 bytes)
# 29.744 ns (4 allocations: 288 bytes)
# 144.484 ns (6 allocations: 352 bytes)
# 9.208 μs (9 allocations: 20.19 KiB)
# 138.958 μs (9 allocations: 256.19 KiB)

for (nu_, re) in (
    (N1_, [1, 2, 2, 4, 4, 4, 7]),
    (N2_, IN_),
    (
        N,
        [
            1 2 4 7
            2 4 4 8
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RankNormalization.make_1224, nu_, re)

end

# ---- #

# 28.531 ns (4 allocations: 224 bytes)
# 32.654 ns (4 allocations: 288 bytes)
# 149.857 ns (6 allocations: 352 bytes)
# 9.042 μs (9 allocations: 20.19 KiB)
# 134.208 μs (9 allocations: 256.19 KiB)

for (nu_, re) in (
    (N1_, [1, 2.5, 2.5, 5, 5, 5, 7]),
    (N2_, float(IN_)),
    (
        N,
        [
            1 2.5 5 7
            2.5 5 5 8
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RankNormalization.make_125254, nu_, re)

end

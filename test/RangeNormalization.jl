using Test: @test

using Nucleus

include("_.jl")

# ---- #

const F1_ = [0, 1, 2.0]

const F2_ = [-1, 0, 0.3333333333333333, 1]

const F3 = [
    1 3 5
    2 4 6.0
]

# ---- #

function test(fu!, nu_, re)

    co_ = copy(nu_)

    fu!(co_)

    #@btime $fu!(co_) setup = co_ = copy($nu_)

    @test isnothing(re) || is_egal(co_, re)

end

# ---- #

# 3.916 ns (0 allocations: 0 bytes)
# 3.958 ns (0 allocations: 0 bytes)
# 4.416 ns (0 allocations: 0 bytes)
# 5.333 ns (0 allocations: 0 bytes)
# 681.772 ns (0 allocations: 0 bytes)
# 6.229 μs (0 allocations: 0 bytes)

for (nu_, re) in (
    ([-1, 1], [0, 2]),
    (F1_, F1_),
    (F2_, [0, 1, 1.3333333333333333, 2]),
    (
        F3,
        [
            0 2 4
            1 3 5.0
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    test(Nucleus.RangeNormalization.update_shift!, nu_, re)

end

# ---- #

# 19.998 ns (0 allocations: 0 bytes)
# 24.054 ns (0 allocations: 0 bytes)
# 3.323 μs (0 allocations: 0 bytes)
# 30.833 μs (0 allocations: 0 bytes)

for (nu_, re) in (
    (F1_, [0, 1, log2(3)]),
    (
        F3,
        [
            0 log2(3) log2(5)
            1 2 log2(6)
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    test(Nucleus.RangeNormalization.update_log2!, nu_, re)

end

# ---- #

# 17.869 ns (0 allocations: 0 bytes)
# 18.745 ns (0 allocations: 0 bytes)
# 21.104 ns (0 allocations: 0 bytes)
# 333.896 ns (0 allocations: 0 bytes)
# 2.833 μs (0 allocations: 0 bytes)

for (nu_, re) in (
    (F1_, [-1, 0, 1.0]),
    (F2_, [-1.3, -0.09999999999999999, 0.30000000000000004, 1.1000000000000003]),
    (
        F3,
        [
            -1.3363062095621219 -0.2672612419124244 0.8017837257372732
            -0.8017837257372732 0.2672612419124244 1.3363062095621219
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    test(Nucleus.RangeNormalization.update_0!, nu_, re)

end

# ---- #

# 16.266 ns (0 allocations: 0 bytes)
# 19.811 ns (0 allocations: 0 bytes)
# 26.872 ns (0 allocations: 0 bytes)
# 3.625 μs (0 allocations: 0 bytes)
# 35.292 μs (0 allocations: 0 bytes)

for (nu_, re) in (
    (F1_, [0, 0.5, 1]),
    (F2_, [0, 0.5, 0.6666666666666666, 1]),
    (
        F3,
        [
            0 0.4 0.8
            0.2 0.6000000000000001 1
        ],
    ),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    test(Nucleus.RangeNormalization.update_01!, nu_, re)

end

# ---- #

# 6.750 ns (0 allocations: 0 bytes)
# 8.958 ns (0 allocations: 0 bytes)
# 147.618 ns (0 allocations: 0 bytes)
# 1.262 μs (0 allocations: 0 bytes)

for (po_, re) in (
    (F1_, [0, 0.3333333333333333, 0.6666666666666666]),
    (
        F3,
        [
            0.047619047619047616 0.14285714285714285 0.23809523809523808
            0.09523809523809523 0.19047619047619047 0.2857142857142857
        ],
    ),
    (rand(1000), nothing),
    (rand(10000), nothing),
)

    test(Nucleus.RangeNormalization.update_sum!, po_, re)

end

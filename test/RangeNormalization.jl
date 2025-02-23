using Test: @test

using Nucleus

# ---- #

function is_egal(a1_, a2_)

    eltype(a1_) === eltype(a2_) && a1_ == a2_

end

# ---- #

const F1_ = [0, 1, 2.0]

const F2_ = [-1, 0, 0.3333333333333333, 1]

const F3 = [
    1 3 5
    2 4 6.0
]

# ---- #

# 4.875 ns (0 allocations: 0 bytes)
# 5.500 ns (0 allocations: 0 bytes)
# 6.125 ns (0 allocations: 0 bytes)
# 7.958 ns (0 allocations: 0 bytes)
# 1.054 μs (0 allocations: 0 bytes)
# 9.361 μs (0 allocations: 0 bytes)

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

    co = copy(nu_)

    Nucleus.RangeNormalization.update_shift!(co)

    #@btime Nucleus.RangeNormalization.update_shift!(co) setup = co = copy($nu_)

    @test isnothing(re) || is_egal(co, re)

end

# ---- #

# 27.554 ns (0 allocations: 0 bytes)
# 40.322 ns (0 allocations: 0 bytes)
# 5.729 μs (0 allocations: 0 bytes)
# 54.208 μs (0 allocations: 0 bytes)

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

    co = copy(nu_)

    Nucleus.RangeNormalization.update_log2!(co)

    #@btime Nucleus.RangeNormalization.update_log2!(co) setup = co = copy($nu_)

    @test isnothing(re) || is_egal(co, re)

end

# ---- #

# 25.911 ns (0 allocations: 0 bytes)
# 28.279 ns (0 allocations: 0 bytes)
# 31.742 ns (0 allocations: 0 bytes)
# 510.417 ns (0 allocations: 0 bytes)
# 4.351 μs (0 allocations: 0 bytes)

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

    co = copy(nu_)

    Nucleus.RangeNormalization.update_0!(co)

    #@btime Nucleus.RangeNormalization.update_0!(co) setup = co = copy($nu_)

    @test isnothing(re) || is_egal(co, re)

end

# ---- #

# 21.021 ns (0 allocations: 0 bytes)
# 27.249 ns (0 allocations: 0 bytes)
# 36.092 ns (0 allocations: 0 bytes)
# 5.076 μs (0 allocations: 0 bytes)
# 50.083 μs (0 allocations: 0 bytes)

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

    co = copy(nu_)

    Nucleus.RangeNormalization.update_01!(co)

    #@btime Nucleus.RangeNormalization.update_01!(co) setup = co = copy($nu_)

    @test isnothing(re) || is_egal(co, re)

end

# ---- #

# 8.625 ns (0 allocations: 0 bytes)
# 11.720 ns (0 allocations: 0 bytes)
# 231.319 ns (0 allocations: 0 bytes)
# 2.008 μs (0 allocations: 0 bytes)

for (nu_, re) in (
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

    co = copy(nu_)

    Nucleus.RangeNormalization.update_sum!(co)

    #@btime Nucleus.RangeNormalization.update_sum!(co) setup = co = copy($nu_)

    @test isnothing(re) || is_egal(co, re)

end

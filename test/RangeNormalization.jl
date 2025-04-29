using Test: @test

using Nucleus

include("_.jl")

# ---- #

const PO_ = [0, 1, 2.0]

const NU_ = [-1, 0, 0.3333333333333333, 1]

const N = [
    1 3 5
    2 4 6.0
]

const R1_ = randn(1000)

const R2_ = randn(10000)

# ---- #

function test(fu!, n1_, re)

    co_ = copy(n1_)

    fu!(co_)

    #@btime $fu!(co_) setup = co_ = copy($n1_)

    @test isnothing(re) || is_egal(co_, re)

end

# ---- #

# 3.916 ns (0 allocations: 0 bytes)
# 3.916 ns (0 allocations: 0 bytes)
# 4.375 ns (0 allocations: 0 bytes)
# 5.291 ns (0 allocations: 0 bytes)
# 687.121 ns (0 allocations: 0 bytes)
# 6.236 μs (0 allocations: 0 bytes)2 μs (0 allocations: 0 bytes)

for (nu_, re) in (
    ([-1, 1], [0, 2]),
    (PO_, PO_),
    (NU_, [0, 1, 1.3333333333333333, 2]),
    (
        N,
        [
            0 2 4
            1 3 5.0
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RangeNormalization.update_shift!, nu_, re)

end

# ---- #

# 19.957 ns (0 allocations: 0 bytes)
# 23.988 ns (0 allocations: 0 bytes)
# 3.276 μs (0 allocations: 0 bytes)
# 30.542 μs (0 allocations: 0 bytes)

const PO = log2(3)

for (nu_, re) in ((PO_, [0, 1, PO]), (
    N,
    [
        0 PO log2(5)
        1 2 log2(6)
    ],
), (R1_, nothing), (R2_, nothing))

    test(Nucleus.RangeNormalization.update_log2!, nu_, re)

end

# ---- #

# 17.869 ns (0 allocations: 0 bytes)
# 18.829 ns (0 allocations: 0 bytes)
# 21.083 ns (0 allocations: 0 bytes)
# 334.270 ns (0 allocations: 0 bytes)
# 2.838 μs (0 allocations: 0 bytes)

const N1 = 0.2672612419124244

const N2 = 0.8017837257372732

const N3 = 1.3363062095621219

for (nu_, re) in (
    (PO_, [-1, 0, 1.0]),
    (NU_, [-1.3, -0.09999999999999999, 0.30000000000000004, 1.1000000000000003]),
    (
        N,
        [
            -N3 -N1 N2
            -N2 N1 N3
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RangeNormalization.update_0!, nu_, re)

end

# ---- #

# 16.307 ns (0 allocations: 0 bytes)
# 19.790 ns (0 allocations: 0 bytes)
# 26.956 ns (0 allocations: 0 bytes)
# 3.620 μs (0 allocations: 0 bytes)
# 35.333 μs (0 allocations: 0 bytes)

for (nu_, re) in (
    (PO_, [0, 0.5, 1]),
    (NU_, [0, 0.5, 0.6666666666666666, 1]),
    (
        N,
        [
            0 0.4 0.8
            0.2 0.6000000000000001 1
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RangeNormalization.update_01!, nu_, re)

end

# ---- #

# 7.250 ns (0 allocations: 0 bytes)
# 9.042 ns (0 allocations: 0 bytes)
# 147.216 ns (0 allocations: 0 bytes)
# 1.258 μs (0 allocations: 0 bytes)

for (po_, re) in (
    (PO_, [0, 0.3333333333333333, 0.6666666666666666]),
    (
        N,
        [
            0.047619047619047616 0.14285714285714285 0.23809523809523808
            0.09523809523809523 0.19047619047619047 0.2857142857142857
        ],
    ),
    (R1_, nothing),
    (R2_, nothing),
)

    test(Nucleus.RangeNormalization.update_sum!, po_, re)

end

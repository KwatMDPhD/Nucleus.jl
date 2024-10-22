using Omics

using Test: @test

# ----------------------------------------------------------------------------------------------- #

using Distances: CorrDist, Euclidean

using Random: seed!

# ---- #

const EU = Euclidean()

const CO = CorrDist()

const IR = Omics.Distance.InformationDistance()

# ---- #

for (n1_, n2_, re) in (
    ([1, 2], [1, 2], 0.0),
    ([1, 2], [2, 1], 2.0),
    ([1, 2, 3], [1, 2, 3], 0.0),
    ([1, 2, 3], [3, 2, 1], 2.0),
    ([1, 2, 3, 4], [1, 2, 3, 4], 0.0),
    ([1, 2, 3, 4], [4, 3, 2, 1], 2.0),
)

    ir = IR(n1_, n2_)

    @test ir === re

    @test isapprox(ir, CO(n1_, n2_); atol = 1e-15)

    # 3.333 ns (0 allocations: 0 bytes)
    # 36.542 ns (4 allocations: 160 bytes)
    # 10.928 ns (0 allocations: 0 bytes)
    # 3.333 ns (0 allocations: 0 bytes)
    # 36.463 ns (4 allocations: 160 bytes)
    # 10.969 ns (0 allocations: 0 bytes)
    # 4.583 ns (0 allocations: 0 bytes)
    # 39.357 ns (4 allocations: 160 bytes)
    # 12.137 ns (0 allocations: 0 bytes)
    # 4.541 ns (0 allocations: 0 bytes)
    # 39.398 ns (4 allocations: 160 bytes)
    # 12.095 ns (0 allocations: 0 bytes)
    # 3.625 ns (0 allocations: 0 bytes)
    # 40.406 ns (4 allocations: 192 bytes)
    # 13.096 ns (0 allocations: 0 bytes)
    # 3.666 ns (0 allocations: 0 bytes)
    # 40.449 ns (4 allocations: 192 bytes)
    # 13.096 ns (0 allocations: 0 bytes)

    #@btime EU($n1_, $n2_)

    #@btime CO($n1_, $n2_)

    #@btime IR($n1_, $n2_)

end

# ---- #

for ur in (10, 100, 1000, 10000)

    seed!(20241015)

    n1_ = randn(ur)

    n2_ = randn(ur)

    # 4.250 ns (0 allocations: 0 bytes)
    # 45.370 ns (4 allocations: 288 bytes)
    # 28.583 μs (54 allocations: 43.98 KiB)
    # 16.492 ns (0 allocations: 0 bytes)
    # 104.678 ns (4 allocations: 1.81 KiB)
    # 32.708 μs (54 allocations: 45.52 KiB)
    # 149.075 ns (0 allocations: 0 bytes)
    # 723.452 ns (6 allocations: 15.88 KiB)
    # 80.000 μs (57 allocations: 59.59 KiB)
    # 1.946 μs (0 allocations: 0 bytes)
    # 6.167 μs (6 allocations: 156.38 KiB)
    # 1.032 ms (57 allocations: 200.09 KiB)

    #@btime EU($n1_, $n2_)

    #@btime CO($n1_, $n2_)

    #@btime IR($n1_, $n2_)

end

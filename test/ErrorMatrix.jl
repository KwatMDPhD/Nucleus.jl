using Test: @test

using Omics

# ---- #

# 8.000 ns (0 allocations: 0 bytes)
# 9.300 ns (0 allocations: 0 bytes)
# 5.958 ns (0 allocations: 0 bytes)
# 9.041 ns (0 allocations: 0 bytes)
# 8.000 ns (0 allocations: 0 bytes)
# 9.050 ns (0 allocations: 0 bytes)
# 7.958 ns (0 allocations: 0 bytes)
# 9.009 ns (0 allocations: 0 bytes)
# 6.000 ns (0 allocations: 0 bytes)
# 9.000 ns (0 allocations: 0 bytes)
# 6.000 ns (0 allocations: 0 bytes)
# 9.041 ns (0 allocations: 0 bytes)

const BO_ = [false, false, true, true]

const P1_ = [0, 0.4, 0.6, 1]

for (p2, re) in (
    (
        0.0,
        [
            0 2
            0 2
        ],
    ),
    (
        0.4,
        [
            1 1
            0 2
        ],
    ),
    (
        0.5,
        [
            2 0
            0 2
        ],
    ),
    (
        0.6,
        [
            2 0
            0 2
        ],
    ),
    (
        0.7,
        [
            2 0
            1 1
        ],
    ),
    (
        1.0,
        [
            2 0
            1 1
        ],
    ),
)

    E = zeros(Int, 2, 2)

    Omics.ErrorMatrix.fil!(E, BO_, P1_, p2)

    @test E == re

    Omics.ErrorMatrix.plot("", E, Omics.ErrorMatrix.summarize(E)...)

    #@btime Omics.ErrorMatrix.fil!($E, BO_, P1_, $p2)

    #@btime Omics.ErrorMatrix.summarize($E)

end

using Random: randstring

using Test: @test

using Nucleus

include("_.jl")

# ---- #

const A1_ = unique!(map(_ -> randstring(3), 1:100000))

const A2_ = unique!((map(_ -> randstring(3), 1:100)))

# ---- #

# 75.797 ns (6 allocations: 336 bytes)
# 1.587 ms (8 allocations: 82.23 KiB)

for (a1_, a2_, re) in (
    (
        ['K', 'Q', 'J', 'X', '9', '8', '7', '6', '5', '4', '3', '2', 'A'],
        ['K', 'A'],
        [
            true,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            true,
        ],
    ),
    (A1_, A2_, nothing),
)

    @test isnothing(re) || is_egal(Nucleus.Collection.is_in(a1_, a2_), re)

    #@btime Nucleus.Collection.is_in($a1_, $a2_)

end

# ---- #

# 7.916 ns (0 allocations: 0 bytes)
# 1.100 μs (0 allocations: 0 bytes)

for (a1_, a2_, re) in (
    (
        ['K', 'Q', 'J', 'X', '9', '8', '7', '6', '5', '4', '3', '2', 'A'],
        ['K', 'A'],
        [
            true,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            false,
            true,
        ],
    ),
    (A1_, A2_, Nucleus.Collection.is_in(A1_, A2_)),
)

    um = lastindex(a1_)

    bo_ = convert(Vector{Bool}, falses(um))

    di = Dict(an => id for (id, an) in enumerate(a1_))

    Nucleus.Collection.is_in!(bo_, di, a2_)

    #@btime Nucleus.Collection.is_in!(bo_, $di, $a2_) setup =
    #    bo_ = convert(Vector{Bool}, falses($um))

    @test is_egal(bo_, re)

end

# ---- #

# 165.803 ns (10 allocations: 768 bytes)
# 146.702 ns (10 allocations: 832 bytes)
# 34.167 μs (197 allocations: 35.61 KiB)
# 295.166 μs (278 allocations: 176.97 KiB)

for (an_, re) in (
    (
        ['c', 'b', 'a', 'a', 'a', 'b', 'b', 'c', 'c'],
        Dict('c' => [1, 8, 9], 'b' => [2, 6, 7], 'a' => [3, 4, 5]),
    ),
    ([1, 2, 3, 3, 2, 1], Dict(1 => [1, 6], 2 => [2, 5], 3 => [3, 4])),
    (map(_ -> randstring(1), 1:1000), nothing),
    (map(_ -> randstring(1), 1:10000), nothing),
)

    @test isnothing(re) || is_egal(Nucleus.Collection.index(an_), re)

    #@btime Nucleus.Collection.index($an_)

end

# ---- #

for (nu_, re) in (([-1, 0], (-1,)), ([0, 1], (1,)), ([-1, 0, 1], (-1, 1)))

    @test Nucleus.Collection.get_extreme(nu_) === re

end

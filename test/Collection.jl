using Random: randstring

using Test: @test

using Nucleus

include("_.jl")

# ---- #

const S1_ = ["Aa", "22", "33", "44", "55", "66", "77", "88", "99", "Xx", "Jj", "Qq", "Kk"]

const S2_ = ["Aa", "Kk", "Jo"]

const BO_ = [
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
]

const R1_ = unique!(map(_ -> randstring(3), 1:100000))

const R2_ = unique!((map(_ -> randstring(3), 1:100)))

# ---- #

# 124.123 ns (6 allocations: 400 bytes)
# 970.917 μs (8 allocations: 98.48 KiB)

for (a1_, a2_, re) in ((S1_, S2_, BO_), (R1_, R2_, nothing))

    @test isnothing(re) || is_egal(Nucleus.Collection.is_in(a1_, a2_), re)

    #@btime Nucleus.Collection.is_in($a1_, $a2_)

end

# ---- #

# 124.308 ns (4 allocations: 720 bytes)
# 21.899 ns (0 allocations: 0 bytes)
# 1.376 ms (7 allocations: 2.13 MiB)
# 727.813 ns (0 allocations: 0 bytes)

for (a1_, a2_, re) in ((S1_, S2_, BO_), (R1_, R2_, Nucleus.Collection.is_in(R1_, R2_)))

    um = lastindex(a1_)

    bo_ = fill(false, um)

    di = Dict(a1_[id] => id for id in 1:um)

    #@btime Dict($a1_[id] => id for id in 1:($um))

    Nucleus.Collection.is_in!(bo_, di, a2_)

    #@btime Nucleus.Collection.is_in!(bo_, $di, $a2_) setup = bo_ = fill(false, $um)

    @test is_egal(bo_, re)

end

# ---- #

# 99.211 ns (10 allocations: 832 bytes)
# 225.530 ns (10 allocations: 832 bytes)
# 21.208 μs (198 allocations: 35.97 KiB)
# 182.917 μs (278 allocations: 180.34 KiB)

for (an_, re) in (
    ([1, 1, 2, 2, 3, 3], Dict(1 => [1, 2], 2 => [3, 4], 3 => [5, 6])),
    (
        ["Aa", "Bb", "Cc", "Cc", "Bb", "Aa", "Aa", "Bb", "Cc"],
        Dict("Aa" => [1, 6, 7], "Bb" => [2, 5, 8], "Cc" => [3, 4, 9]),
    ),
    (map(_ -> randstring(1), 1:1000), nothing),
    (map(_ -> randstring(1), 1:10000), nothing),
)

    #@test isnothing(re) || is_egal(Nucleus.Collection.index(an_), re)

    #@btime Nucleus.Collection.index($an_)

end

# ---- #

for (nu_, re) in (([-1, 0], (-1,)), ([0, 1], (1,)), ([-1, 0, 1], (-1, 1)))

    @test Nucleus.Collection.get_extreme(nu_) === re

end

# ---- #
# TODO

Nucleus.Collection.make

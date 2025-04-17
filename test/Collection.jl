using Random: randstring

using Test: @test

using Nucleus

include("_.jl")

# ---- #

const C1_ = ["Aa", "22", "33", "44", "55", "66", "77", "88", "99", "Xx", "Jj", "Qq", "Kk"]

const C2_ = ["Aa", "Kk", "Jo"]

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

# 124.026 ns (6 allocations: 400 bytes)
# 975.416 μs (8 allocations: 98.48 KiB)

for (a1_, a2_, re) in ((C1_, C2_, BO_), (R1_, R2_, nothing))

    @test isnothing(re) || is_egal(Nucleus.Collection.is_in(a1_, a2_), re)

    #@btime Nucleus.Collection.is_in($a1_, $a2_)

end

# ---- #

# 18.161 ns (0 allocations: 0 bytes)
# 675.164 ns (0 allocations: 0 bytes)

for (a1_, a2_, re) in ((C1_, C2_, BO_), (R1_, R2_, Nucleus.Collection.is_in(R1_, R2_)))

    um = lastindex(a1_)

    bo_ = falses(um)

    di = Dict(a1_[id] => id for id in eachindex(a1_))

    Nucleus.Collection.is_in!(bo_, di, a2_)

    #@btime Nucleus.Collection.is_in!(bo_, $di, $a2_) setup = bo_ = falses($um)

    @test is_egal(bo_, re)

end

# ---- #

# 222.307 ns (10 allocations: 832 bytes)
# 100.849 ns (10 allocations: 832 bytes)
# 20.458 μs (197 allocations: 35.61 KiB)
# 182.958 μs (278 allocations: 180.34 KiB)

for (an_, re) in (
    (
        ["Cc", "Bb", "Aa", "Aa", "Aa", "Bb", "Bb", "Cc", "Cc"],
        Dict("Cc" => [1, 8, 9], "Bb" => [2, 6, 7], "Aa" => [3, 4, 5]),
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

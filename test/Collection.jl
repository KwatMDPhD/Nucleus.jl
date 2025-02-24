using Test: @test

using Nucleus

# ---- #

# 169.028 ns (10 allocations: 768 bytes)
# 146.277 ns (10 allocations: 832 bytes)
# 7.688 μs (93 allocations: 25.50 KiB)
# 118.917 μs (163 allocations: 198.72 KiB)

const CH_ = 'a':'z'

for (an_, re) in (
    (
        ['c', 'b', 'a', 'a', 'a', 'b', 'b', 'c', 'c'],
        Dict('c' => [1, 8, 9], 'b' => [2, 6, 7], 'a' => [3, 4, 5]),
    ),
    ([1, 2, 3, 3, 2, 1], Dict(1 => [1, 6], 2 => [2, 5], 3 => [3, 4])),
    (rand(CH_, 1000), nothing),
    (rand(CH_, 10000), nothing),
)

    @test isnothing(re) || Nucleus.Collection.index(an_) == re

    #@btime Nucleus.Collection.index($an_)

end

using Random: seed!

using Test: @test

using Omics

# ---- #

for (xc_, yc_, re) in (
    ([0, 0.1, 0.2], [0, 0.8, 1], 0.13),
    ([0, 0.1, 0.4, 1], [0, 0.4, 0.8, 1], 0.74),
    ([4, 6, 8], [1, 2, 3], 8),
)

    @test isapprox(Omics.Geometry.get_area(xc_, yc_), re)

end

# ---- #

# 880.509 ns (0 allocations: 0 bytes)
# 9.208 μs (0 allocations: 0 bytes)

for um in (1000, 10000)

    seed!(20250228)

    #@btime Omics.Geometry.get_area($(sort!(rand(um))), $(sort!(rand(um))))

end

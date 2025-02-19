using Test: @test

using Omics

# ---- #

for (xc_, yc_, re) in (
    ([0, 0.1, 0.2], [0, 0.8, 1], 0.13),
    ([0, 0.1, 0.4, 1], [0, 0.4, 0.8, 1], 0.74),
    ([4, 6, 8], [1, 2, 3], 8),
)

    @test isapprox(Omics.ReceiverOperatingCharacteristic.get_area(xc_, yc_), re)

end

# ---- #

# 880.596 ns (0 allocations: 0 bytes)
# 9.208 μs (0 allocations: 0 bytes)

for um in (1000, 10000)

    xc_ = sort!(rand(um))

    yc_ = sort!(rand(um))

    @info Omics.ReceiverOperatingCharacteristic.get_area(xc_, yc_)

    #@btime Omics.ReceiverOperatingCharacteristic.get_area($xc_, $yc_)

end

# ---- #

# https://www.analyticsvidhya.com/blog/2020/06/auc-roc-curve-machine-learning

# 76.939 ns (6 allocations: 272 bytes)
# 169.236 ns (6 allocations: 368 bytes)

const BO_ = false, true, true, false, true, false, false, false, true, false

const P1_ = 0.98, 0.67, 0.58, 0.78, 0.85, 0.86, 0.79, 0.89, 0.82, 0.86

for (p2_, r1, r2) in (
    ((0.6, 0.7, 0.8), [1, 1, 2 / 3], [0.75, 0.5, 0.5]),
    (
        (0.58, 0.67, 0.78, 0.79, 0.82, 0.85, 0.86, 0.89, 0.98),
        [1, 1, 1, 5 / 6, 2 / 3, 2 / 3, 2 / 3, 1 / 3, 1 / 6],
        [1, 0.75, 0.5, 0.5, 0.5, 0.25, 0, 0, 0],
    ),
)

    fp_, tp_ = Omics.ReceiverOperatingCharacteristic.line(BO_, P1_, p2_)

    #@btime Omics.ReceiverOperatingCharacteristic.line(BO_, P1_, $p2_)

    @test isapprox(fp_, r1)

    @test tp_ == r2

    Omics.ReceiverOperatingCharacteristic.plot("", p2_, fp_, tp_)

end

using StatsBase: mean

using Test: @test

using Nucleus

# ---- #

for (n1_, n2_, re) in (([-1, -1], [1, 1], 2.0),)

    @test Nucleus.PairMetric.make_mean_difference(n1_, n2_) ===
          -Nucleus.PairMetric.make_mean_difference(n2_, n1_) ===
          re

end

# ---- #

# 6.125 ns (0 allocations: 0 bytes)
# 6.125 ns (0 allocations: 0 bytes)

for (nu_, re) in (([1, 1], 0.2), ([-1, -1], 0.2))

    me = mean(nu_)

    @test Nucleus.PairMetric.make_standard_deviation(nu_, me) === re

    #@btime Nucleus.PairMetric.make_standard_deviation($nu_, $me)

end

# ---- #

# 15.113 ns (0 allocations: 0 bytes)
# 15.113 ns (0 allocations: 0 bytes)
# 15.114 ns (0 allocations: 0 bytes)
# 15.739 ns (0 allocations: 0 bytes)
# 15.739 ns (0 allocations: 0 bytes)
# 15.739 ns (0 allocations: 0 bytes)

for (n1_, n2_, re) in (
    ([1, 1], [10, 10], 4.090909090909091),
    ([1, 1], [100, 100], 4.900990099009901),
    ([1, 1], [1000, 1000], 4.99000999000999),
    ([0.1, 0.1], [1, 1], 4.090909090909091),
    ([0.1, 0.1], [10, 10], 4.900990099009901),
    ([0.1, 0.1], [100, 100], 4.99000999000999),
)

    @test Nucleus.PairMetric.make_signal_to_noise_ratio(n1_, n2_) ===
          -Nucleus.PairMetric.make_signal_to_noise_ratio(n2_, n1_) ===
          re

    #@btime Nucleus.PairMetric.make_signal_to_noise_ratio($n1_, $n2_)

end

# ---- #

# 10.176 ns (0 allocations: 0 bytes)
# 10.135 ns (0 allocations: 0 bytes)

for (n1_, n2_, re) in (([1, 1], [4, 4], 2.0), ([1, 1], [256, 256], 8.0))

    @test Nucleus.PairMetric.make_log_ratio(n1_, n2_) ===
          -Nucleus.PairMetric.make_log_ratio(n2_, n1_) ===
          re

    #@btime Nucleus.PairMetric.make_log_ratio($n1_, $n2_)

end

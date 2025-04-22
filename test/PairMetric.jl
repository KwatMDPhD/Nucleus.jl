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

for (nu_, re) in (([0, 0], 0.0), ([1, 1], 0.2))

    @test Nucleus.PairMetric.make_standard_deviation(nu_, mean(nu_)) === re

end

# ---- #

const R1_ = randn(1000)

const R2_ = randn(1000)

# ---- #

# 10.802 ns (0 allocations: 0 bytes)
# 10.802 ns (0 allocations: 0 bytes)
# 10.594 ns (0 allocations: 0 bytes)
# 10.803 ns (0 allocations: 0 bytes)
# 10.594 ns (0 allocations: 0 bytes)
# 10.594 ns (0 allocations: 0 bytes)
# 487.821 ns (0 allocations: 0 bytes)

const S1 = 4.090909090909091

const S2 = 4.900990099009901

const S3 = 4.99000999000999

for (n1_, n2_, re) in (
    ([1, 1], [10, 10], S1),
    ([1, 1], [100, 100], S2),
    ([1, 1], [1000, 1000], S3),
    ([0.1, 0.1], [1, 1], S1),
    ([0.1, 0.1], [10, 10], S2),
    ([0.1, 0.1], [100, 100], S3),
    (R1_, R2_, nothing),
)

    @test isnothing(re) ||
          Nucleus.PairMetric.make_signal_to_noise_ratio(n1_, n2_) ===
          -Nucleus.PairMetric.make_signal_to_noise_ratio(n2_, n1_) ===
          re

    #@btime Nucleus.PairMetric.make_signal_to_noise_ratio($n1_, $n2_)

end

# ---- #

# 6.583 ns (0 allocations: 0 bytes)
# 6.583 ns (0 allocations: 0 bytes)
# 126.353 ns (0 allocations: 0 bytes)

for (n1_, n2_, re) in
    (([1, 1], [4, 4], 2.0), ([1, 1], [256, 256], 8.0), (R1_, R2_, nothing))

    @test isnothing(re) ||
          Nucleus.PairMetric.make_log_ratio(n1_, n2_) ===
          -Nucleus.PairMetric.make_log_ratio(n2_, n1_) ===
          re

    #@btime Nucleus.PairMetric.make_log_ratio($n1_, $n2_)

end

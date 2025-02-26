using Test: @test

using Nucleus

# ---- #

for (um, re) in ((0, 0.1), (1, 0.1), (2, 0.2))

    @test Nucleus.Significance.make(10, um) === re

end

# ---- #

# 12.513 ns (3 allocations: 96 bytes)
# 153.606 ns (11 allocations: 512 bytes)
# 155.257 ns (11 allocations: 512 bytes)

const N1_ = [-4, -3, -2, -1, -0.0, 0, 1, 2, 3, 4]

const N2_ = [-1, -0.0, 0, 1]

const EM_ = Float64[]

const PV_ = [0.4, 0.6, 0.6, 0.7]

const QV_ = [0.7, 0.7, 0.7, 0.7]

for (eq, n1_, n2_, re) in (
    (<=, N1_, EM_, (EM_, EM_)),
    (<=, N1_, N2_, (PV_, QV_)),
    (>=, N1_, N2_, (reverse(PV_), QV_)),
)

    @test Nucleus.Significance.make(eq, n1_, n2_) == re

    #@btime Nucleus.Significance.make($eq, $n1_, $n2_)

end

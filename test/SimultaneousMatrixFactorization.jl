using Random: seed!

using Test: @test

using Omics

# ---- #

seed!(20250219)

const A1 = map(nu -> nu + 4.0, randn(10, 10))

const A2 = map(nu -> nu + 4.0, randn(10, 20))

const A3 = map(nu -> nu + 4.0, randn(20, 10))

const A4 = map(nu -> nu + 4.0, randn(20, 20))

# ---- #

# 112.676 ns (2 allocations: 64 bytes)
# 215.785 ns (2 allocations: 80 bytes)
# 215.843 ns (2 allocations: 80 bytes)
# 216.825 ns (2 allocations: 80 bytes)

for (A_, re) in (
    ((A1,), [1.0]),
    ((A1, A1), [1.0, 1.0]),
    ((A1, A1 * 0.5), [1, 2.0]),
    ((A1, A1 * 2.0), [1, 0.5]),
)

    @test Omics.SimultaneousMatrixFactorization.get_coefficient(A_) == re

    #@btime Omics.SimultaneousMatrixFactorization.get_coefficient($A_)

end

# ---- #

#┌ Info: Converged in 165.
#│   ob =
#│    2-element Vector{Float64}:
#│     0.2287788491061134
#└     0.2287788491061134
#  1.688 μs (32 allocations: 3.36 KiB)
#┌ Info: Converged in 283.
#│   ob =
#│    2-element Vector{Float64}:
#│     0.20685659396578093
#└     0.20685659396578093
#  2.514 μs (32 allocations: 4.88 KiB)
#┌ Info: Converged in 508.
#│   ob =
#│    2-element Vector{Float64}:
#│     0.2191632473429171
#└     0.2191632473429171
#  2.282 μs (32 allocations: 4.88 KiB)
#┌ Warning: Failed to converge in 1000.
#│   ob =
#│    2-element Vector{Float64}:
#│     0.277360733139824
#│     0.277360733139824
#└ @ Omics.MatrixFactorization ~/craft/to/Omics.jl/src/MatrixFactorization.jl:45
#  3.568 μs (33 allocations: 7.23 KiB)

for A in (A1, A2, A3, A4)

    u1 = 3

    to = 1e-4

    u2 = 1000

    A_ = [A, A]

    seed!(20250219)

    W0 = Omics.MatrixFactorization.initialize(A, u1)

    H0 = Omics.MatrixFactorization.initialize(u1, A)

    H0_ = [H0, copy(H0)]

    W1, H1_ =
        Omics.SimultaneousMatrixFactorization.go_wide(A_, u1; W = W0, H_ = H0_, to, u2)

    #disable_logging(Warn)
    #@btime Omics.SimultaneousMatrixFactorization.go_wide(
    #    $[A],
    #    $u1;
    #    W = $W0,
    #    H_ = $[H0_[1]],
    #    to = $to,
    #    u2 = $u2,
    #)
    #disable_logging(Debug)

    pr = joinpath(tempdir(), join(size(A), '_'))

    Omics.Plot.plot_heat_map("$pr.w1.html", W1)

    for id in eachindex(A_)

        Omics.Plot.plot_heat_map("$pr.h1.$id.html", H1_[id])

    end

end

# ---- #

A_ = [rand(20, 30), rand(20, 40), rand(20, 50)]

W1, H1_ = Omics.SimultaneousMatrixFactorization.go_wide(A_, 4)

const PR = joinpath(tempdir(), "wide")

Omics.Plot.plot_heat_map("$PR.w.html", W1)

for id in eachindex(A_)

    Omics.Plot.plot_heat_map("$PR.h.$id.html", H1_[id])

    Omics.Plot.plot_heat_map("$PR.a.$id.html", A_[id])

    Omics.Plot.plot_heat_map("$PR.b.$id.html", W1 * H1_[id])

end

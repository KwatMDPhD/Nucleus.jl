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

# 81.952 ns (2 allocations: 240 bytes)
# 180.476 ns (2 allocations: 720 bytes)
# 95.426 ns (2 allocations: 240 bytes)
# 193.176 ns (2 allocations: 720 bytes)
# 115.378 ns (2 allocations: 416 bytes)
# 297.297 ns (2 allocations: 1.38 KiB)
# 139.179 ns (2 allocations: 416 bytes)
# 321.302 ns (2 allocations: 1.38 KiB)

for A in (A1, A2, A3, A4), um in (2, 8)

    A = A * rand() * 10.0

    B =
        Omics.MatrixFactorization.initialize(A, um) *
        Omics.MatrixFactorization.initialize(um, A)

    #@btime Omics.MatrixFactorization.initialize($A, $um)

    @test isapprox(sum(A), sum(B))

end

# ---- #

#┌ Info: Converged in 153.
#└   ob = 0.22880404150224723
#  1.258 μs (15 allocations: 2.86 KiB)
#  4.048 μs (152 allocations: 10.31 KiB)
#┌ Info: Converged in 266.
#└   ob = 0.20694320802554636
#  1.879 μs (15 allocations: 4.38 KiB)
#  8.028 μs (302 allocations: 20.58 KiB)
#┌ Info: Converged in 593.
#└   ob = 0.2191871631525295
#  1.604 μs (15 allocations: 4.38 KiB)
#  5.465 μs (152 allocations: 14.53 KiB)
#┌ Warning: Failed to converge in 1000.
#│   ob = 0.27737913251853863
#└ @ Omics.MatrixFactorization ~/craft/to/Omics.jl/src/MatrixFactorization.jl:45
#  2.481 μs (16 allocations: 6.73 KiB)
#  10.833 μs (302 allocations: 29.02 KiB)

for A in (A1, A2, A3, A4)

    um = 3

    init = :custom

    seed!(20250219)

    W0 = Omics.MatrixFactorization.initialize(A, um)

    H0 = Omics.MatrixFactorization.initialize(um, A)

    alg = :multmse

    tol = 1e-4

    maxiter = 1000

    W1, H1 = Omics.MatrixFactorization.go(A, um; init, W0, H0, alg, tol, maxiter)

    #disable_logging(Warn)
    #@btime Omics.MatrixFactorization.go(
    #    $A,
    #    $um;
    #    init = $init,
    #    W0 = $W0,
    #    H0 = $H0,
    #    alg = $alg,
    #    tol = $tol,
    #    maxiter = $maxiter,
    #)
    #disable_logging(Debug)

    pr = joinpath(tempdir(), join(size(A), '_'))

    Omics.Plot.plot_heat_map("$pr.w1.html", W1)

    Omics.Plot.plot_heat_map("$pr.h1.html", H1)

    H2 = Omics.MatrixFactorization.solve(W1, A)

    #@btime Omics.MatrixFactorization.solve($W1, $A)

    Omics.Plot.plot_heat_map("$pr.h2.html", H2)

    @test isapprox(H1, H2; rtol = 1e-2)

end

using Test: @test

using Nucleus

# ---- #

for (nu, re) in ((pi, "3.1"),)

    @test Nucleus.Numbe.text(nu) === re

end

# ---- #

const MA_ = (5, 18, 40, 60, 80, Inf)

const GR_ = ("0-5", "6-18", "19-40", "41-60", "61-80", "81-")

for (nu, re) in (
    (0, "0-5"),
    (5, "0-5"),
    (6, "6-18"),
    (18, "6-18"),
    (61, "61-80"),
    (80, "61-80"),
    (81, "81-"),
)

    @test Nucleus.Numbe.ge(nu, MA_, GR_) === re

end

# ---- #

# 39.102 ns (4 allocations: 256 bytes)
# 39.985 ns (4 allocations: 256 bytes)
# 2.162 μs (12 allocations: 15.19 KiB)
# 21.167 μs (24 allocations: 243.88 KiB)

const NU_ = [-1, -0.0, 0, 1]

const NE_ = [-1.0]

const PO_ = [-0.0, 0, 1]

for (nu_, re) in (
    (NU_, (NE_, PO_)),
    (reverse(NU_), (NE_, reverse(PO_))),
    (randn(1000), nothing),
    (randn(10000), nothing),
)

    if !isnothing(re)

        @test Nucleus.Numbe.make(nu_) == re

    end

    #@btime Nucleus.Numbe.make($nu_)

end

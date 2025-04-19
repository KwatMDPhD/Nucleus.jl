using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 5.402 μs (401 allocations: 22.66 KiB)
# 5.319 μs (393 allocations: 22.21 KiB)

for (st, an, re) in (
    ("Aa", 2, Dict("Aa" => 1, "Aa.2" => 2, "Aa.3" => 2)),
    ("Bb", 2, Dict("Aa" => 1, "Bb" => 2, "Bb.2" => 2)),
)

    di = Dict("Aa" => 1)

    Nucleus.Dictionary.update!(di, st, an)

    Nucleus.Dictionary.update!(di, st, an)

    #@btime Nucleus.Dictionary.update!(di, $st, $an) setup = di = Dict("Aa" => 1) evals = 100

    @test di == re

end

# ---- #

# 290.136 ns (16 allocations: 1.50 KiB)
# 285.540 ns (16 allocations: 1.50 KiB)

const D1 = Dict("Aa" => 1, "Bb" => Dict("Cc" => 1))

const D2 = Dict("Aa" => 2, "Bb" => Dict("Cc" => 2))

for (d1, d2, re) in (
    (D1, D2, Dict("Aa" => 2, "Bb" => Dict("Cc" => 2))),
    (D2, D1, Dict("Aa" => 1, "Bb" => Dict("Cc" => 1))),
)

    @test Nucleus.Dictionary.make(d1, d2) == re

    #@btime Nucleus.Dictionary.make($d1, $d2)

end

# ---- #
# TODO

Nucleus.Dictionary.make

# ---- #

const DA = pkgdir(Nucleus, "data", "Dictionary")

for (fi, re) in (
    (
        joinpath(DA, "_.json"),
        Dict(
            "1" => "1",
            "3" => "3",
            "5" => "5",
            "7" => "7",
            "8" => 8,
            "6" => 6,
            "4" => 4,
            "2" => 2,
        ),
    ),
    (
        joinpath(DA, "_.toml"),
        Dict(
            "clients" =>
                Dict("hosts" => ["alpha", "omega"], "data" => [["gamma", "delta"], [1, 2]]),
            "servers" => Dict(
                "beta" => Dict("dc" => "eqdc10", "ip" => "10.0.0.2"),
                "alpha" => Dict("dc" => "eqdc10", "ip" => "10.0.0.1"),
            ),
            "database" => Dict(
                "enabled" => true,
                "connection_max" => 5000,
                "ports" => [8000, 8001, 8002],
                "server" => "192.168.1.1",
            ),
            "owner" => Dict("name" => "Tom Preston-Werner"),
            "title" => "TOML Example",
        ),
    ),
)

    @test Nucleus.Dictionary.rea(fi) == re

end

# ---- #

const JS = joinpath(TE, "_.json")

for di in (
    Dict(
        "1" => "1",
        "2" => 2,
        "3" => "3",
        "4" => 4,
        "5" => "5",
        "6" => 6,
        "7" => "7",
        "8" => 8,
        "9" => "9",
    ),
)

    Nucleus.Dictionary.writ(JS, di)

    @test Nucleus.Dictionary.rea(JS) == di

end

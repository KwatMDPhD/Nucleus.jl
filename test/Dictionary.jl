using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 5.563 μs (401 allocations: 22.66 KiB)
# 5.353 μs (393 allocations: 22.21 KiB)

const D1 = Dict("Aa" => 1)

for (st, an, re) in (
    ("Aa", 2, Dict("Aa" => 1, "Aa.2" => 2, "Aa.3" => 2)),
    ("Bb", 2, Dict("Aa" => 1, "Bb" => 2, "Bb.2" => 2)),
)

    di = copy(D1)

    foreach(_ -> Nucleus.Dictionary.update!(di, st, an), 1:2)

    #@btime Nucleus.Dictionary.update!(di, $st, $an) setup = di = copy(D1) evals = 100

    @test di == re

end

# ---- #

# 353.588 ns (16 allocations: 1.50 KiB)
# 353.479 ns (16 allocations: 1.50 KiB)

const D2 = Dict("Aa" => 1, "Bb" => Dict("Cc" => 1, "Dd" => 1))

const D3 = Dict("Aa" => 2, "Bb" => Dict("Cc" => 2, "Ee" => 2))

for (d1, d2, re) in (
    (D2, D3, Dict("Aa" => 2, "Bb" => Dict("Cc" => 2, "Dd" => 1, "Ee" => 2))),
    (D3, D2, Dict("Aa" => 1, "Bb" => Dict("Cc" => 1, "Dd" => 1, "Ee" => 2))),
)

    @test Nucleus.Dictionary.make(d1, d2) == re

    #@btime Nucleus.Dictionary.make($d1, $d2)

end

# ---- #
# TODO

Nucleus.Dictionary.make

# ---- #

const D4 = Dict("1" => 1, "2" => "2")

# ---- #

const DA = pkgdir(Nucleus, "data", "Dictionary")

for (fi, re) in (
    (joinpath(DA, "_.json"), D4),
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

for re in (D4,)

    Nucleus.Dictionary.writ(JS, re)

    @test is_egal(Nucleus.Dictionary.rea(JS), re)

end

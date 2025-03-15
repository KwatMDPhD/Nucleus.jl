using OrderedCollections: OrderedDict

using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 8.817 μs (401 allocations: 22.66 KiB)
# 8.614 μs (393 allocations: 22.21 KiB)

for (ke, va, re) in (
    ("Ex", 2, Dict("Ex" => 1, "Ex.2" => 2, "Ex.3" => 2)),
    ("Ne", 2, Dict("Ex" => 1, "Ne" => 2, "Ne.2" => 2)),
)

    di = Dict("Ex" => 1)

    Nucleus.Dictionary.update!(di, ke, va)

    Nucleus.Dictionary.update!(di, ke, va)

    #@btime Nucleus.Dictionary.update!(di, $ke, $va) setup = di = Dict("Ex" => 1) evals = 100

    @test di == re

end

# ---- #

# 1.575 μs (24 allocations: 1.62 KiB)
# 1.596 μs (24 allocations: 1.62 KiB)

const D1 = Dict("1A" => 1, 'B' => Dict('C' => 1, "1D" => 1))

const D2 = Dict("2A" => 2, 'B' => Dict('C' => 2, "2D" => 2))

for (d1, d2, re) in (
    (D1, D2, Dict("1A" => 1, "2A" => 2, 'B' => Dict('C' => 2, "1D" => 1, "2D" => 2))),
    (D2, D1, Dict("1A" => 1, "2A" => 2, 'B' => Dict('C' => 1, "1D" => 1, "2D" => 2))),
)

    @test Nucleus.Dictionary.make(d1, d2) == re

    #@btime Nucleus.Dictionary.make($d1, $d2)

end

# ---- #

const DA = pkgdir(Nucleus, "data", "Dictionary")

for (js, re) in (
    (
        joinpath(DA, "1.json"),
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
        joinpath(DA, "1.toml"),
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

    @test Nucleus.Dictionary.rea(js) == re

end

# ---- #

const JS = joinpath(TE, "_.json")

for re in (
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

    Nucleus.Dictionary.writ(JS, re)

    @test Nucleus.Dictionary.rea(JS) == re

end

using OrderedCollections: OrderedDict

using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 8.857 μs (401 allocations: 23.05 KiB)
# 8.582 μs (393 allocations: 22.21 KiB)

for (ke, va, re) in (
    ("Existing", 2, Dict("Existing" => 1, "Existing.2" => 2, "Existing.3" => 2)),
    ("New", 2, Dict("Existing" => 1, "New" => 2, "New.2" => 2)),
)

    di = Dict("Existing" => 1)

    Nucleus.Dictionary.update!(di, ke, va)

    Nucleus.Dictionary.update!(di, ke, va)

    #@btime Nucleus.Dictionary.update!(di, $ke, $va) setup = di = Dict("Existing" => 1) evals =
    #    100

    @test di == re

end

# ---- #

# 1.550 μs (24 allocations: 1.62 KiB)
# 1.587 μs (24 allocations: 1.62 KiB)

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

const DI = pkgdir(Nucleus, "data", "Dictionary")

for (js, re) in (
    (
        joinpath(DI, "1.json"),
        OrderedDict{String, Any}(
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
        joinpath(DI, "1.toml"),
        Dict{String, Any}(
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

    di = Nucleus.Dictionary.rea(js)

    @test typeof(di) === typeof(re)

    @test di == re

    @test di isa OrderedDict ? collect(di) == collect(re) : collect(di) != collect(re)

end

# ---- #

const JS = joinpath(TE, "_.json")

for ty in (Dict, OrderedDict)

    re = ty(
        "1" => "1",
        "2" => 2,
        "3" => "3",
        "4" => 4,
        "5" => "5",
        "6" => 6,
        "7" => "7",
        "8" => 8,
        "9" => "9",
    )

    Nucleus.Dictionary.writ(JS, re)

    di = Nucleus.Dictionary.rea(JS)

    @test typeof(di) === OrderedDict{String, Any}

    @test di == re

    @test collect(di) == collect(re)

end

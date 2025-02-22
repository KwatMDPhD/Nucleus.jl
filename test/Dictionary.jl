using OrderedCollections: OrderedDict

using Test: @test

using Nucleus

# ---- #

# 8.909 μs (401 allocations: 23.05 KiB)
# 8.540 μs (393 allocations: 22.21 KiB)

const D1 = Dict("Existing" => 1)

for (ke, va, re) in (
    ("Existing", 2, Dict("Existing" => 1, "Existing.2" => 2, "Existing.3" => 2)),
    ("New", 2, Dict("Existing" => 1, "New" => 2, "New.2" => 2)),
)

    co = copy(D1)

    Nucleus.Dictionary.update!(co, ke, va)

    Nucleus.Dictionary.update!(co, ke, va)

    #@btime Nucleus.Dictionary.update!(co, $ke, $va) setup = co = copy(D1) evals = 100

    @test co == re

end

# ---- #

# 166.181 ns (10 allocations: 768 bytes)
# 146.378 ns (10 allocations: 832 bytes)
# 7.667 μs (94 allocations: 26.95 KiB)
# 125.083 μs (163 allocations: 198.72 KiB)

for (an_, re) in (
    (
        ['c', 'b', 'a', 'a', 'a', 'b', 'b', 'c', 'c'],
        Dict('c' => [1, 8, 9], 'b' => [2, 6, 7], 'a' => [3, 4, 5]),
    ),
    ([1, 2, 3, 3, 2, 1], Dict(1 => [1, 6], 2 => [2, 5], 3 => [3, 4])),
    (rand('a':'z', 1000), nothing),
    (rand('a':'z', 10000), nothing),
)

    if !isnothing(re)

        @test Nucleus.Dictionary.index(an_) == re

    end

    #@btime Nucleus.Dictionary.index($an_)

end

# ---- #

# 1.579 μs (24 allocations: 1.62 KiB)
# 1.600 μs (24 allocations: 1.62 KiB)

const D2 = Dict("1A" => 1, 'B' => Dict('C' => 1, "1D" => 1))

const D3 = Dict("2A" => 2, 'B' => Dict('C' => 2, "2D" => 2))

for (d1, d2, re) in (
    (D2, D3, Dict("1A" => 1, "2A" => 2, 'B' => Dict('C' => 2, "1D" => 1, "2D" => 2))),
    (D3, D2, Dict("1A" => 1, "2A" => 2, 'B' => Dict('C' => 1, "1D" => 1, "2D" => 2))),
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

const JS = joinpath(tempdir(), "_.json")

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

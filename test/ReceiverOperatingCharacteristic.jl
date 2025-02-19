using Random: seed!

using Test: @test

using Omics

# ---- #

# https://www.analyticsvidhya.com/blog/2020/06/auc-roc-curve-machine-learning

# 75.489 ns (6 allocations: 272 bytes)
# 166.831 ns (6 allocations: 368 bytes)

const BO_ = false, true, true, false, true, false, false, false, true, false

const P1_ = 0.98, 0.67, 0.58, 0.78, 0.85, 0.86, 0.79, 0.89, 0.82, 0.86

for (p2_, r1, r2) in (
    ((0.6, 0.7, 0.8), [1, 1, 2 / 3], [0.75, 0.5, 0.5]),
    (
        (0.58, 0.67, 0.78, 0.79, 0.82, 0.85, 0.86, 0.89, 0.98),
        [1, 1, 1, 5 / 6, 2 / 3, 2 / 3, 2 / 3, 1 / 3, 1 / 6],
        [1, 0.75, 0.5, 0.5, 0.5, 0.25, 0, 0, 0],
    ),
)

    E_ = Vector{Matrix{Int}}(undef, lastindex(p2_))

    fp_, tp_ = Omics.ReceiverOperatingCharacteristic.line!(BO_, P1_, p2_; E_)

    #@btime Omics.ReceiverOperatingCharacteristic.line!(BO_, P1_, $p2_)

    for id in eachindex(p2_)

        pr = p2_[id]

        E = E_[id]

        Omics.ErrorMatrix.plot(
            "",
            E,
            Omics.ErrorMatrix.summarize(E)...;
            la = Dict("title" => Dict("text" => "◑ $pr")),
        )

    end

    @test isapprox(fp_, r1)

    @test tp_ == r2

    Omics.ReceiverOperatingCharacteristic.plot("", p2_, fp_, tp_)

end

using Distributions: Binomial, Normal, Poisson

using Test: @test

using Omics

# ---- #

const XC_ = [18, 19, 18, 19, 80, 81, 82, 80, 81, 82]

const YC_ = [0, 0, 0, 0, 1, 1, 1, 1, 1, 1]

const UM = 8

for (xc_, yc_, di) in (
    (XC_, YC_, Binomial()),
    (XC_, YC_, Normal()),
    (rand(UM), rand(Binomial(), UM), Binomial()),
    (rand(UM), rand(Normal(), UM), Normal()),
    (rand(UM), rand(Poisson(), UM), Poisson()),
)

    gl = Omics.GeneralizedLinearModel.fit(xc_, di, yc_)

    gr_ = Omics.Grid.make(xc_, 0.24, 100)

    e1_, e2_, e3_ = Omics.GeneralizedLinearModel.predic(gl, gr_)

    Omics.GeneralizedLinearModel.plot("", xc_, yc_, gr_, e1_, e2_, e3_; si = 8)

end

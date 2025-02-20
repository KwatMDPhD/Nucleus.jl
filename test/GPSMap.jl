using Distances: CorrDist, pairwise

using Random: seed!

using Test: @test

using Omics

# ---- #

const DI = joinpath(pkgdir(Omics), "data", "GPSMap")

# ---- #

function cluster_plot(ht, yc_, xc_, N)

    ir_ = Omics.Clustering.hierarchize(pairwise(CorrDist(), eachrow(N))).order

    ic_ = Omics.Clustering.hierarchize(pairwise(CorrDist(), eachcol(N))).order

    Omics.Plot.plot_heat_map(ht, N[ir_, ic_]; yc_ = yc_[ir_], xc_ = xc_[ic_])

end

# ---- #

ta = Omics.Table.rea(joinpath(DI, "h.tsv"))

const NO_ = ta[!, 1]

const PO_ = names(ta)[2:end]

const H = Matrix(ta[!, 2:end])

cluster_plot(joinpath(tempdir(), "h.html"), NO_, PO_, H)

# ---- #

foreach(Omics.Normalization.do_0_clamp!, eachrow(H))

foreach(Omics.RangeNormalization.do_01!, eachrow(H))

cluster_plot(joinpath(tempdir(), "h_normalized.html"), NO_, PO_, H)

# ---- #

ta = Omics.Table.rea(joinpath(DI, "grouping_x_sample_x_group.tsv"))

const GR_ = ta[!, 1]

const GP = Matrix(ta[:, 2:end])

const LA_ = GP[findfirst(==("K15"), GR_), :] .+ 1

Omics.Plot.plot_heat_map(
    joinpath(tempdir(), "h_labeled.html"),
    H;
    yc_ = NO_,
    xc_ = PO_,
    #gc_ = LA_,
)

# ---- #

const NN = pairwise(Omics.Distance.Information(), eachrow(H))

cluster_plot(joinpath(tempdir(), "distance.html"), NO_, NO_, NN)

# ---- #

seed!(202312091501)

const CN = Omics.CartesianCoordinate.ge(NN)

# ---- #

seed!(202404241617)

const AN_ = Omics.PolarCoordinate.ge!(NN)

const XY_ = map(an -> Omics.Coordinate.convert_polar_to_cartesian(an, 1.0), AN_)

const LN = [XY_[i2][i1] for i1 in 1:2, i2 in eachindex(XY_)]

# ---- #

const NP = copy(H)

NP .^= 1.5

foreach(Omics.RangeNormalization.do_sum!, eachcol(NP))

# ---- #

const CP = CN * NP

Omics.Plot.plot_heat_map(
    joinpath(tempdir(), "point_cartesian.html"),
    CP;
    yc_ = ["Y", "X"],
    xc_ = PO_,
    #gc_ = LA_,
)

# ---- #

const LP = LN * NP

Omics.Plot.plot_heat_map(
    joinpath(tempdir(), "point_polar_cartesian.html"),
    LP;
    yc_ = ["Y", "X"],
    xc_ = PO_,
    #gc_ = LA_,
)

# ---- #

const point_marker_size = 10

# ---- #

Omics.GPSMap.plot(joinpath(tempdir(), "polar_gps_map.html"), NO_, LN, PO_, LP)

# ---- #

Omics.GPSMap.plot(
    joinpath(tempdir(), "polar_gps_map.html"),
    NO_,
    LN,
    PO_,
    LP;
    nu_ = rand(lastindex(PO_)),
)

# ---- #

Omics.GPSMap.plot(joinpath(tempdir(), "polar_gps_map.html"), NO_, LN, PO_, LP; nu_ = LA_)

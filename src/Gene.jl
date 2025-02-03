module Gene

using ..Omics

const _DA = pkgdir(Omics, "data", "Gene")

const HT = joinpath(_DA, "hgnc.tsv.gz")

const ET = joinpath(_DA, "ensembl.tsv.gz")

const UT = joinpath(_DA, "uniprot.tsv.gz")

function map_hgnc(hk_)

    Omics.Ma.make(Omics.Table.rea(HT), hk_, "symbol")

end

function map_ensembl()

    Omics.Ma.make(
        Omics.Table.rea(ET),
        [
            "Transcript stable ID version",
            "Transcript stable ID",
            "Transcript name",
            "Gene stable ID version",
            "Gene stable ID",
        ],
        "Gene name",
    )

end

function map_uniprot()

    ta = Omics.Table.rea(UT)

    pr_ke = Dict{String, Dict{String, Any}}()

    pr_ = ta[!, 2]

    ke_ = names(ta)[vcat(1, 3:end)]

    va = Matrix(ta[!, ke_])

    for ip in eachindex(pr_)

        ke_va = Dict{String, Any}()

        for ik in eachindex(ke_)

            vl = va[ip, ik]

            if ismissing(vl)

                continue

            end

            ke = ke_[ik]

            ke_va[ke] = if ke == "Gene Names"

                split(vl)

            elseif ke == "Interacts with"

                split(vl, "; ")

            else

                vl

            end

        end

        pr_ke[pr_[ip][1:(end - 6)]] = ke_va

    end

    pr_ke

end

end

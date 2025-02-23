module Table

using CSV: read, write

using CodecZlib: GzipDecompressor, transcode

using DataFrames: DataFrame, insertcols!

using Mmap: mmap

using XLSX: readtable

function make(n2, n1_, n2_, A)

    insertcols!(DataFrame(A, n2_), 1, n2 => n1_)

end

function make_dictionary(an, c1_, c2)

    di = Dict{String, String}()

    K = Matrix(an[!, c1_])

    va_ = an[!, c2]

    for i1 in eachindex(va_)

        va = va_[i1]

        if ismissing(va)

            continue

        end

        for i2 in eachindex(c1_)

            ke = K[i1, i2]

            if ismissing(ke)

                continue

            end

            for sp in eachsplit(ke, '|')

                di[sp] = va

            end

        end

    end

    di

end

function rea(cs; ke_...)

    @assert isfile(cs)

    mm_ = mmap(cs)

    if endswith(cs, "gz")

        mm_ = transcode(GzipDecompressor, mm_)

    end

    read(mm_, DataFrame; ke_...)

end

function rea(xl, sh; ke_...)

    DataFrame(readtable(xl, sh; infer_eltypes = true, ke_...))

end

function writ(ts, A)

    write(ts, A; delim = '\t')

end

end

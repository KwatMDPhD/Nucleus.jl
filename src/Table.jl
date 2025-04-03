module Table

using CSV: read, write

using CodecZlib: GzipDecompressor, transcode

using DataFrames: DataFrame, insertcols!

using Mmap: mmap

using XLSX: readtable

function make(s1, s1_, s2_, A)

    insertcols!(DataFrame(A, s2_), 1, s1 => s1_)

end

function make_dictionary(A, s1_, s1)

    di = Dict{String, String}()

    S = Matrix(A[!, s1_])

    s2_ = A[!, s1]

    for i1 in axes(S, 1)

        s2 = s2_[i1]

        if ismissing(s2)

            continue

        end

        for i2 in axes(S, 2)

            s3 = S[i1, i2]

            if ismissing(s3)

                continue

            end

            for sp in eachsplit(s3, '|')

                di[sp] = s2

            end

        end

    end

    di

end

function rea(fi; ke_...)

    @assert isfile(fi)

    mm_ = mmap(fi)

    if endswith(fi, "gz")

        mm_ = transcode(GzipDecompressor, mm_)

    end

    read(mm_, DataFrame; ke_...)

end

function rea(xl, st; ke_...)

    DataFrame(readtable(xl, st; infer_eltypes = true, ke_...))

end

function writ(ts, A)

    write(ts, A; delim = '\t')

end

end

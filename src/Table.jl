module Table

using CSV: read, write

using CodecZlib: GzipDecompressor, transcode

using DataFrames: DataFrame, insertcols!

using Mmap: mmap

using XLSX: readtable

function make(st, s1_, s2_, A)

    insertcols!(DataFrame(A, s2_), 1, st => s1_)

end

function ge(A)

    st_ = names(A)

    st_[1], A[!, 1], st_[2:end], Matrix(A[!, 2:end])

end

function make_dictionary(A, st_, st)

    di = Dict{String, String}()

    S = Matrix(A[!, st_])

    st_ = A[!, st]

    for i1 in axes(S, 1)

        s1 = st_[i1]

        if ismissing(s1)

            continue

        end

        for i2 in axes(S, 2)

            s2 = S[i1, i2]

            if ismissing(s2)

                continue

            end

            for sp in eachsplit(s2, '|')

                di[sp] = s1

            end

        end

    end

    di

end

function rea(fi; ke_...)

    @assert isfile(fi) fi

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

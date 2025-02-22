module Table

using CSV: read, write

using CodecZlib: GzipDecompressor, transcode

using DataFrames: DataFrame, insertcols!

using Mmap: mmap

using XLSX: readtable

function make(n2, n1_, n2_, A)

    insertcols!(DataFrame(A, n2_), 1, n2 => n1_)

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

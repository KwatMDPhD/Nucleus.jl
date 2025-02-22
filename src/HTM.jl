module HTM

using Random: randstring

using ..Nucleus

function writ(ht, sr_, id, sc, ba = "#000000")

    if isempty(ht)

        ht = joinpath(tempdir(), "$(randstring()).html")

    end

    write(
        ht,
        """
        <!doctype html>
        <html>
          <head>
            <meta charset="utf-8" />
          </head>
        $(join(("<script src=\"$sr\"></script>" for sr in sr_), '\n'))
          <body style="margin: 0; background: $ba">
            <div id="$id" style="min-height: 100vh"></div>
          </body>
          <script>
        $sc
          </script>
        </html>""",
    )

    Nucleus.Path.rea(ht)

end

end

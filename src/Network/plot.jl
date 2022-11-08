function plot(el_, st_, la; ht = "", js = true, pn = true, bg = "#fdfdfd")

    di = "OnePiece.Network.plot.$(OnePiece.Time.stamp())"

    pr = splitext(basename(ht))[1]

    scj = ""

    if js

        scj = """
        let blj = new Blob([JSON.stringify(cy.json(), null, 2)], {type: "application/json"});
        let paj = "$pr.json";
        saveAs(blj, paj);
        """

    end

    scp = ""

    if pn

        scp = """
        let blp = cy.png({"full": true, "scale": 1.0, "bg": "$bg"});
        let pap = "$pr.png";
        saveAs(blp, pap);
        """

    end

    OnePiece.HTML.make(
        di,
        (
            "http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js",
            "https://cdn.rawgit.com/eligrey/FileSaver.js/master/dist/FileSaver.js",
            "https://cdnjs.cloudflare.com/ajax/libs/cytoscape/3.21.1/cytoscape.min.js",
        ),
        """
        var cy = cytoscape({
            container: document.getElementById("$di"),
            elements: $(write(el_)),
            style: $(write(st_)),
            layout: $(write(la)),
        });


        cy.ready(function() {
            $scj
            $scp
        });
        """,
        ht,
    )

end
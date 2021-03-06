invisible(lapply(
    X = "bcb_invalid.rda",
    FUN = function(file, url) {
        if (!file.exists(file)) {
            utils::download.file(
                url = paste(url, file, sep = "/"),
                destfile = file
            )
        }
    },
    url = "http://tests.acidgenomics.com/bcbioRNASeq/v0.2"
))

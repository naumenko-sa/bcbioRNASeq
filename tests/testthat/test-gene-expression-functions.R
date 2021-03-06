context("Gene Expression Functions")

genes <- head(rownames(bcb_small), 4L)
gene2symbol <- Gene2Symbol(bcb_small)



# plotCounts =====================================================================
test_that("plotCounts : bcbioRNASeq", {
    # facet
    p <- plotCounts(
        object = bcb_small,
        genes = genes,
        normalized = "vst",
        interestingGroups = "sampleName",
        return = "facet"
    )
    expect_is(p, "ggplot")

    # wide
    p <- plotCounts(
        object = bcb_small,
        genes = genes,
        normalized = "tpm",
        return = "wide"
    )
    expect_is(p, "ggplot")
})

test_that("plotCounts : DESeqDataSet", {
    p <- plotCounts(dds_small, genes = genes)
    expect_is(p, "ggplot")
})

test_that("plotCounts : DESeqTransform", {
    # rlog
    p <- plotCounts(rld_small, genes = genes)
    expect_is(p, "ggplot")

    # vst
    p <- plotCounts(vst_small, genes = genes)
    expect_is(p, "ggplot")
})



# plotGenderMarkers ============================================================
test_that("plotGenderMarkers : bcbioRNASeq", {
    # vst
    p <- plotGenderMarkers(bcb_small, normalized = "vst")
    expect_is(p, "ggplot")

    # tpm
    p <- plotGenderMarkers(bcb_small, normalized = "tpm")
    expect_is(p, "ggplot")
})

test_that("plotGenderMarkers : DESeqDataSet", {
    p <- plotGenderMarkers(dds_small, interestingGroups = "treatment")
    expect_is(p, "ggplot")
})

test_that("plotGenderMarkers : DESeqTransform", {
    # rlog
    p <- plotGenderMarkers(rld_small, interestingGroups = "treatment")
    expect_is(p, "ggplot")

    # vst
    p <- plotGenderMarkers(vst_small, interestingGroups = "treatment")
    expect_is(p, "ggplot")
})



# plotHeatmap ==================================================================
test_that("plotHeatmap : bcbioRNASeq", {
    genes <- head(rownames(bcb_small), n = 100L)
    p <- plotHeatmap(bcb_small[genes, ])
    expect_identical(names(p), pheatmapNames)
})

test_that("plotHeatmap : DESeqDataSet", {
    genes <- head(rownames(dds_small), n = 20L)
    p <- plotHeatmap(dds_small[genes, ])
    expect_identical(names(p), pheatmapNames)
})

## bcbioRNASeq 0.2.10 (2019-05-12)

This is a maintenance release to support the latest release of basejump.

### Updated basejump release series support

This is a significant update to bcbioRNASeq prior to the upcoming v0.3 release
series. This update provides a compatibility update for the [basejump][] v0.10
release series, whereas [bcbioRNASeq][] was previously pinned to basejump v0.7
for stability. No major changes to the code base have been applied here, and
hopefully no breaking code changes are observed in this update. If you encounter
any breaking changes, please file an issue on GitHub.

### Major changes

- Now importing bioverbs package for generics.
- Use `plotCounts` instead of `plotGene`, which is now deprecated.
- `prepareRNASeqTemplate` is deprecated in favor of `prepareTemplate`.
- `sampleData` and `tpm` method support have been removed in favor of importing
  improved code from basejump.
- Now using Docker images for Travis CI tests, since they are much faster.

### Minor changes

- All S4 methods have been split out into internal functions.
- Moved bcbioRNASeq validity method into `setClass` call.
- Miscellaneous documentation improvements. Function titles have been renamed
  into sentence case, matching Acid Genomics conventions.
- Removed defunct/deprecated functions prior to v0.2 release.
- Added periods to comments, where applicable.
- Switched back to using `str` instead of `glimpse` in working examples, since
  `glimpse` requires tibble import.
- Reworked some plots to inherit new [acidplots][] code.
- Files have been renamed in kebab/dash case instead of snake case where
  applicable. This applies mainly to the unit test files.

### R Markdown templates

- The `_setup.R` file no longer includes `library` loads in the file. Instead
  these should be declared per R Markdown template, where appropriate.
  Alternatively, the user can modify `_setup.R` manually per project, but we
  are no longer recommending default library loads in this file.
- Updated quality control template to use "object" instead of "bcb" as name.
- Updated differential expression template to support loading of either rda
  or rds files, similar to QC template.
- Updated functional analysis template. Note that GSEA ranked list now uses
  Wald test statistic instead of BH adjusted P value, which provides better
  directional ranks with fewer ties.



## bcbioRNASeq 0.2.9 (2019-05-03)

### Major changes

- Fixed a bug in internal tximport code (refer to `tximport-internal.R` file)
  where sample names can get associated with the wrong samples in experiments,
  causing samples with numbers roll over from 1 -> 10. Thanks to Richard from
  AstraZeneca for catching this.



## bcbioRNASeq 0.2.8 (2019-01-28)

- Handle correlation of PCA covariates when a numerical covariate has no
  variation.
- Handle `NA` in ribosomal RNA calculations.



## bcbioRNASeq 0.2.7 (2018-08-22)

### Minor changes

- Bug fix for `as()` coercion method support. Need to ensure
  `exportMethods(coerce)` is included in `NAMESPACE` file, otherwise
  `bcbioRNASeq` to `DESeqDataSet` coercion using `as(bcb, "DESeqDataSet")` won't
  work when called from an Rscript without the package library loaded. Thanks
  @roryk for noticing this.
- Only run rRNA plots if rRNA is detected.



## bcbioRNASeq 0.2.6 (2018-08-19)

### Major changes

- Added `transform = TRUE` argument to `[` extraction method, allowing the
  user to skip automatic [DESeq2][] transformations, which can be CPU intensive
  for large datasets.
- Switched back to using `plotMA()` instead of `plotMeanAverage()`. An MA-plot
  by definition is not a "Mean Average" plot, so this function name is
  misleading. We will keep the `plotMeanAverage()` working but it is now
  soft deprecated.
- `plotGeneSaturation()` now supports `label` argument, similar to `plotPCA()`.

### Minor changes

- Improved internal handling during `tximport()` call to handle transcript
  version mismatch with tx2gene data.frame. This can result if the bcbio
  pipeline is using an old genome build.
- Ensure `genomeBuild` is detected from [AnnotationHub][] `rowRangesMetadata` if
  applicable, and not left `NULL` in the metadata.
- Updated internal code to use `aes()` instead of `aes_string()`, which uses
  [tidyeval][] and quasiquotation.
- `plotGene()`: reduced the number of `return` options to simply "facet" and
  "wide". Previously, this also supported "grid", "list", and "markdown", but
  these were removed because they are not frequently used.
- `plotGene()`: Switched back to internal `lapply()` call instead of using
  `BiocParallel::bplapply()`. This doesn't always work perfect in an HPC
  environment (e.g. HMS O2 cluster).
- Soft deprecated `plotMeanAverage()` in favor of `plotMA()`.
- All S4 generics with method support are exported for easier lookup in the
  reference documentation.
- All function reexports have been consolidated in [bcbioBase][] package.



## bcbioRNASeq 0.2.5 (2018-06-21)

### Minor changes

- Enable support [bcbio][] integration, by modifying `bcbioRNASeq()` constructor
  to work with minimal bcbio test data.
- Switched from internal usage of `aes_()` in favor of consistent usage of
  `aes_string()`. This will make the transition to [ggplot2][] v2.3.0 easier
  in a future update.



## bcbioRNASeq 0.2.4 (2018-05-24)

### Major changes

- `aggregateReplicates()` support has been added back. This function returns
  a `RangedSummarizedExperiment` instead of a `bcbioRNASeq` object, containing
  only an aggregate raw counts matrix in the `counts` slot of `assays()`.
- The functional analysis [R Markdown][] template has been reworked to use
  `dds_file` and `organism` as new parameter arguments. We've reduced the number
  of parameters required here to run [clusterProfiler][].
- Made `alphaSummary()` defunct for `bcbioRNASeq` object, in favor of
  `DESeqDataSet` only. This function is only useful when a proper design formula
  has been defined.

### Minor changes

- `metrics()` now contains an informative error for datasets that were analyzed
  using the `fast-rnaseq` [bcbio][] pipeline.
- `DESeqDataSet` coercion from `bcbioRNASeq` object doesn't attempt to run
  `DESeq()` command any more, which was unnecessary and improves speed.
- `bcbioSingleCell()` constructor now supports `censorSamples` parameter. This
  is useful for removing known poor quality samples upon loading.
- [ggplot2][] color and fill palettes are now set `NULL` in the quality control
  functions. This behavior doesn't change the appearance of the plot colors,
  which will still default to `ggplot2::scale_colour_hue()` or
  `ggplot2::scale_fill_hue()`. The upcoming [ggplot2][] v2.3.0 update supports
  global options for color and fill palettes, so these parameters may be
  deprecated in a future release.
- Reworked the internal code for `topTables()`.

### Infrastructure changes

- Added [macOS][] testing to [Travis CI][] build checks.
- Fixed [clusterProfiler][] compilation error on [Travis CI][] by installing
  `libudunits2-dev` (Linux).



## bcbioRNASeq 0.2.3 (2018-05-10)

### Major changes

- Now recommending variance stabilizing transformation (`vst`) over `rlog`
  counts by default in plots, where applicable.

### Minor changes

- Tweaked Rory's biotype plots in QC report to match formatting conventions in
  the package. These plots are now colored.
- Added `plotDEGPCA()` to default differential expression [R Markdown][]
  template.
- `colData()` factors are correctly releveled upon object subset with `[`. This
  helps avoid unwanted downstream errors when creating a `DESeqDataSet` and
  running differential expression with [DESeq2][].
- Recommending `facet` return method by default for `plotGene()`. Updated the
  working example to reflect this.
- `metrics()` now returns `interestingGroups` column.
- `sample` label has been removed from axis title for QC plot functions.
- Now using shared [ggplot2][] convneience functions from [bcbioBase][] 0.2.10:
  `bcbio_geom_abline()`, `bcbio_geom_label()`, and `bcbio_geom_label_repel()`.
  These are also used by [bcbioSingleCell][] for improved graphical consistency.
- Removed unused internal legacy [ggplot2][] code.
- Increased [DEGreport][], [DESeq2][], and [tximport][] dependency requirements.



## bcbioRNASeq 0.2.2 (2018-04-26)

### Minor changes

- Split out assertive imports so we can pin on [bioconda][].
- Improved package documentation.
- Improved label consistency in `plotPCA()` functions to match
  `plotMeanAverage()` and `plotVolcano()`.
- Improved automatic title labeling in `plotDEGPCA()`, matching the other DEG
  functions. Also added directionality to `plotDEGPCA()`.
- Added `DESeqDataSet` method support to `plotCorrelationHeatmap()`, using the
  normalized counts.
- `reusltsTables()` now writes local files to `tempdir()` when [Dropbox][] mode
  is enabled using `dropboxDir`.



## bcbioRNASeq 0.2.1 (2018-04-24)

Last set of code fixes before F1000v2 resubmission.

### Major changes

- Added `rle` return support for `counts()`, which are calculated on the fly.
- Added `transgeneNames` and `spikeNames` support to `loadRNASeq()` function.
- `loadRNASeq()` now supports `organism = NULL` again, for datasets with poorly
  annotated genomes.
- Primary `assay()` containing raw counts is now named `counts` instead of
  `raw`, for consistency with other `SummarizedExperiment` objects (e.g.
  `DESeqDataSet`) and the [bcbioSingleCell][] S4 class definition.
- Improved internal code for `plotGene()` and `plotGenderMarkers()`.

### Minor changes

- Improved [AppVeyor CI][] support to test against bioc-devel using [R][] 3.5.
- Improved support and unit testing for `updateObject()` method.
- [DESeq2][] normalized counts are always slotted in `assays()`, even when rlog
  and vst transformations are skipped.
- Exporting `[[<-`, `assays<-`, `colData<-`, `interestingGroups<-`, and
  `metadata<-` assignment methods, to avoid unwanted coercion to
  `SummarizedExperiment`. Objects extending `RangedSummarizedExperiment`
  shouldn't be doing this, so we may need to file a bug report with Bioconductor
  or check our class definition in the package.
- Now importing specific functions from S4Vectors and methods rather than
  importing everything.
- Switched back to using `stop()`, `warning()` and `message()` rather than the
  alternate [rlang][] functions `abort()`, `warn()`, and `inform()`.
- Objects with invalid metadata now print which slots are invalid to the
  console.



## bcbioRNASeq 0.2.0 (2018-03-22)

### Major changes

- `bcbioRNASeq` S4 class object is now extending `RangedSummarizedExperiment`
  instead of `SummarizedExperiment`. Consequently, the row annotations are now
  stored in the `rowRanges` slot as `GRanges` class, instead of in the
  `rowData` slot as a `DataFrame`. The `rowData()` accessor still works and
  returns a data frame of gene/transcript annotations, but these are now
  coerced from the internally stored `GRanges`. The `GRanges` object is
  acquired automatically from [Ensembl][] using `basejump::ensembl()`. By
  default, `GRanges` are acquired from [Ensembl][] using [AnnotationHub][] and
  [ensembldb][]. Legacy GRCh37 genome build is supported using the
  [EnsDb.Hsapiens.v75][] package.
- `assays()` now only slot matrices. We've moved the [tximport][] data from
  the now defunct `bcbio()` slot to assays. This includes the `lengths` matrix
  from [tximport][]. Additionally, we are optionally slotting [DESeq2][]
  variance-stabilized counts ("`rlog`", `"vst"`). [DESeq2][] normalized counts
  and [edgeR][] TMM counts are calculated on the fly and no longer stored
  inside the `bcbioRNASeq` object.
- `colData()` now defaults to returning as `data.frame` instead of
  `DataFrame`, for easy piping to [tidyverse][] functions.
- `bcbio()` slot is now defunct.
- FASTA spike-ins (e.g. EGFP, ERCCs) can be defined using the `isSpike`
  argument during the `loadRNASeq()` data import step.
- Melted counts are now scaled to log2 in the relevant quality control
  functions rather than using log10. This applies to `plotCountsPerGene()` and
  `plotCountDensity()`. Note that we are subsetting the nonzero genes as
  defined by the raw counts here.
- Simplified internal `tximport()` code to no longer attempt to strip
  transcript versions. This is required for working with *C. elegans*
  transcripts.
- Minimal working example dataset is now derived from GSE65267, which is also
  used in the F1000 paper.
- Added `as(object, "DESeqDataSet")` coercion method support for
  `bcbioRNASeq` class. This helps us set up the differential expression
  analysis easily.
- `counts()` function now returns [DESeq2][] normalized counts (`normalized =
  TRUE`) and [edgeR][] TMM counts (`normalized = "tmm"`) on the fly, as
  suggested by the F1000 reviewers.
- Design formula can no longer be slotted into `bcbioRNASeq` object, since
  we're not stashing a `DESeqDataSet` any more.
- Updated Functional Analysis R Markdown template.

### Minor changes

- `validObject()` is now required for all plotting functions. This check is
  also called in the R Markdown template. Legacy objects can be updated using
  `updateObject()`.
- `metrics()` now returns columns sorted alphabetically.
- Added `contrastName()` as a generic function.
- `plotDEGHeatmap()` and `plotDEGPCA()` generics no longer have `counts`
  defined in the signature. The `counts` argument is now only defined in the
  methods.
- `prepareRNASeqTemplate()` has been converted from a generic to a standard
  function.
- Improved `metadata()` validity checks.
- `plotCorrelationHeatmap()` matrix method has been moved to [basejump][]
  package, for improved consistency with the other heatmap code.
- `plotGenderMarkers()` internal code has been reworked to match
  `plotGene()`.
- Default `plotMA()` appearance has changed, providing a line at the 0
  y-intercept, similar to `DESeqDataSet` method.
- Internal example datasets have been renamed (e.g. `bcb_small` instead of
  `bcb`).
- Added AppVeyor CI support for code testing on Windows.
- Made Travis CI checks stricter, added `BiocCheck()`.
- Internal `.sampleDirs()` code is now exported in [bcbioBase][] as a
  generic.
- `gene2symbol()` and `interestingGroups()` method support are now defined
  for `SummarizedExperiment` in the [bcbioBase][] package.

### Updating legacy objects < v0.2.0

- Use `updateObject()` in combination with the `rowRanges` argument, which
  requires a `GRanges` object. `GRanges` can be obtained from [Ensembl][] using
  the `basejump::ensembl()` function or the [ensembldb][] package.

### Deprecations

- `bcbio()` slot is now defunct, since we have moved all data into the
  `SummarizedExperiment` container.
- Deprecated `plot5x3Bias()` in favor of `plot5Prime3PrimeBias()`. This is
  less confusing as to what this function plots.
- `flatFiles()` has been deprecated in favor of `as(object, "list")` coercion
  method. See [bcbioBase][] package for `SummarizedExperiment`   method
  support.
- Defunct: `design()`, `download()`, `meltLog10()`, `txi()`.
- Legacy `bcbioRNADataSet` method support has been removed.



## bcbioRNASeq 0.1.8 (2018-04-03)

- Bug fix for `gene2symbol` argument not renaming rows in `plotDEGHeatmap()`.



## bcbioRNASeq 0.1.7 (2018-02-28)

- Bug fix for `[` subset method dropping metrics in metadata.
- Simplified unit testing for Dropbox mode enabled in `resultsTables()`.



## bcbioRNASeq 0.1.6 (2018-02-20)

- Bug fix for gene-to-symbol mappings in `plotDEGHeatmap()`.
- Added support for quickly plotting differentially expressed genes (DEG) in
  a PCA plot with `plotDEGPCA()`.
- Added support for Dropbox shared links to `resultsTables()`, for use with
  the [Stem Cell Commons][] database.
- Added assert checks internally for all functions.
- Improved internal code for `plotGene()` and `plotGenderMarkers()` to run
  faster.
- Deprecated data frame methods based on metrics for QC functions.



## bcbioRNASeq 0.1.5 (2018-01-31)

- Import shared dependency functions from bcbioBase instead of basejump.
- Added method support for `selectSamples()`.
- `organism` and `genomeBuild` parameters are now user-definable in the main
  `loadRNASeq()` import function.
- Fixed gene subsetting method on S4 object, which handles genes using
  `intersect()` in the featureCounts matrix.
- Removed internal `aggregateReplicates()` code. This needs to be reworked
  and added back in a future release.
- Improve method for handling a missing normalized counts matrix in the
  assays slot. This can occur when the user opts to skip the CPU-intensive
  DESeq2 normalizations.
- Improved internal code for the quality control functions. Improved the `if`
  statements to be more class specific.
- Renamed `plotCorrelationHeatmap()` `transform` argument to `normalized`,
  for consistency with the `counts()` generic.
- Added `title` support to plots, where applicable.
- Updated internal code for `plotDEGHeatmap()`.
- Updated internal marker handling code for `plotGenderMarkers()`.
- `resulsTables()` function now defaults to `summary = TRUE`.



## bcbioRNASeq 0.1.4 (2018-11-27)

- Migrated all basejump function imports to bcbioBase package.



## bcbioRNASeq 0.1.3 (2017-12-03)

- Combined examples (`bcb`, `dds`, `res`, etc.) into a single `examples`
  object. This helps avoid accidental use of example `bcb` in an analysis.
- Moved ggplot imports from `internal-ggplot.R` to above each function.
- Renamed `maxSamples` parameter in `loadRNASeq()` to `transformationLimit`.
  If there are more samples than this limit, then the DESeq2 transformations
  will be skipped. In this case, `rlog` and `vst` will not be slotted into
  `assays()`.
- Added a colData sanitization step in `loadRNASeq()` to ensure rows are in
  the same order as the columns in the counts matrix. Otherwise, DESeq will
  report an error at the `DESeqDataSetFromTximport()` step. We're also ensuring
  the factor levels get updated here.
- Now using `glimpse()` instead of `str()` in examples, where applicable.
- Added `colData<-` assignment method support. This requires a `DataFrame`
  class object. Upon assignment, the internal colData at `bcbio(object,
  "DESeqDataSet")`, `assays(object)[["rlog"]]` and `assays(object)[["vst"]]`
  are also updated to match.
- Initial assignment support for `design`, which will update the internal
  DESeqDataSet.
- Added method support for `gene2symbol()` generic, which will now return a 2
  column `data.frame` with `ensgene` and `symbol` columns. This is helpful for
  downstream gene to symbol mapping operations.
- Added working example for `interestingGroups<-` in the documentation.
- Added some code to improve factor releveling, where applicable. See
  `internal-meltLog10.R` for example.
- Now explicitly defining the custom color palettes (e.g.
  `viridis::scale_fill_viridis(discrete = TRUE)`. This makes it clearer to the
  user in the documentation where these palettes are located.
- Improved axis label support in `plotGene()`.
- `plotHeatmap()` now uses internal `gene2symbol` mappings from stashed
  annotable, instead of always querying Ensembl. The user can define custom
  mappings with the `gene2symbol` argument, if desired.
- `plotPCA()` now supports custom color palettes. The `shapes` parameter has
  been removed because it doesn't work well and is limited to datasets with few
  samples. This behavior matches the PCA functionality in DESeq2.
- Improved internal code for `plotVolcano()`. Added support for `gene2symbol`
  argument, like in `plotHeatmap()`. If left missing, the function will query
  Ensembl for the gene2symbol mappings. We're now using `data` instead of
  `stats` as the main data source.
- Improved legibility of subset method code.
- Added some additional reexports, which are used for the package
  documentation and website.
- Simplified legacy object coercion method code.
- Updated Bioconductor installation method code. We're now using the
  `dependencies` argument, which allows for automatic install of suggested
  packages along with imports.



## bcbioRNASeq 0.1.2 (2017-11-08)

- Updated package imports to match Bioconductor 3.6.
- Added support for interesting groups assignment with `interestingGroups<-`.
- Renamed `plotGeneHeatmap()` to simply `plotHeatmap()`.
- Added gender marker support for *Homo sapiens*.
- Improved support for multiple interesting groups in quality control plots.
  Now interestingGroups is defined as a column in the metrics data.frame that
  is used to specify the plot color/fill. This matches the convention in the
  bcbioSingleCell 0.0.22 update.
- Sample metadata columns are now consistently set as factors.



## bcbioRNASeq 0.1.1 (2017-10-26)

- Added support for coloring of multiple interesting groups in quality control
  plots.



## bcbioRNASeq 0.1.0 (2017-10-23)

- Updated version and author information to match the F1000 Research
  workflow.
- Added an `f1000v1` branch containing the reproducible code used to generate
  the figures in our workflow.
- Modified `plotMA()` to support vertical or horizontal layout return. Also
  added an argument to remove the color legend, which is typically not that
  informative.
- Added custom color palette support to the quality control functions.
- Upgrading from `bcbioRNADataSet` (< 0.1.0) to `bcbioRNASeq` class object is
  now possible using `as()` coercion method.
- Object oriented methods are now restricted to use `bcbioRNASeq` object.
  Legacy `bcbioRNADataSet` objects must be upgraded to `bcbioRNASeq` class.



## bcbioRNASeq 0.0.28 (2017-10-17)

- Added support for output of unstructured data inside `bcbioRNASeq` S4 object
  using `flatFiles()` function.
- Added `bcbioRNASeq` method support for `annotable()` generic.



## bcbioRNASeq 0.0.27 (2017-10-10)

- Renamed `bcbioRNADataSet` S4 class to `bcbioRNASeq`. This matches the
  naming conventions in the [bcbioSingleCell][] package.
- Renamed `loadRNASeqRun()` to simply `loadRNASeq()`.
- Switched `loadRNASeq()` from using S4 dispatch to a standard function.
- Added a parameter argument to `loadRNASeq()` that enables request of a
  specific Ensembl release version for gene annotations.
- Renamed `interestingGroup` argument in quality control functions to
  `interestingGroups` for better consistency.
- Improved handling of sample metrics in `plotPCACovariates()`.
- Added functional analysis R Markdown template.
- Offloaded some core functionality shared between [bcbioRNASeq][] and
  [bcbioSingleCell][] to the [basejump][] package. This included some code to
  handle sample metadata YAML and file loading. This helps provide a consistent
  experience across both packages.



## bcbioRNASeq 0.0.26 (2017-09-09)

- Renamed package from bcbioRnaseq to bcbioRNASeq.
- Improved website appearance.
- Added [viridis][] color palette support to quality control functions.
- Improved subset operations on `bcbioRNADataSet` object.
- Fixed setup chunk loading of `bcbioRNADataSet` in differential expression
  [R Markdown][] template.



## bcbioRNASeq 0.0.25 (2017-08-11)

- Added S4 methods support for plots, allowing the user to use either
  `bcbioRNADataSet` or a metrics `data.frame` and manual `interesting_group`
  declaration for visualization.
- Migrated function and variable names from `snake_case` to `camelCase`.
- Offloaded small RNA functionality to a separate package named
  [bcbioSmallRNA][].



## bcbioRNASeq 0.0.24 (2017-07-13)

- Reworked [R Markdown][] templates to improve YAML defaults and add more
  comments.
- Modified default path variables in `setup.R` to use `*_dir` instead of
  `*_out`.
- Updated NEWS file to use [Markdown][] syntax.



## bcbioRNASeq 0.0.23 (2017-07-03)

- Slotted `DESeqDataSet` using `design = formula(~1)` for quality control. This
  enables automatic generation of `rlog` and `vst` transformed counts.
- Documentation fixes and website updates.
- Renamed S4 class from `bcbioRnaDataSet` to `bcbioRNADataSet` (case sensitive).
- Adjusted the number of exported functions.



## bcbioRNASeq 0.0.22 (2017-06-21)

- Added [testthat][] checking with [lintr][].
- Initial setup of code coverage using [covr][].



## bcbioRNASeq 0.0.21 (2017-06-16)

- Prepared draft of [F1000][] workflow document.



## bcbioRNASeq 0.0.20 (2017-06-09)

- Added [Travis CI][] support for automatic rendering of quality control report.



## bcbioRNASeq 0.0.19 (2017-06-07)

- `bcbioRnaDataSet` S4 definition updates.
- Updates to `plot_pca()` and gene-level heatmaps.



## bcbioRNASeq 0.0.18 (2017-05-24)

- Simplified count pooling functions.



## bcbioRNASeq 0.0.17 (2017-05-21)

- Reduced number of exports and improved documentation.



## bcbioRNASeq 0.0.16 (2017-05-18)

- Draft migration of [bcbio][] run object into S4 `bcbioRnaDataSet`.
- Created a new variant of `load_run()` that saves to S4 object instead of list.



## bcbioRNASeq 0.0.15 (2017-05-15)

- Reworked and re-organized internal functions.



## bcbioRNASeq 0.0.14 (2017-05-10)

- Defaulted to loading run using project summary YAML file.
- Initial commit of [R Markdown][] templates (e.g. quality control).
- Added support for dynamic file downloads from [HBC][] website.
- Draft build of website using `pkgdown::build_site()`.



## bcbioRNASeq 0.0.13 (2017-05-08)

- Improved [RDAVIDWebService][] utility functions to work with [dplyr][] 0.6.0.



## bcbioRNASeq 0.0.12 (2017-05-01)

- Reworked metadata and summary metrics functions to obtain information from
  `project-summary.yaml` saved in the final run directory.



## bcbioRNASeq 0.0.11 (2017-04-27)

- Reduced number of depdencies.
- Initial commit of modified volcano plot from [CHBUtils][] package.
- Internal code updates for upcoming [dplyr][] 0.6.0/[tidyeval][] update.
- Updated [Ensembl][] [biomaRt][] annotations to use live site, currently
  release 88.



## bcbioRNASeq 0.0.10 (2017-04-19)

- Renamed `import_*` functions to `read_*`.



## bcbioRNASeq 0.0.9 (2017-04-13)

- Consolidated NAMESPACE imports.
- Defaulted to writing count matrices with gzip compression, to save disk space.



## bcbioRNASeq 0.0.8 (2017-04-12)

- Renamed internal parameters for better readability.
- Improved documentation and consolidate functions by group.



## bcbioRNASeq 0.0.7 (2017-04-10)

- NAMESPACE simplification using [basejump][] package.



## bcbioRNASeq 0.0.6 (2017-04-07)

- Reworked handling of plots and tables during knits.



## bcbioRNASeq 0.0.5 (2017-04-06)

- Initial commit of differential expression and gene set enrichment functions.



## bcbioRNASeq 0.0.4 (2017-04-04)

- Added [bcbio][] object integrity checks.
- Improved detection and handling of lane split samples.



## bcbioRNASeq 0.0.3 (2017-03-31)

- Reworked functions to utilize [bcbio][] list object.



## bcbioRNASeq 0.0.2 (2017-03-28)

- Added plotting functions.



## bcbioRNASeq 0.0.1 (2017-03-22)

- Start of package development.
- Initial draft release supporting automatic loading of [bcbio][] run data.



[acidplots]: https://acidplots.acidgenomics.com/
[AnnotationHub]: https://bioconductor.org/packages/AnnotationHub/
[AppVeyor CI]: https://ci.appveyor.com/
[basejump]: https://basejump.acidgenomics.com/
[bcbio]: https://github.com/chapmanb/bcbio-nextgen/
[bcbioBase]: https://bioinformatics.sph.harvard.edu/bcbioBase/
[bcbioRNASeq]: https://bioinformatics.sph.harvard.edu/bcbioRNASeq/
[bcbioSingleCell]: https://bioinformatics.sph.harvard.edu/bcbioSingleCell/
[bcbioSmallRNA]: https://github.com/lpantano/bcbioSmallRna/
[bioconda]: https://bioconda.github.io/
[Bioconductor]: https://bioconductor.org/
[biomaRt]: https://bioconductor.org/packages/biomaRt/
[bioverbs]: https://bioverbs.acidgenomics.com/
[CHBUtils]: https://github.com/hbc/CHBUtils/
[clusterProfiler]: https://bioconductor.org/packages/clusterProfiler/
[covr]: https://github.com/jimhester/covr/
[DEGreport]: https://bioconductor.org/packages/DEGreport/
[DESeq2]: https://bioconductor.org/packages/DESeq2/
[DESeqAnalysis]: https://deseqanalysis.acidgenomcis.com/
[dplyr]: https://dplyr.tidyverse.org/
[Dropbox]: https://dropbox.com/
[edgeR]: https://bioconductor.org/packages/edgeR/
[Ensembl]: https://www.ensembl.org/
[EnsDb.Hsapiens.v75]: https://bioconductor.org/packages/EnsDb.Hsapiens.v75/
[ensembldb]: https://bioconductor.org/packages/ensembldb/
[F1000]: https://f1000.com/
[F1000 workflow]: http://dx.doi.org/10.12688/f1000research.12093.2
[ggplot2]: https://ggplot2.tidyverse.org/
[HBC]: https://bioinformatics.sph.harvard.edu/
[lintr]: https://github.com/jimhester/lintr/
[macOS]: https://www.apple.com/macos/
[Markdown]: https://daringfireball.net/projects/markdown/syntax/
[R]: https://www.r-project.org/
[R Markdown]: https://rmarkdown.rstudio.com/
[RDAVIDWebService]: https://bioconductor.org/packages/RDAVIDWebService/
[rlang]: https://cran.r-project.org/package=rlang
[Stem Cell Commons]: http://stemcellcommons.org/
[testthat]: https://github.com/hadley/testthat/
[tidyeval]: http://dplyr.tidyverse.org/articles/programming.html
[tidyverse]: https://www.tidyverse.org/
[Travis CI]: https://travis-ci.org/
[tximport]: https://bioconductor.org/packages/tximport/
[viridis]: https://cran.r-project.org/web/packages/viridis/index.html
[Windows]: https://www.microsoft.com/en-us/windows/

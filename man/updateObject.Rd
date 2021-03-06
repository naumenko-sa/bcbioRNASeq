% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/updateObject-methods.R
\docType{methods}
\name{updateObject}
\alias{updateObject}
\alias{updateObject,bcbioRNASeq-method}
\title{Update an object to its current class definition}
\usage{
\S4method{updateObject}{bcbioRNASeq}(object, rowRanges = NULL)
}
\arguments{
\item{object}{Object.}

\item{rowRanges}{\code{GRanges} or \code{NULL}. Row annotations. Since we converted to
\code{RangedSummarizedExperiment} in v0.2.0, this option had to be added to
enable updating of newly required \code{\link[=rowRanges]{rowRanges()}} slot. Objects that are >=
v0.2 don't require this argument and it can be left \code{NULL}.}
}
\value{
\code{bcbioRNASeq}.
}
\description{
Update old objects created by the bcbioRNASeq package. The session
information metadata is preserved from the time when the bcbio data was
originally loaded into R.
}
\section{Legacy \code{bcbioRNADataSet} class}{

Support for \code{bcbioRNADataSet} objects was dropped in v0.2.0 of the package.
If you need to load one of these objects, please install an older release.
}

\section{Legacy objects created with \code{bcbioRnaseq}}{

The previous \code{bcbioRnaseq} package (note case) must be reinstalled to load
objects from versions <= 0.0.20. We changed the name of the package to
\code{bcbioRNASeq} starting in v0.0.21.
}

\examples{
updateObject(bcb_small)
}
\seealso{
Other S4 Object: \code{\link{bcbioRNASeq}},
  \code{\link{coerce}}, \code{\link{extract}},
  \code{\link{show}}
}
\author{
Michael Steinbaugh
}
\concept{S4 Object}

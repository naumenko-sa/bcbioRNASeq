% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/contrastName-methods.R
\docType{methods}
\name{contrastName}
\alias{contrastName}
\alias{contrastName,DESeqResults-method}
\title{Contrast name}
\usage{
contrastName(object, ...)

\S4method{contrastName}{DESeqResults}(object)
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}
}
\value{
\code{string}. Contrast name.
}
\description{
Contrast name
}
\examples{
# DESeqResults ====
contrastName(res_small)
}
\seealso{
Other Differential Expression Functions: \code{\link{alphaSummary}},
  \code{\link{plotDEGHeatmap}}, \code{\link{plotDEGPCA}},
  \code{\link{plotMA}}, \code{\link{plotVolcano}},
  \code{\link{resultsTables}}
}
\author{
Michael Steinbaugh
}
\concept{Differential Expression Functions}

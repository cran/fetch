% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/specs.R
\encoding{UTF-8}
\name{import_spec}
\alias{import_spec}
\title{Create an Import Specification}
\usage{
import_spec(..., na = NULL, trim_ws = NULL)
}
\arguments{
\item{...}{Named pairs of column names and column data types, separated
by commas.
Available types are: 'guess', 'logical', 'character', 'integer', 'numeric',
'date', 'datetime', and 'time'.  The date/time data types accept an optional
input format.  To supply the input format, append it after the data type
following an equals sign, e.g.: 'date=\%d\%b\%Y' or 
'datetime=\%d-\%m-\%Y \%H:\%M:\%S'. Default is NULL, meaning no column 
types are specified, and the function should make its best 
guess for each column.}

\item{na}{A vector of values to be treated as NA.  For example, the 
vector \code{c('', ' ')} will cause empty strings and single blanks to 
be converted to NA values. Default is NULL, meaning the value of the 
\code{na} parameter will be taken from the \code{\link{specs}} function.
Any value supplied on the \code{import_spec} function will override the 
value from the \code{specs} function.}

\item{trim_ws}{Whether or not to trim white space from the input data values.
The default is NULL, meaning the value of the \code{trim_ws} parameter
will be taken from the \code{\link{specs}} function.  Any value supplied 
on the \code{import_spec} function will override the value from the 
\code{specs} function.}
}
\value{
The import specification object. The class of the object will be 
"import_spec".
}
\description{
A function to create the import specifications for a 
particular data file.  This information can be used on the 
\code{\link{catalog}} or \code{\link{fetch}} functions to correctly assign 
the data types for 
columns on imported data. The import specifications are defined as 
name/value pairs, where the name is the column name and the value is the
data type indicator.  Available data type indicators are 
'guess', 'logical', 'character', 'integer', 'numeric',
'date', 'datetime', and 'time'.  

Also note that multiple import specifications
can be combined into a collection, and assigned to an entire catalog. 
See the \code{\link{specs}} function
for an example of using a specs collection.
}
\section{Date/Time Format Codes}{

Below are some common date formatting codes.  For a complete list,
see the documentation for the \code{\link{strptime}} function:
\itemize{
  \item{\%d = day as a number}
  \item{\%a = abbreviated weekday}
  \item{\%A = unabbreviated weekday}
  \item{\%m = month number}
  \item{\%b = abbreviated month name}
  \item{\%B = unabbreviated month name}
  \item{\%y = 2-digit year}
  \item{\%Y = 4-digit year}
  \item{\%H = hour}
  \item{\%M = minute}
  \item{\%S = second}
  \item{\%p = AM/PM indicator}
}
}

\examples{
# Get sample data directory
pkg <- system.file("extdata", package = "fetch")

# Create import spec
spc <- import_spec(TRTSDT = "date=\%d\%b\%Y",
                   TRTEDT = "date=\%d\%b\%Y")

# Create catalog without filter
ct <- catalog(pkg, engines$csv, import_specs = spc)

# Get dictionary for ADVS with Import Spec
d <- ct$ADVS

# Observe data types for TRTSDT and TRTEDT are now Dates
d[d$Column \%in\% c("TRTSDT", "TRTEDT"), ]
# data item 'ADVS': 37 cols 3617 rows
#- Engine: csv
#- Size: 1.1 Mb
#- Last Modified: 2020-09-18 14:30:22
#   Name Column Class Label Format NAs MaxChar
#16 ADVS TRTSDT  Date  <NA>     NA  54      10
#17 ADVS TRTEDT  Date  <NA>     NA 119      10

}
\seealso{
\code{\link{fetch}} to retrieve data, and 
\code{\link{specs}} for creating a collection of import specs.

Other specs: 
\code{\link{print.specs}()},
\code{\link{read.specs}()},
\code{\link{specs}()},
\code{\link{write.specs}()}
}
\concept{specs}

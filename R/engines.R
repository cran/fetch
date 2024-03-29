

# Enumerations ------------------------------------------------------------

#' @title A list of engine types
#' @encoding UTF-8
#' @description The engines enumeration contains all possible options
#' for the "engine" parameter of the \code{\link{catalog}} function.  Use
#' this enumeration to specify what kind of data you would like to load.
#' Options are: csv, dbf, rda, rds, rdata, sas7bdat, xls, xlsx, and xpt.
#' @return The engine parameter string.
#' @seealso The \code{engines} enumeration is used on the \code{\link{catalog}}
#' function.  See that function documentation for additional details.
#' @examples 
#' #' # Get data directory
#' pkg <- system.file("extdata", package = "fetch")
#' 
#' # Create catalog
#' ct <- catalog(pkg, engines$csv)
#' 
#' # Example 1: Catalog all rows
#' 
#' # View catalog
#' ct
#' # data catalog: 6 items
#' # - Source: C:/packages/fetch/inst/extdata
#' # - Engine: csv
#' # - Items:
#'   # data item 'ADAE': 56 cols 150 rows
#'   # data item 'ADEX': 17 cols 348 rows
#'   # data item 'ADPR': 37 cols 552 rows
#'   # data item 'ADPSGA': 42 cols 695 rows
#'   # data item 'ADSL': 56 cols 87 rows
#'   # data item 'ADVS': 37 cols 3617 rows
#' @export
engines <- list()

# Assign class
class(engines) <- "etype"

# Assign engine types
engines$sas7bdat <- "sas7bdat"
engines$csv <- "csv"
engines$rds <- "rds"
engines$rdata <- "rdata"
engines$xpt <- "xpt"
engines$xls <- "xls"
engines$xlsx <- "xlsx"
engines$dbf <- "dbf"
engines$rda <- "rda"



# Get Data Info -----------------------------------------------------------

#' @import utils
get_dinfo_attributes <- function(dat, fp, nm, where = NULL, top = NULL, 
                                 import_specs = NULL) {
  
  ret <- get_dictionary(dat, nm)
  
  attr(ret, "name") <- nm
  attr(ret, "path") <- fp
  if (!is.null(where))
    attr(ret, "where") <- as.character(where)
  attr(ret, "top") <- top
  attr(ret, "import_specs") <- import_specs
  attr(ret, "nrow") <- nrow(dat)
  attr(ret, "ncol") <- ncol(dat)
  ret <- as.dinfo(ret)
  
  info <- file.info(fp)
  attr(ret, "modified") <- info[1, "mtime"]
  attr(ret, "size") <- format(utils::object.size(dat), units = "auto") 
  
  
  return(ret)
  
}


get_dinfo_rds <- function(fp, nm, where = NULL, top = NULL, 
                             import_specs = NULL) {
  
  dat <- get_data_rds(fp, nm, where, top, import_specs)

  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$rds
  
  return(ret)
}


get_dinfo_rda <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  dat <- get_data_rda(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$rda
  
  return(ret)
  
}


get_dinfo_rdata <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  dat <- get_data_rda(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$rdata
  
  return(ret)
  
}

get_dinfo_csv <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  dat <- get_data_csv(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$csv
  
  
  return(ret)
}


get_dinfo_sas7bdat <- function(fp, nm, where = NULL, top = NULL, 
                               import_specs = NULL) {
  
  dat <- get_data_sas7bdat(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$sas7bdat
  
  return(ret)

}

get_dinfo_dbf <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  dat <- get_data_dbf(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$dbf
  
  return(ret)
  
}

get_dinfo_xpt <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  dat <- get_data_xpt(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$xpt
  
  return(ret)
}


get_dinfo_xlsx <- function(fp, nm, where = NULL, top = NULL, 
                           import_specs = NULL) {
  
  dat <- get_data_xlsx(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$xlsx
  
  return(ret)
  
}

get_dinfo_xls <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  dat <- get_data_xls(fp, nm, where, top, import_specs)
  
  ret <- get_dinfo_attributes(dat, fp, nm, where, top, import_specs)
  
  attr(ret, "engine") <- engines$xls
  
  return(ret)
}



# Get data --------------------------------------------------------------

#' @import common
get_data_rds <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  dat <- read_rds(fp)
  
  
  if (!is.null(import_specs))
    dat <- exec_spec(dat, import_specs, nm) 
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {

    dat <- tryCatch({subset(dat, eval(where))},
                     error = function(cond){dat}) 
  }
  
  if (!is.null(top)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }

  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  return(dat)
}

#' @import common
get_data_rda <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  # Create new environment
  erdata <- new.env()
  
  # Load file into new environment
  vrdata <- load(fp, envir = erdata)
  
  # Get file from environment into normal variable
  dat <- erdata[[vrdata[1]]]
  
  if (!is.null(import_specs))
    dat <- exec_spec(dat, import_specs, nm) 
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }

  return(dat)
}

#' @import readr
#' @import common
get_data_csv <- function(fp, nm, where = NULL, top = NULL, 
                          import_specs = NULL) {
  
  
  
  if (is.null(import_specs)) {
    
    if (!is.null(top) & is.null(where)) {
      
      dat <- read_csv(fp, col_types = cols(), n_max = top)
    
    } else {
      
      dat <- read_csv(fp, col_types = cols())
    }
    
  } else {
    
    
    tspec <- NULL
    if ("specs" %in% class(import_specs)) {
      tspec <- import_specs$specs[[nm]]
    } else if ("import_spec" %in% class(import_specs)) {
      
      tspec <- import_specs 
    }
    
    # if (is.null(tspec))
    #   dat <- read_xlsx(fp)
    # else {
      
    spcs <- get_colspec_csv(tspec$col_types)
    
    # print(spcs)
    na <- tspec$na
    if (is.null(na))
      na <- import_specs$na
    
    if (is.null(na)) 
      na <- c("", " ")
      
    tws <- tspec$trim_ws
    if (is.null(tws))
      tws <- import_specs$trim_ws
    
    if (is.null(tws)) {
      tws <- TRUE 
    }
    
    dat <- suppressWarnings(read_csv(fp,
                                     col_types = spcs,
                                     na = na,
                                     trim_ws = tws))
    
    pb <- problems(dat)
    
    if (nrow(pb) > 0) {
      pbmsg <- paste0("There were problems encountered reading in the '",
                      nm, "' data file. Run 'problems(", "$",
                      nm, ") to get ",
                      "a table of these problems.")
    
      warning(pbmsg)
    
    }
      
    
  }
  
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top) & !is.null(where)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  
  return(dat)
}


#' @import haven
#' @import common
get_data_sas7bdat <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  if (!is.null(top) & is.null(where)) {
    
    dat <- read_sas(fp, n_max = top)
    
  } else {
    
    dat <- read_sas(fp)
  
  }
  

  if (!is.null(import_specs))
    dat <- exec_spec(dat, import_specs, nm)
  else {
    spcs <- specs(na = c("", "."))
    dat <- exec_spec(dat, spcs, nm)
    
  } 
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top) & !is.null(where)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  return(dat)
}

#' @import foreign
#' @import common
get_data_dbf <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  
  dat <- read.dbf(fp)
  if (!is_tibble(dat))
    dat <- as_tibble(dat)
  
  if (!is.null(import_specs))
    dat <- exec_spec(dat, import_specs, nm) 
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  
  return(dat)
  
}

#' @import haven
#' @import common
get_data_xpt <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  if (!is.null(top) & is.null(where)) {
    
    dat <- read_xpt(fp, n_max = top)

  } else {
    
    dat <- read_xpt(fp)
  }
  
  if (!is.null(import_specs))
    dat <- exec_spec(dat, import_specs, nm)
  else {
    spcs <- specs(na = c("", "."))
    dat <- exec_spec(dat, import_specs, nm)
    
  } 
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top) & !is.null(where)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  return(dat)
}

#' @import readxl
#' @import common
get_data_xlsx <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  
  if (is.null(import_specs)) {
    if (!is.null(top) & is.null(where))
      dat <- read_xlsx(fp, n_max = top)
    else
      dat <- read_xlsx(fp)
    
  } else {
    
    tspec <- NULL
    if ("specs" %in% class(import_specs)) {
      tspec <- import_specs$specs[[nm]]
    } else if ("import_spec" %in% class(import_specs)) {
      
      tspec <- import_specs 
    }
    
    if (is.null(tspec)) {
      dat <- read_xlsx(fp)
      
    } else {
      
      typs <- tspec$col_types
      tmp <- read_xlsx(fp,
                      col_types = c("text"))
      nms <- names(tmp)
      spcs <- get_colspec_xlsx(typs, length(nms), nms)
      na <- tspec$na
      if (is.null(na))
        na <- import_specs$na
      
      if (is.null(na))
        na <- c('', ' ')
      
      tws <- tspec$trim_ws
      if (is.null(tws))
        tws <- import_specs$trim_ws
      
      if (is.null(tws))
        tws <- TRUE
      
      dat <- suppressWarnings(read_xlsx(fp,
                                       col_types = spcs,
                                       na = na,
                                       trim_ws = tws))
      
      pb <- problems(dat)
      
      if (nrow(pb) > 0) {
        pbmsg <- paste0("There were problems encountered reading in the '",
                        nm, "' data file. Run 'problems(", "$",
                        nm, ") to get ",
                        "a table of these problems.")
        
        warning(pbmsg)
        
      }
    }
  }
  
  if (!is.null(dat)) {
    
    dat <- exec_spec(dat, import_specs, nm) 
  }
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top) & !is.null(where)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  return(dat)
  
}

#' @import readxl
#' @import common
get_data_xls <- function(fp, nm, where = NULL, top = NULL, import_specs = NULL) {
  
  
  if (is.null(import_specs)) {
    
    if (!is.null(top) & is.null(where))
      dat <- read_xls(fp, n_max = top)
    else
      dat <- read_xls(fp)
    
  } else {
    
    tspec <- NULL
    if ("specs" %in% class(import_specs)) {
      tspec <- import_specs$specs[[nm]]
    } else if ("import_spec" %in% class(import_specs)) {
      
      tspec <- import_specs 
    }
    
    if (is.null(tspec)) {
      dat <- read_xls(fp)
      
    } else {

      typs <- tspec$col_types
      tmp <- read_xls(fp,
                      col_types = c("text"))
      nms <- names(tmp)
      spcs <- get_colspec_xlsx(typs, length(nms), nms)
      na <- tspec$na
      if (is.null(na))
        na <- import_specs$na
      
      if (is.null(na))
        na <- c('', ' ')
      
      tws <- tspec$trim_ws
      if (is.null(tws))
        tws <- import_specs$trim_ws
      
      if (is.null(tws))
        tws <- TRUE

      dat <- suppressWarnings(read_xls(fp,
                                       col_types = spcs,
                                       na = na,
                                       trim_ws = tws))

      pb <- problems(dat)

      if (nrow(pb) > 0) {
        pbmsg <- paste0("There were problems encountered reading in the '",
                        nm, "' data file. Run 'problems(", "$",
                        nm, ") to get ",
                        "a table of these problems.")

        warning(pbmsg)

      }
    }
    
  }
  
  if (!is.null(dat)) {
    
    dat <- exec_spec(dat, import_specs, nm) 
  }
  
  if (nrow(dat) > 0) {
    
    bdat <- dat[1, ]
  } else {
    
    bdat <- dat 
  }
  
  if (!is.null(where)) {
    
    dat <- tryCatch({subset(dat, eval(where))},
                    error = function(cond){dat}) 
    
  }
  
  if (!is.null(top) & !is.null(where)) {
    if (nrow(dat) > top)
      dat <- dat[seq(1, top), ]
    
  }
  
  if (!is.null(bdat) & !is.null(dat)) {
    dat <- copy.attributes(bdat, dat)
  }
  
  return(dat)
}





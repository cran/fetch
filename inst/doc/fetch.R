## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create catalog
#  ct <- catalog(pkg, engines$csv)
#  
#  # View catalog
#  ct
#  # data catalog: 6 items
#  # - Source: C:/packages/fetch/inst/extdata
#  # - Engine: csv
#  # - Items:
#      # data item 'ADAE': 56 cols 150 rows
#      # data item 'ADEX': 17 cols 348 rows
#      # data item 'ADPR': 37 cols 552 rows
#      # data item 'ADPSGA': 42 cols 695 rows
#      # data item 'ADSL': 56 cols 87 rows
#      # data item 'ADVS': 37 cols 3617 rows

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # View info for catalog item
#  ct$ADEX
#  # data item 'ADEX': 17 cols 348 rows
#  # - Engine: csv
#  # - Size: 70.7 Kb
#  # - Last Modified: 2020-09-18 14:30:22
#  #    Name   Column     Class Label Format NAs MaxChar
#  # 1  ADEX  STUDYID character  <NA>     NA   0       3
#  # 2  ADEX  USUBJID character  <NA>     NA   0      10
#  # 3  ADEX   SUBJID character  <NA>     NA   0       3
#  # 4  ADEX   SITEID character  <NA>     NA   0       2
#  # 5  ADEX     TRTP character  <NA>     NA   8       5
#  # 6  ADEX    TRTPN   numeric  <NA>     NA   8       1
#  # 7  ADEX     TRTA character  <NA>     NA   8       5
#  # 8  ADEX    TRTAN   numeric  <NA>     NA   8       1
#  # 9  ADEX   RANDFL character  <NA>     NA   0       1
#  # 10 ADEX    SAFFL character  <NA>     NA   0       1
#  # 11 ADEX   MITTFL character  <NA>     NA   0       1
#  # 12 ADEX  PPROTFL character  <NA>     NA   0       1
#  # 13 ADEX    PARAM character  <NA>     NA   0      45
#  # 14 ADEX  PARAMCD character  <NA>     NA   0       8
#  # 15 ADEX   PARAMN   numeric  <NA>     NA   0       1
#  # 16 ADEX     AVAL   numeric  <NA>     NA  16       4
#  # 17 ADEX AVALCAT1 character  <NA>     NA  87      10
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  
#  # Fetch data from a catalog
#  dt <- fetch(ct$ADEX)
#  
#  # View data
#  dt
#  # A tibble: 348 × 17
#  #    STUDYID USUBJID    SUBJID SITEID TRTP  TRTPN TRTA  TRTAN RANDFL SAFFL MITTFL PPROTFL
#  #    <chr>   <chr>      <chr>  <chr>  <chr> <dbl> <chr> <dbl> <chr>  <chr> <chr>  <chr>
#  #  1 ABC     ABC-01-049 049    01     ARM D     4 ARM D     4 Y      Y     Y      Y
#  #  2 ABC     ABC-01-049 049    01     ARM D     4 ARM D     4 Y      Y     Y      Y
#  #  3 ABC     ABC-01-049 049    01     ARM D     4 ARM D     4 Y      Y     Y      Y
#  #  4 ABC     ABC-01-049 049    01     ARM D     4 ARM D     4 Y      Y     Y      Y
#  #  5 ABC     ABC-01-050 050    01     ARM B     2 ARM B     2 Y      Y     Y      Y
#  #  6 ABC     ABC-01-050 050    01     ARM B     2 ARM B     2 Y      Y     Y      Y
#  #  7 ABC     ABC-01-050 050    01     ARM B     2 ARM B     2 Y      Y     Y      Y
#  #  8 ABC     ABC-01-050 050    01     ARM B     2 ARM B     2 Y      Y     Y      Y
#  #  9 ABC     ABC-01-051 051    01     ARM A     1 ARM A     1 Y      Y     Y      Y
#  # 10 ABC     ABC-01-051 051    01     ARM A     1 ARM A     1 Y      Y     Y      Y
#  #  338 more rows
#  #  5 more variables: PARAM <chr>, PARAMCD <chr>, PARAMN <dbl>, AVAL <dbl>,
#  #   AVALCAT1 <chr>
#  #  Use `print(n = ...)` to see more rows
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create catalog
#  ct <- catalog(pkg, engines$csv)
#  
#  # Subset data for a specific subject
#  dt <- fetch(ct$ADVS, where = expression(SUBJID == '049'))
#  
#  # View data subset
#  dt
#  # A tibble: 44 × 37
#  #    STUDYID USUBJID    SUBJID SITEID SRCDOM SRCVAR   SRCSEQ TRTP  TRTPN TRTA  TRTAN RANDFL
#  #    <chr>   <chr>      <chr>  <chr>  <chr>  <chr>     <dbl> <chr> <dbl> <chr> <dbl> <chr>
#  #  1 ABC     ABC-01-049 049    01     VS     VSSTRESN      9 ARM D     4 ARM D     4 Y
#  #  2 ABC     ABC-01-049 049    01     VS     VSSTRESN     41 ARM D     4 ARM D     4 Y
#  #  3 ABC     ABC-01-049 049    01     NA     NA           NA ARM D     4 ARM D     4 Y
#  #  4 ABC     ABC-01-049 049    01     VS     VSSTRESN     34 ARM D     4 ARM D     4 Y
#  #  5 ABC     ABC-01-049 049    01     VS     VSSTRESN     35 ARM D     4 ARM D     4 Y
#  #  6 ABC     ABC-01-049 049    01     VS     VSSTRESN     36 ARM D     4 ARM D     4 Y
#  #  7 ABC     ABC-01-049 049    01     VS     VSSTRESN     37 ARM D     4 ARM D     4 Y
#  #  8 ABC     ABC-01-049 049    01     VS     VSSTRESN     38 ARM D     4 ARM D     4 Y
#  #  9 ABC     ABC-01-049 049    01     VS     VSSTRESN     39 ARM D     4 ARM D     4 Y
#  # 10 ABC     ABC-01-049 049    01     VS     VSSTRESN     40 ARM D     4 ARM D     4 Y
#  #  34 more rows
#  #  25 more variables: SAFFL <chr>, MITTFL <chr>, PPROTFL <chr>, TRTSDT <chr>,
#  #   TRTEDT <chr>, ADT <chr>, ADY <dbl>, ADTF <lgl>, AVISIT <chr>, AVISITN <dbl>,
#  #   PARAM <chr>, PARAMCD <chr>, PARAMN <dbl>, PARAMTYP <chr>, AVAL <dbl>, BASE <dbl>,
#  #   CHG <dbl>, AWRANGE <chr>, AWTARGET <dbl>, AWTDIFF <dbl>, AWLO <dbl>, AWHI <dbl>,
#  #   AWU <chr>, ABLFL <chr>, ANL01FL <chr>
#  #  Use `print(n = ...)` to see more rows
#  
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create catalog
#  ct <- catalog(pkg, engines$csv)
#  
#  # Subset data for a specific subject
#  dt <- fetch(ct$ADVS, top = 5, where = expression(SUBJID == '049'))
#  
#  # View results
#  dt
#  # A tibble: 5 × 37
#  #   STUDYID USUBJID  SUBJID SITEID SRCDOM SRCVAR SRCSEQ TRTP  TRTPN TRTA  TRTAN RANDFL SAFFL
#  #   <chr>   <chr>    <chr>  <chr>  <chr>  <chr>   <dbl> <chr> <dbl> <chr> <dbl> <chr>  <chr>
#  # 1 ABC     ABC-01-… 049    01     VS     VSSTR…      9 ARM D     4 ARM D     4 Y      Y
#  # 2 ABC     ABC-01-… 049    01     VS     VSSTR…     41 ARM D     4 ARM D     4 Y      Y
#  # 3 ABC     ABC-01-… 049    01     NA     NA         NA ARM D     4 ARM D     4 Y      Y
#  # 4 ABC     ABC-01-… 049    01     VS     VSSTR…     34 ARM D     4 ARM D     4 Y      Y
#  # 5 ABC     ABC-01-… 049    01     VS     VSSTR…     35 ARM D     4 ARM D     4 Y      Y
#  #   24 more variables: MITTFL <chr>, PPROTFL <chr>, TRTSDT <chr>, TRTEDT <chr>,
#  #   ADT <chr>, ADY <dbl>, ADTF <lgl>, AVISIT <chr>, AVISITN <dbl>, PARAM <chr>,
#  #   PARAMCD <chr>, PARAMN <dbl>, PARAMTYP <chr>, AVAL <dbl>, BASE <dbl>, CHG <dbl>,
#  #   AWRANGE <chr>, AWTARGET <dbl>, AWTDIFF <dbl>, AWLO <dbl>, AWHI <dbl>, AWU <chr>,
#  #   ABLFL <chr>, ANL01FL <chr>
#  
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create catalog, applying pattern to dataset names
#  ct <- catalog(pkg, engines$csv, pattern = "*S*")
#  
#  # View catalog
#  ct
#  # data catalog: 3 items
#  # - Source: C:/packages/fetch/inst/extdata
#  # - Engine: csv
#  # - Pattern: *S*
#  # - Items:
#  # data item 'ADPSGA': 42 cols 695 rows
#  # data item 'ADSL': 56 cols 87 rows
#  # data item 'ADVS': 37 cols 3617 rows
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create catalog without where expression
#  ct1 <- catalog(pkg, engines$csv)
#  
#  # View catalog
#  ct1
#  # data catalog: 6 items
#  # - Source: C:/packages/fetch/inst/extdata
#  # - Engine: csv
#  # - Items:
#  # data item 'ADAE': 56 cols 150 rows
#  # data item 'ADEX': 17 cols 348 rows
#  # data item 'ADPR': 37 cols 552 rows
#  # data item 'ADPSGA': 42 cols 695 rows
#  # data item 'ADSL': 56 cols 87 rows
#  # data item 'ADVS': 37 cols 3617 rows
#  
#  # Create catalog with where expression
#  ct2 <- catalog(pkg, engines$csv, where = expression(SUBJID == '049'))
#  
#  # View catalog
#  ct2
#  # data catalog: 6 items
#  # - Source: C:/packages/fetch/inst/extdata
#  # - Engine: csv
#  # - Where: SUBJID == "049"
#  # - Items:
#  # # data item 'ADAE': 56 cols 5 rows
#  # - Where: SUBJID == "049"
#  # # data item 'ADEX': 17 cols 4 rows
#  # - Where: SUBJID == "049"
#  # # data item 'ADPR': 37 cols 7 rows
#  # - Where: SUBJID == "049"
#  # # data item 'ADPSGA': 42 cols 10 rows
#  # - Where: SUBJID == "049"
#  # # data item 'ADSL': 56 cols 1 rows
#  # - Where: SUBJID == "049"
#  # # data item 'ADVS': 37 cols 44 rows
#  # - Where: SUBJID == "049"

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Subset data for a specific subject
#  dt1 <- fetch(ct2$ADVS)
#  
#  # View results of ADVS fetch
#  dt1
#  # A tibble: 44 × 37
#  #    STUDYID USUBJID    SUBJID SITEID SRCDOM SRCVAR   SRCSEQ TRTP  TRTPN TRTA  TRTAN RANDFL SAFFL
#  #    <chr>   <chr>      <chr>  <chr>  <chr>  <chr>     <dbl> <chr> <dbl> <chr> <dbl> <chr>  <chr>
#  #  1 ABC     ABC-01-049 049    01     VS     VSSTRESN      9 ARM D     4 ARM D     4 Y      Y
#  #  2 ABC     ABC-01-049 049    01     VS     VSSTRESN     41 ARM D     4 ARM D     4 Y      Y
#  #  3 ABC     ABC-01-049 049    01     NA     NA           NA ARM D     4 ARM D     4 Y      Y
#  #  4 ABC     ABC-01-049 049    01     VS     VSSTRESN     34 ARM D     4 ARM D     4 Y      Y
#  #  5 ABC     ABC-01-049 049    01     VS     VSSTRESN     35 ARM D     4 ARM D     4 Y      Y
#  #  6 ABC     ABC-01-049 049    01     VS     VSSTRESN     36 ARM D     4 ARM D     4 Y      Y
#  #  7 ABC     ABC-01-049 049    01     VS     VSSTRESN     37 ARM D     4 ARM D     4 Y      Y
#  #  8 ABC     ABC-01-049 049    01     VS     VSSTRESN     38 ARM D     4 ARM D     4 Y      Y
#  #  9 ABC     ABC-01-049 049    01     VS     VSSTRESN     39 ARM D     4 ARM D     4 Y      Y
#  # 10 ABC     ABC-01-049 049    01     VS     VSSTRESN     40 ARM D     4 ARM D     4 Y      Y
#  #  34 more rows
#  #  24 more variables: MITTFL <chr>, PPROTFL <chr>, TRTSDT <chr>, TRTEDT <chr>, ADT <chr>,
#  #   ADY <dbl>, ADTF <lgl>, AVISIT <chr>, AVISITN <dbl>, PARAM <chr>, PARAMCD <chr>,
#  #   PARAMN <dbl>, PARAMTYP <chr>, AVAL <dbl>, BASE <dbl>, CHG <dbl>, AWRANGE <chr>,
#  #   AWTARGET <dbl>, AWTDIFF <dbl>, AWLO <dbl>, AWHI <dbl>, AWU <chr>, ABLFL <chr>,
#  #   ANL01FL <chr>
#  #  Use `print(n = ...)` to see more rows
#  
#  
#  # View results of ADSL fetch
#  dt2 <- fetch(ct2$ADSL)
#  # A tibble: 1 × 56
#  #   STUDYID USUBJID    SUBJID SITEID   AGE AGEU  AGEGR1   SEX   RACE  RACEN ETHNIC ETHNICN COUNTRY
#  #   <chr>   <chr>      <chr>  <chr>  <dbl> <chr> <chr>    <chr> <chr> <dbl> <chr>    <dbl> <lgl>
#  # 1 ABC     ABC-01-049 049    01        39 YEARS 30-39 y… M     WHITE     5 NOT H…       2 NA
#  #   43 more variables: ARM <chr>, ACTARM <lgl>, TRT01P <chr>, TRT01PN <dbl>, TRT01A <chr>,
#  #   TRT01AN <dbl>, TRTSDT <chr>, TRTEDT <chr>, TRTDURN <dbl>, TRTDURU <chr>, TR01SDT <chr>,
#  #   TR01EDT <chr>, INCNFL <chr>, RANDFL <chr>, RANDEXC1 <lgl>, RANDEXC2 <chr>, RANDEXC3 <chr>,
#  #   RANDEXC4 <chr>, SAFFL <chr>, SAFEXC1 <chr>, SAFEXC2 <chr>, MITTFL <chr>, MITTEXC1 <chr>,
#  #   MITTEXC2 <chr>, PPROTFL <chr>, PPROTEX1 <chr>, PPROTEX2 <chr>, PPROTEX3 <chr>,
#  #   PPROTEX4 <chr>, COMPLFL <chr>, STDYDISP <chr>, STDYREAS <chr>, INCNDT <chr>, RANDDT <chr>,
#  #   DTHDT <lgl>, DTHFL <chr>, MISSDOSE <dbl>, TP1TRTR <chr>, TP2TRTR <chr>, TP3TRTR <chr>,...
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create catalog without import spec
#  ct <- catalog(pkg, engines$csv)
#  
#  # View dictionary for ADVS
#  ct$ADVS
#  # data item 'ADVS': 37 cols 3617 rows
#  # - Engine: csv
#  # - Size: 1.1 Mb
#  # - Last Modified: 2020-09-18 14:30:22
#  #    Name   Column     Class Label Format  NAs MaxChar
#  # 1  ADVS  STUDYID character  <NA>     NA    0       3
#  # 2  ADVS  USUBJID character  <NA>     NA    0      10
#  # 3  ADVS   SUBJID character  <NA>     NA    0       3
#  # 4  ADVS   SITEID character  <NA>     NA    0       2
#  # 5  ADVS   SRCDOM character  <NA>     NA   85       2
#  # 6  ADVS   SRCVAR character  <NA>     NA   85       8
#  # 7  ADVS   SRCSEQ   numeric  <NA>     NA   85       2
#  # 8  ADVS     TRTP character  <NA>     NA   85       5
#  # 9  ADVS    TRTPN   numeric  <NA>     NA   85       1
#  # 10 ADVS     TRTA character  <NA>     NA   85       5
#  # 11 ADVS    TRTAN   numeric  <NA>     NA   85       1
#  # 12 ADVS   RANDFL character  <NA>     NA    0       1
#  # 13 ADVS    SAFFL character  <NA>     NA    0       1
#  # 14 ADVS   MITTFL character  <NA>     NA    0       1
#  # 15 ADVS  PPROTFL character  <NA>     NA    0       1
#  # 16 ADVS   TRTSDT character  <NA>     NA   54       9 # Character by default
#  # 17 ADVS   TRTEDT character  <NA>     NA  119       9 # Character by default
#  # 18 ADVS      ADT character  <NA>     NA    0       9
#  # 19 ADVS      ADY   numeric  <NA>     NA   54       4
#  # 20 ADVS     ADTF   logical  <NA>     NA 3617       0
#  # 21 ADVS   AVISIT character  <NA>     NA   50      14
#  # 22 ADVS  AVISITN   numeric  <NA>     NA   50       2
#  # 23 ADVS    PARAM character  <NA>     NA    0      35
#  # 24 ADVS  PARAMCD character  <NA>     NA    0       6
#  # 25 ADVS   PARAMN   numeric  <NA>     NA    0       1
#  # 26 ADVS PARAMTYP character  <NA>     NA 3532       7
#  # 27 ADVS     AVAL   numeric  <NA>     NA    0       5
#  # 28 ADVS     BASE   numeric  <NA>     NA   70       5
#  # 29 ADVS      CHG   numeric  <NA>     NA 1312       4
#  # 30 ADVS  AWRANGE character  <NA>     NA 1331      25
#  # 31 ADVS AWTARGET   numeric  <NA>     NA 1331       3
#  # 32 ADVS  AWTDIFF   numeric  <NA>     NA 1331       2
#  # 33 ADVS     AWLO   numeric  <NA>     NA 1331       3
#  # 34 ADVS     AWHI   numeric  <NA>     NA 1331       3
#  # 35 ADVS      AWU character  <NA>     NA 1331       4
#  # 36 ADVS    ABLFL character  <NA>     NA 2869       1
#  # 37 ADVS  ANL01FL character  <NA>     NA  448       1
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create import spec
#  spc <- import_spec(TRTSDT = "date=%d%b%Y",
#                     TRTEDT = "date=%d%b%Y")
#  
#  # Create catalog with import spec
#  ct <- catalog(pkg, engines$csv, import_specs = spc)
#  
#  # View dictionary for ADVS with Import Spec
#  ct$ADVS
#  # data item 'ADVS': 37 cols 3617 rows
#  # - Engine: csv
#  # - Size: 1.1 Mb
#  # - Last Modified: 2020-09-18 14:30:22
#  #    Name   Column     Class Label Format  NAs MaxChar
#  # 1  ADVS  STUDYID character  <NA>     NA    0       3
#  # 2  ADVS  USUBJID character  <NA>     NA    0      10
#  # 3  ADVS   SUBJID character  <NA>     NA    0       3
#  # 4  ADVS   SITEID character  <NA>     NA    0       2
#  # 5  ADVS   SRCDOM character  <NA>     NA   85       2
#  # 6  ADVS   SRCVAR character  <NA>     NA   85       8
#  # 7  ADVS   SRCSEQ   numeric  <NA>     NA   85       2
#  # 8  ADVS     TRTP character  <NA>     NA   85       5
#  # 9  ADVS    TRTPN   numeric  <NA>     NA   85       1
#  # 10 ADVS     TRTA character  <NA>     NA   85       5
#  # 11 ADVS    TRTAN   numeric  <NA>     NA   85       1
#  # 12 ADVS   RANDFL character  <NA>     NA    0       1
#  # 13 ADVS    SAFFL character  <NA>     NA    0       1
#  # 14 ADVS   MITTFL character  <NA>     NA    0       1
#  # 15 ADVS  PPROTFL character  <NA>     NA    0       1
#  # 16 ADVS   TRTSDT      Date  <NA>     NA   54      10 # Converted to Date
#  # 17 ADVS   TRTEDT      Date  <NA>     NA  119      10 # Converted to Date
#  # 18 ADVS      ADT character  <NA>     NA    0       9
#  # 19 ADVS      ADY   numeric  <NA>     NA   54       4
#  # 20 ADVS     ADTF   logical  <NA>     NA 3617       0
#  # 21 ADVS   AVISIT character  <NA>     NA   50      14
#  # 22 ADVS  AVISITN   numeric  <NA>     NA   50       2
#  # 23 ADVS    PARAM character  <NA>     NA    0      35
#  # 24 ADVS  PARAMCD character  <NA>     NA    0       6
#  # 25 ADVS   PARAMN   numeric  <NA>     NA    0       1
#  # 26 ADVS PARAMTYP character  <NA>     NA 3532       7
#  # 27 ADVS     AVAL   numeric  <NA>     NA    0       5
#  # 28 ADVS     BASE   numeric  <NA>     NA   70       5
#  # 29 ADVS      CHG   numeric  <NA>     NA 1312       4
#  # 30 ADVS  AWRANGE character  <NA>     NA 1331      25
#  # 31 ADVS AWTARGET   numeric  <NA>     NA 1331       3
#  # 32 ADVS  AWTDIFF   numeric  <NA>     NA 1331       2
#  # 33 ADVS     AWLO   numeric  <NA>     NA 1331       3
#  # 34 ADVS     AWHI   numeric  <NA>     NA 1331       3
#  # 35 ADVS      AWU character  <NA>     NA 1331       4
#  # 36 ADVS    ABLFL character  <NA>     NA 2869       1
#  # 37 ADVS  ANL01FL character  <NA>     NA  448       1
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get sample data directory
#  pkg <- system.file("extdata", package = "fetch")
#  
#  # Create import spec
#  spc <- import_spec(TRTSDT = "date=%d%b%Y",
#                     TRTEDT = "date=%d%b%Y")
#  
#  # Create catalog with import spec
#  ct <- catalog(pkg, engines$csv, import_specs = spc)
#  
#  # View dictionary for ADVS with Import Spec
#  ct$ADVS
#  # data item 'ADVS': 37 cols 3617 rows
#  # - Engine: csv
#  # - Size: 1.1 Mb
#  # - Last Modified: 2020-09-18 14:30:22
#  #    Name   Column     Class Label Format  NAs MaxChar
#  # 1  ADVS  STUDYID character  <NA>     NA    0       3
#  # 2  ADVS  USUBJID character  <NA>     NA    0      10
#  # 3  ADVS   SUBJID character  <NA>     NA    0       3
#  # 4  ADVS   SITEID character  <NA>     NA    0       2
#  # 5  ADVS   SRCDOM character  <NA>     NA   85       2
#  # 6  ADVS   SRCVAR character  <NA>     NA   85       8
#  # 7  ADVS   SRCSEQ   numeric  <NA>     NA   85       2
#  # 8  ADVS     TRTP character  <NA>     NA   85       5
#  # 9  ADVS    TRTPN   numeric  <NA>     NA   85       1
#  # 10 ADVS     TRTA character  <NA>     NA   85       5
#  # 11 ADVS    TRTAN   numeric  <NA>     NA   85       1
#  # 12 ADVS   RANDFL character  <NA>     NA    0       1
#  # 13 ADVS    SAFFL character  <NA>     NA    0       1
#  # 14 ADVS   MITTFL character  <NA>     NA    0       1
#  # 15 ADVS  PPROTFL character  <NA>     NA    0       1
#  # 16 ADVS   TRTSDT      Date  <NA>     NA   54      10
#  # 17 ADVS   TRTEDT      Date  <NA>     NA  119      10
#  # 18 ADVS      ADT character  <NA>     NA    0       9
#  # 19 ADVS      ADY   numeric  <NA>     NA   54       4
#  # 20 ADVS     ADTF   logical  <NA>     NA 3617       0
#  # 21 ADVS   AVISIT character  <NA>     NA   50      14
#  # 22 ADVS  AVISITN   numeric  <NA>     NA   50       2
#  # 23 ADVS    PARAM character  <NA>     NA    0      35
#  # 24 ADVS  PARAMCD character  <NA>     NA    0       6
#  # 25 ADVS   PARAMN   numeric  <NA>     NA    0       1
#  # 26 ADVS PARAMTYP character  <NA>     NA 3532       7
#  # 27 ADVS     AVAL   numeric  <NA>     NA    0       5
#  # 28 ADVS     BASE   numeric  <NA>     NA   70       5
#  # 29 ADVS      CHG   numeric  <NA>     NA 1312       4
#  # 30 ADVS  AWRANGE character  <NA>     NA 1331      25
#  # 31 ADVS AWTARGET   numeric  <NA>     NA 1331       3
#  # 32 ADVS  AWTDIFF   numeric  <NA>     NA 1331       2
#  # 33 ADVS     AWLO   numeric  <NA>     NA 1331       3
#  # 34 ADVS     AWHI   numeric  <NA>     NA 1331       3
#  # 35 ADVS      AWU character  <NA>     NA 1331       4
#  # 36 ADVS    ABLFL character  <NA>     NA 2869       1
#  # 37 ADVS  ANL01FL character  <NA>     NA  448       1


# Fortran from R

Testing the calling of Fortran from within an R script.

## Usage

Compile the Fortran code using the Fortran compiler used internally for R:

```bash
$ R CMD SHLIB normal.f90
```

Run the R script:

```bash
$ Rscript main.R
```
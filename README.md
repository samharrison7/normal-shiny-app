# Fortran from R - Shiny app to plot a normal distribution

Testing the calling of Fortran from within an R script.

## Usage

Compile the Fortran code using the Fortran compiler used internally for R:

```bash
$ R CMD SHLIB normal.f90
```

From the R console, load R Shiny and run the app:

```bash
$ R
> library(shiny)
> runApp(".")
```
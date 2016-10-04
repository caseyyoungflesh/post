potools
====

`potools` is an R package used to manipulate and summarize MCMC output. MCMC output may be derived from Bayesian model ouput fit with Stan, JAGS, or other MCMC samplers.

The package currently contains four functions:

- `posummary` - summarize MCMC output for particular parameters of interest
- `potrace` - create trace plotsMCMC chains for particular parameters of interest
- `pochains` - easily extract posterior chains from MCMC output for particular parameters of interest
- `poplot` - create caterpillar plots from MCMC output for particular parameters of interest

While several packages currently exist to evaluate MCMC output, they do not support simple subsetting of model parameters and/or do not provide an option to properly visualize MCMC output, particularly with large numbers of parameters. `potools` was designed to perform key functions for MCMC analysis using minimal code, in order to free up time/brainpower for interpretation of analysis results. 

Installation
------------

You can install the latest version with:
```{r}
install.packages('devtools')
devtools::install_github('caseyyoungflesh/potools', build_vignettes = TRUE)
```

Vignette
--------

The vignette for this package can be run using:
```{r}
vignette('potools')
```


## posummary

`posummary` is used to output summary information from MCMC output. This function accepts `stanfit` objects, `mcmc.list` objects, `R2jags` model output, and matrices of MCMC output (one chain per column).

```{r, message=FALSE}
library(potools)

data(MCMC_data)

posummary(MCMC_data)
```

&nbsp;

Specific parameters can be specified to subset summary information. Partial names may be used to specify any parameter containing that name. For instance, for all `alpha` parameters.

```{r}
posummary(MCMC_data, 
          par = 'alpha')
```

&nbsp;

Individual parameters can also be specified.

```{r}
posummary(MCMC_data, 
          par = 'alpha[1]')
```

&nbsp;

The `excl` argument can be used to exclude any parameters. This can be used in conjunction with the `par` argument. For instance, if all `alpha` parameters are desired **except** for `alpha[1]`, `par = 'alpha', excl = 'alpha[1]'` can be used. These arguments can be used in any of the functions in the package.

```{r}
posummary(MCMC_data, 
          par = 'alpha',
          excl = 'alpha[1]')
```


&nbsp;

## potrace

`potrace` is used to create trace and density plots for MCMC output. This is useful for diagnostic purposes. Particular parameters can also be specified, as with `posummary`.

```{r, fig.width=5, fig.height=6}
potrace(MCMC_data, 
        par = c('beta[1]', 'beta[2]', 'beta[3]'))
```

&nbsp;

Just trace plot can be plotted with `type = 'trace'`. Just density plots can be plotted with `type = 'density'`. Default is `type = 'both'` which outputs both trace and density plots. Individual chains for the density plot can be output using the `ind` argument.

```{r, fig.width=5, fig.height=6}
potrace(MCMC_data, 
        par = c('beta[1]', 'beta[2]', 'beta[3]',
                'beta[4]', 'beta[5]', 'beta[6]'),
        type = 'density',
        ind = TRUE)
```

&nbsp;

`iter_st` denotes at which iteration in the chain the trace and density plots should start with. The default is 1, meaning that the entire chain is plotted. `iter_st = 1800` means that both the trace plots and density plots will begin at iteration 1800 of the posterior chains. Remember, this is the final posterior chain, not including the specified burn-in (specified when the model was run).

```{r, fig.width=5, fig.height=6}
potrace(MCMC_data, 
        par = c('beta[1]', 'beta[2]', 'beta[3]'),
        iter_st = 1800,
        ind = TRUE)
```

&nbsp;

Trace plots can also be output to PDF format. This is recommended for large numbers of parameters, as output to PDF makes for quicker browsing compared to browsing within the R GUI. PDF document will be output to the current working directory by default, but another directory can be specified.

```{r, eval=FALSE}
potrace(MCMC_data, 
        pdf = TRUE, 
        filename = 'MYpdf', 
        wd = 'DIRECTORY HERE')
```

&nbsp;


## pochains

`pochains` is used to extract MCMC chains from MCMC objects. Chains can then be manipulated directly. Particular parameters can be specified as with other functions.

```{r}
ex <- pochains(MCMC_data, 
               par = 'beta')

#extract mean values for each parameter
apply(ex, 2, mean)
```

&nbsp;


## poplot

`poplot` is used to create caterpillar plots from MCMC output. Points represent posterior medians. For parameters where 50% credible intervals overlap 0 are indicated by 'open' circles. For parameters where 50 percent credible intervals DO NOT overlap 0 AND 95 percent credible intervals DO overlap 0 are indicated by 'closed' grey circles. For parameters where 95 percent credible intervals DO NOT overlap 0 are indicated by 'closed' black circles. Thick lines represent 50 percent credible intervals while thin lines represent 95 percent credible intervals.

As with the other functions in the package, particular parameters of interest can be specified.

```{r, fig.width=5, fig.height=6}
poplot(MCMC_data, 
       par = 'beta')
```

&nbsp;

`ref_ovl = FALSE` can be used to disable this feature. All median dots will be represented as 'closed' black circles. A vertical reference at 0 is plotted by default. The position of this reference line can be modified with the `ref` argument. `ref = NULL` removes the reference line altogether.

```{r, fig.width=5, fig.height=6}
poplot(MCMC_data, 
       par = 'beta',
       ref_ovl = FALSE, 
       ref = NULL)
```

&nbsp;

Parameters can be ranked by posterior median estimates using the `rank` argument.

```{r, fig.width=5, fig.height=6}
poplot(MCMC_data, 
       par = 'beta', 
       rank = TRUE)
```

&nbsp;


Graphical parameters for x and y-axis limitation, axis labels, row labels, title, median dot size, CI line thickness, axis and tick thickness, text size, and margins can be specified.

```{r, fig.width=5, fig.height=6}
poplot(MCMC_data, 
       par = 'beta', 
       xlim = c(-60, 25),
       xlab = 'My x-axis label',
       main = 'potools plot',
       labels = c('First param', 'Second param', 'Third param', 
                  'Fourth param', 'Fifth param', 'Sixth param', 
                  'Seventh param', 'Eighth param', 'Nineth param', 
                  'Tenth param'), 
       labels_sz = 1.5,
       med_sz = 2,
       thick_sz = 7,
       thin_sz = 3,
       ax_sz = 4,
       main_text_sz = 2)
```

**For more information see `?poplot`**


&nbsp;

&nbsp;

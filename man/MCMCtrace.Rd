% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MCMCtrace.R
\name{MCMCtrace}
\alias{MCMCtrace}
\title{Trace and density plots from MCMC output}
\usage{
MCMCtrace(
  object,
  params = "all",
  excl = NULL,
  ISB = TRUE,
  exact = TRUE,
  iter = 5000,
  gvals = NULL,
  priors = NULL,
  post_zm = TRUE,
  PPO_out = FALSE,
  Rhat = FALSE,
  n.eff = FALSE,
  ind = FALSE,
  pdf = TRUE,
  plot = TRUE,
  open_pdf = TRUE,
  filename,
  wd = getwd(),
  type = "both",
  ylim = NULL,
  xlim = NULL,
  xlab_tr,
  ylab_tr,
  xlab_den,
  ylab_den,
  main_den = NULL,
  main_tr = NULL,
  lwd_den = 1,
  lwd_pr = 1,
  lty_den = 1,
  lty_pr = 1,
  col_den,
  col_pr,
  col_txt,
  sz_txt = 1.2,
  sz_ax = 1,
  sz_ax_txt = 1,
  sz_tick_txt = 1,
  sz_main_txt = 1.2,
  pos_tick_x_tr = NULL,
  pos_tick_y_tr = NULL,
  pos_tick_x_den = NULL,
  pos_tick_y_den = NULL
)
}
\arguments{
\item{object}{Object containing MCMC output. See DETAILS below.}

\item{params}{Character string (or vector of character strings) denoting parameters of interest.

Default \code{'all'} returns chains for all parameters.}

\item{excl}{Character string (or vector of character strings) denoting parameters to exclude. Used in conjunction with \code{params} argument to select parameters of interest.}

\item{ISB}{Ignore Square Brackets (ISB). Logical specifying whether square brackets should be ignored in the \code{params} and \code{excl} arguments. If \code{TRUE}, square brackets are ignored. If \code{FALSE}, square brackets are not ignored.  This allows partial names to be used when specifying parameters of interest. Use \code{exact} argument to specify whether input from \code{params} and \code{excl} arguments should be matched exactly.}

\item{exact}{Logical specifying whether input from \code{params} and \code{excl} arguments should be matched exactly (after ignoring square brackets if \code{ISB = FALSE}). If \code{TRUE}, input from \code{params} and \code{excl} are matched exactly (after taking \code{ISB} argument into account). If \code{FALSE}, input from \code{params} and \code{excl} are matched using regular expression format (after taking \code{ISB} argument into account).}

\item{iter}{Number of iterations to plot for trace and density plots. The default value is 5000, meaning the last 5000 iterations of the chain will be plotted.}

\item{gvals}{Vector containing generating values if simulated data was used to fit model. These values will be plotted as vertical lines on the density plots to compare posterior distributions with the true parameter values used to generate the data. No line will be apparent if the generating value is outside the plotted range of the posterior distribution.}

\item{priors}{Matrix containing random draws from prior distributions corresponding to parameters of interest. If specified, priors are plotted along with posterior density plots. Percent overlap between prior and posterior (PPO) is also calculated and displayed on each plot. Each column of the matrix represents a prior for a different parameter. Parameters are plotted alphabetically - priors should be sorted accordingly. If \code{priors} contains only one prior and more than one parameter is specified for the \code{params} argument, this prior will be used for all parameters. The number of draws for each prior should equal the number of iterations specified by \code{iter} (or total draws if less than \code{iter}) times the number of chains, though the function will automatically adjust if more or fewer iterations are specified. See DETAILS below.}

\item{post_zm}{Logical - if \code{post_zm = FALSE} x- and y-limits of density plots are scaled so that both the prior and posterior can be visualized on a single density plot (rather than zoomed on the posterior).}

\item{PPO_out}{Logical - if \code{PPO_out = TRUE} percent overlap between prior and posterior (PPO) will be output to a dataframe.}

\item{Rhat}{Logical - if \code{Rhat = TRUE} potential scale reduction factor (Rhat) for each parameter is plotted on the trace plots.}

\item{n.eff}{Logical - if \code{n.eff = TRUE} number of effective samples for each parameter is plotted on the trace plots.}

\item{ind}{Logical - if \code{ind = TRUE}, separate density lines will be plotted for each chain. If \code{ind= FALSE}, one density line will be plotted for all chains.}

\item{pdf}{Logical - if \code{pdf = TRUE} plots will be exported to a pdf.}

\item{plot}{Logical - if \code{plot = FALSE} no plot will be output. Designed to be used in conjunction with \code{PPO_out = TRUE}, to calculate PPO without displaying plot output.}

\item{open_pdf}{Logical - if \code{open_pdf = TRUE} pdf will open in viewer after being generated.}

\item{filename}{Name of pdf file to be printed. Default is 'MCMCtrace'.}

\item{wd}{Working directory for pdf output. Default is current directory.}

\item{type}{Type of plot to be output. \code{'both'} outputs both trace and density plots, \code{'trace'}
outputs only trace plots, and \code{'density'} outputs only density plots.}

\item{ylim}{Vector of length two specifying limits for y-axis on density plots only. If specified, overrides argument \code{post_zm}.}

\item{xlim}{Vector of length two specifying limits for x-axis on density plots only. If specified, overrides argument \code{post_zm}.}

\item{xlab_tr}{Character string specifying label for x-axis on trace plots.}

\item{ylab_tr}{Character string specifying label for x-axis on trace plots.}

\item{xlab_den}{Character string specifying label for x-axis on density plots.}

\item{ylab_den}{Character string specifying label for x-axis on density plots.}

\item{main_den}{Character string (or vector of character strings if plotting > 1 parameter) specifying title(s) of density plot(s).}

\item{main_tr}{Character string (or vector of character strings if plotting > 1 parameter) specifying title(s) of trace plot(s).}

\item{lwd_den}{Number specifying thickness of density line on density plots.}

\item{lwd_pr}{Number specifying thickness of prior line on density plots.}

\item{lty_den}{Number specifying the line type for the density line on density plots.}

\item{lty_pr}{Number specifying the line type for the prior line on density plots.}

\item{col_den}{Character string specifying color of density line on density plots. Does not specify color if \code{ind = TRUE}.}

\item{col_pr}{Character string specifying color of prior line on density plots.}

\item{col_txt}{Character string specifying color of text (denoting PPO) on plot when value specified for \code{priors}. If \code{NULL} is specified, no text will be plot.}

\item{sz_txt}{Number specifying size of text (denoting PPO) when value specified for \code{priors}. If \code{NULL} is specified, no text will be plot.}

\item{sz_ax}{Number specifying thickness of axes and ticks.}

\item{sz_ax_txt}{Number specifying size of text for axes labels.}

\item{sz_tick_txt}{Number specifying size of text for tick labels on axis.}

\item{sz_main_txt}{Number specifying size of text for main title.}

\item{pos_tick_x_tr}{Numeric vector specifying where ticks on x-axis should be placed for trace plots.}

\item{pos_tick_y_tr}{Numeric vector specifying where ticks on y-axis should be placed for trace plots.}

\item{pos_tick_x_den}{Numeric vector specifying where ticks on x-axis should be placed for density plots.}

\item{pos_tick_y_den}{Numeric vector specifying where ticks on y-axis should be placed for density plots.}
}
\description{
Trace and density plots of MCMC chains for specific parameters of interest. Print plots to pdf by default.
}
\section{Details}{

\code{object} argument can be a \code{stanfit} object (\code{rstan} package), a \code{stanreg} object (\code{rstanarm} package), a \code{brmsfit} object (\code{brms} package), an \code{mcmc.list} object (\code{coda} and \code{rjags} packages), \code{mcmc} object (\code{coda} and \code{nimble} packages), \code{list} object (\code{nimble} package), an \code{R2jags} model object (\code{R2jags} package), a \code{jagsUI} model object (\code{jagsUI} package), or a matrix containing MCMC chains (each column representing MCMC output for a single parameter, rows representing iterations in the chain). The function automatically detects the object type and proceeds accordingly.

Matrices for the \code{priors} argument can be generated using commands such as rnorm, rgamma, runif, etc. Distributions not supported by base R can be generated by using the appropriate packages. It is important to note that some discrepancies between MCMC samplers and R may exist regarding the parameterization of distributions - one example of this is the use of precision in JAGS but standard deviation in R for the 'second parameter' of the normal distribution. If the number of draws for each prior distribution is greater than the total number used for the density plot (\code{iter} times the number of chains), the function will use a subset of the prior draws. If the number of draws for each prior distribution is less than the total number used for the density plot, the function will resample (with replacement) from the prior to obtain the appropriate number of draws.
}

\examples{
#Load data
data(MCMC_data)

#Traceplots for all 'beta' parameters - pdf is generated by default
MCMCtrace(MCMC_data, params = 'beta', pdf = FALSE)

#Traceplots (individual density lines for each chain) just for 'beta[1]'
MCMCtrace(MCMC_data, params = 'beta[1]', 
          ISB = FALSE, exact = TRUE, ind = TRUE, pdf = FALSE)

#Plot prior on top of posterior, calculate prior/posterior overlap (PPO) 
#just for 'beta[1]'
#Add Rhat and n.eff values to density plots
PR <- rnorm(15000, 0, 32)
MCMCtrace(MCMC_data, params = 'beta[1]', ISB = FALSE, exact = TRUE, 
          priors = PR, pdf = FALSE, Rhat = TRUE, n.eff = TRUE)

#Output PPO to R object without plotting trace plots
PR <- rnorm(15000, 0, 32)
PPO <- MCMCtrace(MCMC_data, params = 'beta[1]', ISB = FALSE, exact = TRUE,
                 priors = PR, plot = FALSE, PPO_out = TRUE)
}

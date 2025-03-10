% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apply_market_model.R
\name{apply_market_model}
\alias{apply_market_model}
\title{Apply a market model and return a list of \code{returns} objects.}
\usage{
apply_market_model(rates, regressors, same_regressor_for_all = TRUE,
  market_model = c("mean_adj", "mrkt_adj", "sim"),
  estimation_method = c("ols"), estimation_start, estimation_end)
}
\arguments{
\item{rates}{an object of \code{list}, \code{data.frame}, \code{zoo}
containing rates of returns of securities.}

\item{regressors}{an object of the same class as \code{rates} containing
regressors. The argument can be omitted, if market model is \code{mean_adj}.
\code{regressors} must have the same number of components as \code{rates}
except cases when the same regressor is used for all securities.}

\item{same_regressor_for_all}{logical. Should the same regressor be used for
each security? The default value is TRUE.}

\item{market_model}{a character indicating the market model among
\code{mean_adj}, \code{mrkt_adj}, and \code{sim}.}

\item{estimation_method}{a character specifying an estimation method for
\code{sim} model.}

\item{estimation_start}{an object of \code{Date} class giving the first date
of the estimation period.}

\item{estimation_end}{an object of \code{Date} class giving the last date of
the estimation period.}
}
\value{
A list of \code{returns} objects.
}
\description{
The function applies a given market model to securities' rates of returns and
returns a list of \code{returns} objects for each security, which can be
passed directly to a whole battery of tests.
}
\details{
The generic function is dispatched for such classes as \code{list},
\code{data.frame}, and \code{zoo}. If \code{same_regressor_for_all} is TRUE,
and \code{regressors} has the length greater than one, the first element of
\code{regressors} will be applied for each security in \code{rates}.
}
\examples{
## 1. Mean-adjusted-returns model
\dontrun{
library("magrittr")
tickers <- c("ALV.DE", "CS.PA", "ELE.PA", "G.MI", "HNR1.HA", "HSX.L",
             "MUV2.DE", "RSA.L", "TOP.CO")
securities_returns <- get_prices_from_tickers(tickers,
                                              start = as.Date("2000-01-01"),
                                              end = as.Date("2002-01-01"),
                                              quote = "Close",
                                              retclass = "zoo") \%>\%
    get_rates_from_prices(quote = "Close",
                          multi_day = TRUE,
                          compounding = "continuous") \%>\%
    apply_market_model(market_model = "mean_adj",
                       estimation_start = as.Date("2001-03-26"),
                       estimation_end = as.Date("2001-09-10"))
}
## The result of the code above is equivalent to:
data(rates)
securities_returns <- apply_market_model(
    rates,
    market_model = "mean_adj",
    estimation_start = as.Date("2001-03-26"),
    estimation_end = as.Date("2001-09-10")
)

## 2. Market-adjusted-returns model
\dontrun{
library("magrittr")
rates_indx <- get_prices_from_tickers("^STOXX50E",
                                      start = as.Date("2000-01-01"),
                                      end = as.Date("2002-01-01"),
                                      quote = "Close",
                                      retclass = "zoo") \%>\%
    get_rates_from_prices(quote = "Close",
                          multi_day = TRUE,
                          compounding = "continuous")
tickers <- c("ALV.DE", "CS.PA", "ELE.PA", "G.MI", "HNR1.HA", "HSX.L",
             "MUV2.DE", "RSA.L", "TOP.CO")
securities_returns <- get_prices_from_tickers(tickers,
                                              start = as.Date("2000-01-01"),
                                              end = as.Date("2002-01-01"),
                                              quote = "Close",
                                              retclass = "zoo") \%>\%
    get_rates_from_prices(quote = "Close",
                          multi_day = TRUE,
                          compounding = "continuous") \%>\%
    apply_market_model(regressor = rates_indx,
                       same_regressor_for_all = TRUE,
                       market_model = "mrkt_adj",
                       estimation_start = as.Date("2001-03-26"),
                       estimation_end = as.Date("2001-09-10"))
}
## The result of the code above is equivalent to:
data(rates, rates_indx)
securities_returns <- apply_market_model(
    rates = rates,
    regressor = rates_indx,
    same_regressor_for_all = TRUE,
    market_model = "mrkt_adj",
    estimation_start = as.Date("2001-03-26"),
    estimation_end = as.Date("2001-09-10")
)

## 3. Single-index market model
\dontrun{
library("magrittr")
rates_indx <- get_prices_from_tickers("^STOXX50E",
                                      start = as.Date("2000-01-01"),
                                      end = as.Date("2002-01-01"),
                                      quote = "Close",
                                      retclass = "zoo") \%>\%
    get_rates_from_prices(quote = "Close",
                          multi_day = TRUE,
                          compounding = "continuous")
tickers <- c("ALV.DE", "CS.PA", "ELE.PA", "G.MI", "HNR1.HA", "HSX.L",
             "MUV2.DE", "RSA.L", "TOP.CO")
securities_returns <- get_prices_from_tickers(tickers,
                                              start = as.Date("2000-01-01"),
                                              end = as.Date("2002-01-01"),
                                              quote = "Close",
                                              retclass = "zoo") \%>\%
    get_rates_from_prices(quote = "Close",
                          multi_day = TRUE,
                          compounding = "continuous") \%>\%
    apply_market_model(regressor = rates_indx,
                       same_regressor_for_all = TRUE,
                       market_model = "sim",
                       estimation_method = "ols",
                       estimation_start = as.Date("2001-03-26"),
                       estimation_end = as.Date("2001-09-10"))
}
## The result of the code above is equivalent to:
data(rates, rates_indx)
securities_returns <- apply_market_model(
    rates = rates,
    regressor = rates_indx,
    same_regressor_for_all = TRUE,
    market_model = "sim",
    estimation_method = "ols",
    estimation_start = as.Date("2001-03-26"),
    estimation_end = as.Date("2001-09-10")
)

}
\references{
Brown S.J., Warner J.B. \emph{Using Daily Stock Returns, The Case
of Event Studies}. Journal of Financial Economics, 14:3-31, 1985.
}
\seealso{
\code{\link{returns}}
}

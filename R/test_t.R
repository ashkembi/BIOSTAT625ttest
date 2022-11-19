# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @title One-sample Student's t-test
#' @description Performs one sample t-tests on vectors of data.
#' @param x a non-empty numeric vector of data values.
#' @param h0 a number indicating the true value of the mean (null hypothesis).
#' @param alternative a character string specifying the alternative hypothesis; must be one of "two.sided" (default), "greater", or "less".
#' @param conf.level confidence level of the interval
#' @param decimals a number indicating the number of digits to round to
#' @return A summary of the t-test and a list with class "ttest" containing the following components:
#' \itemize{
#' \item statistic - statistic the value of the t-statistic
#' \item parameter - the degrees of freedom for the t-statistic
#' \item p.value - the p-value for the t-test
#' \item conf.int - a confidence interval for the mean appropriate to the specified alternative hypothesis
#' \item estimate - the estimated mean of the sample
#' \item null.value - the specified hypothesized value of the mean (null hypothesis)
#' \item stderr - the standard error of the mean, used as a denominator in the t-statistic formula
#' \item alternative - a character string describing the alternative hypothesis
#' \item method - a character string indicating what type of t-test was performed
#' \item data.name - a character string giving the name of the data
#' \item round - the number of digits used for rounding
#' }
#' @examples
#' test_t(1:10)           # P = 0.0003
#' test_t(1:10, h0 = 5)   # P = 0.6141

test_t <- function(x, h0 = 0, alternative = c("two.sided", "less", "greater"),
                   conf.level = 0.95, decimals = 4) {

  alternative <- match.arg(alternative)

  if(!missing(h0) && (length(h0) != 1 || is.na(h0))) stop("'h0' must be a single number")

  # get vector size
  n <- length_cpp(x)

  if(n < 2) stop("not enough 'x' observations")

  # get degrees of freedom
  df <- n - 1

  # get mean of vector
  x_mean <- mean_cpp(x)
  # get sd of vector
  x_sd <- sd_cpp(x)

  # calculate standard error
  x_std_err <- x_sd/sqrt(n)

  # calculate t statistic
  t <- (x_mean - h0)/x_std_err

  # calculate confidence interval
  ### lower limit

  if (alternative == "two.sided") {
    alpha <- 1-conf.level
    ll <- x_mean + qt(alpha-(alpha/2), df)*x_std_err
    ul <- x_mean + qt(conf.level+(alpha/2), df)*x_std_err

    # calculate p-value
    p.value <- pt(-abs(t), df, lower.tail = TRUE)*2
    p.value.compare = " not equal to "

  } else if (alternative == "less") {
    ll <- -Inf
    ul <- x_mean + qt(conf.level, df)*x_std_err

    #calculate p-value
    p.value <- pt(t, df)
    p.value.compare <- " less than "

  } else {
    ll <- x_mean - qt(conf.level, df)*x_std_err
    ul <- Inf

    # calculate p-value
    p.value <- pt(t, df, lower.tail = FALSE)
    p.value.compare <- " greater than "

  }

  conf.int <- c(ll, ul)

  names(t) <- "t-statistic"
  names(df) <- "df"
  names(h0) <-"null hypothesis"
  attr(conf.int,"conf.level") <- conf.level

  rval <- list(statistic = t, parameter = df, p.value = p.value,
               conf.int = conf.int, estimate = x_mean, null.value = h0,
               stderr = x_std_err,
               alternative = paste0("alternative hypothesis: true mean is", p.value.compare, h0),
               method = "One Sample t-test", data.name = deparse(substitute(x)),
               round = decimals)
  class(rval) <- "ttest"

  return(rval)

}

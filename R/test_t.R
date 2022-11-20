
#' @title One-sample Student's t-test
#' @description Performs one sample t-tests on vectors of data.
#' @param x a non-empty numeric vector of data values.
#' @param h0 a number indicating the true value of the mean (null hypothesis).
#' @param alternative a character string specifying the alternative hypothesis; must be one of "two.sided" (default), "greater", or "less".
#' @param conf.level confidence level of the interval
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
#' }
#' @examples
#' ## Examples for a two-sided t-test
#' ## That is, true mean is equal to the null hypothesis (h0)
#' test_t(1:10)           # P = 0.0002782
#' ## Changing the null hypothesis to 5
#' test_t(1:10, h0 = 5)   # P = 0.6141, not significant
#'
#' ## Examples for a one-sided t-test
#' ## First case, true mean is less than the null hypothesis
#' test_t(1:10, alternative = "less")    # P = 0.9999
#' ## Second case, true mean is greater than the null hypothesis
#' test_t(1:10, alternative = "greater")  # P = 0.0001391
#'
#' ## Example of different confidence levels
#' test_t(1:10, h0 = 5, conf.level = 0.9)
#' test_t(1:10, h0 = 5, conf.level = 0.99)

test_t <- function(x, h0 = 0, alternative = c("two.sided", "less", "greater"),
                   conf.level = 0.95) {

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
    ll <- x_mean + stats::qt(alpha-(alpha/2), df)*x_std_err
    ul <- x_mean + stats::qt(conf.level+(alpha/2), df)*x_std_err

    # calculate p-value
    p.value <- stats::pt(-abs(t), df, lower.tail = TRUE)*2
    p.value.compare = " not equal to "

  } else if (alternative == "less") {
    ll <- -Inf
    ul <- x_mean + stats::qt(conf.level, df)*x_std_err

    #calculate p-value
    p.value <- stats::pt(t, df)
    p.value.compare <- " less than "

  } else {
    ll <- x_mean - stats::qt(conf.level, df)*x_std_err
    ul <- Inf

    # calculate p-value
    p.value <- stats::pt(t, df, lower.tail = FALSE)
    p.value.compare <- " greater than "

  }

  conf.int <- c(ll, ul)

  names(t) <- "t"
  names(df) <- "df"
  names(h0) <-"mean"
  attr(conf.int,"conf.level") <- conf.level
  names(x_mean) <- "mean of x"

  rval <- list(statistic = t, parameter = df, p.value = p.value,
               conf.int = conf.int, estimate = x_mean, null.value = h0,
               stderr = x_std_err,
               alternative = alternative,
               method = "One Sample t-test", data.name = deparse(substitute(x)))
  class(rval) <- "htest"

  return(rval)

}

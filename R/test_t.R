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
               alternative = paste0("alternative hypothesis: true mean is", p.value.compare, h0),
               method = "One Sample t-test", data.name = deparse(substitute(x)),
               round = decimals)
  class(rval) <- "ttest"

  return(rval)

}

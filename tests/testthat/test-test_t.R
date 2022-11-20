test_that("test_t works", {
  # vector of 1:10
  expect_equal(round(as.numeric(test_t(1:10)$statistic), 5), 5.74456)
  expect_equal(round(as.numeric(test_t(1:10)$p.value), 5), 0.00028)
  expect_equal(round(as.numeric(test_t(1:10)$stderr), 5), 0.95743)
  expect_equal(round(as.numeric(test_t(1:10)$estimate), 5), 5.5)
  expect_equal(round(as.numeric(test_t(1:10)$conf.int[1]), 5), 3.33415)
  expect_equal(round(as.numeric(test_t(1:10)$conf.int[2]), 5), 7.66585)

  # vector of 1:10
  # null hypothesis = 10
  expect_equal(round(as.numeric(test_t(1:10, h0 = 10)$statistic), 5), -4.7001)
  expect_equal(round(as.numeric(test_t(1:10, h0 = 10)$p.value), 5), 0.00112)
  expect_equal(round(as.numeric(test_t(1:10, h0 = 10)$stderr), 5), 0.95743)
  expect_equal(round(as.numeric(test_t(1:10, h0 = 10)$estimate), 5), 5.5)
  expect_equal(round(as.numeric(test_t(1:10, h0 = 10)$conf.int[1]), 5), 3.33415)
  expect_equal(round(as.numeric(test_t(1:10, h0 = 10)$conf.int[2]), 5), 7.66585)

  # vector of 1:10
  # confidence level = 0.5
  expect_equal(round(as.numeric(test_t(1:10, conf.level = 0.5)$conf.int[1]), 5), 4.82719)
  expect_equal(round(as.numeric(test_t(1:10, conf.level = 0.5)$conf.int[2]), 5), 6.17281)

  # vector of 1:10
  # alternative hypothesis = "less"
  expect_equal(round(as.numeric(test_t(1:10, alternative = "less")$p.value), 5), 0.99986)
  expect_equal(round(as.numeric(test_t(1:10, alternative = "greater")$p.value), 5), 0.00014)


})

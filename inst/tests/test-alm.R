# tests for alm fxn in alm
context("alm")

dat <- alm(doi="10.1371/journal.pone.0029797")
dat2 <- alm(doi='10.1371/journal.pone.0029797', info='detail')

test_that("alm returns the correct class", {
	expect_that(dat, is_a("data.frame"))
	expect_that(dat2, is_a("list"))
})

test_that("alm returns the correct dimensions", {
  expect_that(nrow(dat), equals(19))
  expect_that(ncol(dat), equals(9))
  expect_that(length(dat2), equals(2))
  expect_that(ncol(dat2[[2]]), equals(3))
})
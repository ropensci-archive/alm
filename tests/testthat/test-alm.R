# tests for alm fxn in alm
context("alm")

key <- "rkfDr76z75benY3pytM1"

dat <- alm(doi="10.1371/journal.pone.0029797", key=key)
dat2 <- alm(doi='10.1371/journal.pone.0029797', info='detail', key=key)
dat3 <- alm(doi='10.1371/journal.pone.0035869', total_details=TRUE, key=key)
dat4 <- alm(doi='10.1371/journal.pone.0036240', sum_metrics='day', key=key)

test_that("alm returns the correct class", {
	expect_that(dat, is_a("data.frame"))
	expect_that(dat2, is_a("list"))
	expect_that(dat3, is_a("data.frame"))
	expect_that(dat4, is_a("data.frame"))
})
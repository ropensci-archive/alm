# tests for almtotals fxn in alm
context("almtotals")

key <- "rkfDr76z75benY3pytM1"

test_that("almtotals returns the correct class", {
	expect_that(almtotals('10.1371/journal.pbio.0000012', key=key), is_a("data.frame"))
	expect_that(almtotals('10.1371/journal.pbio.1001357', key=key), is_a("data.frame"))
})
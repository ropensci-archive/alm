# tests for almtotals fxn in alm
context("almtotals")

test_that("almtotals returns the correct class", {
	expect_that(almtotals('10.1371/journal.pbio.0000012'), is_a("data.frame"))
	expect_that(almtotals('10.1371/journal.pbio.1001357'), is_a("data.frame"))
})
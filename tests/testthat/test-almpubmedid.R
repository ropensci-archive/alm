# tests for almpubmedid fxn in alm
context("almpubmedid")

key <- "rkfDr76z75benY3pytM1"

test_that("almpubmedid returns the correct class", {
	expect_that(almpubmedid('10.1371/journal.pbio.0000012', key=key), is_a("numeric"))
})
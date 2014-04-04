# tests for almpubmedcentid fxn in alm
context("almpubmedcentid")

key <- "rkfDr76z75benY3pytM1"

test_that("almpubmedcentid returns the correct class", {
	expect_that(almpubmedcentid('10.1371/journal.pbio.0000012', key=key), is_a("numeric"))
})
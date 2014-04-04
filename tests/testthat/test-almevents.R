# tests for almevents fxn in alm
context("almevents")

key <- "rkfDr76z75benY3pytM1"

out <- almevents(doi="10.1371/journal.pone.0029797", key=key)
out <- out[!out %in% c("sorry, no events content yet","parser not written yet")] # remove those with no data

test_that("almevents returns the correct class", {
	expect_that(out, is_a("list"))
	expect_that(out[["pmc"]], is_a("data.frame"))
})

test_that("almevents returns the correct dimensions", {
  expect_that(nrow(out[["pmc"]]), equals(25))
  expect_that(ncol(out[["twitter"]]), equals(6))
  expect_that(length(out[c("twitter","crossref")]), equals(2))
})
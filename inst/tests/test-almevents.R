# tests for almevents fxn in alm
context("almevents")

out <- almevents(doi="10.1371/journal.pone.0029797")
out <- out[!out %in% c("sorry, no events content yet","parser not written yet")] # remove those with no data

test_that("almevents returns the correct class", {
	expect_that(out, is_a("list"))
	expect_that(out[["pmc"]], is_a("data.frame"))
})

test_that("almevents returns the correct dimensions", {
  expect_that(nrow(out[["pmc"]]), equals(12))
  expect_that(ncol(out[["twitter"]]), equals(5))
  expect_that(length(out[c("twitter","crossref")]), equals(2))
})
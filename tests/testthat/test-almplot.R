# tests for almplot fxn in alm
context("almplot")

out <- alm(doi="10.1371/journal.pone.0029797", info='detail')
plotted <- almplot(out, type='totalmetrics') # just totalmetrics data

test_that("almplot returns the correct class", {
	expect_that(plotted, is_a("ggplot"))
})

test_that("almplot returns the correct dimensions", {
  expect_that(plotted$labels$x, equals(".id"))
})
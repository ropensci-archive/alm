# tests for signposts fxn in alm
context("signposts")

key <- "rkfDr76z75benY3pytM1"

dat1 <- signposts(doi="10.1371/journal.pone.0029797", key=key)
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
 '10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
dat2 <- signposts(doi=dois, key=key)

test_that("signposts returns the correct class", {
  expect_that(dat1, is_a("data.frame"))
  expect_that(dat2, is_a("data.frame"))
  expect_that(dat1$views, is_a("numeric"))
  expect_that(dat2$doi, is_a("factor"))
  expect_that(dat2$bookmarks, is_a("numeric"))
})

test_that("signposts returns the correct dimensions", {
  expect_that(nrow(dat1), equals(1))
  expect_that(nrow(dat2), equals(4))
})
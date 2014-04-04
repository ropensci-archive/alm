# tests for almdatepub fxn in alm
context("almdatepub")

key <- "rkfDr76z75benY3pytM1"

test_that("almdatepub returns the correct value", {
	expect_that(almdatepub('10.1371/journal.pone.0026871', key=key), matches("2012-03-26"))
	expect_that(almdatepub('10.1371/journal.pone.0026871', 'year', key=key), equals(2012))
})

test_that("almdatepub returns the correct class", {
	expect_that(almdatepub('10.1371/journal.pone.0026871', key=key), is_a("character"))
	expect_that(almdatepub('10.1371/journal.pone.0026871', 'year', key=key), is_a("numeric"))
})

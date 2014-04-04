# tests for almtitle fxn in alm
context("almtitle")

key <- "rkfDr76z75benY3pytM1"

test_that("almtitle returns the correct value", {
	expect_that(almtitle(doi='10.1371/journal.pbio.0000012', key=key), 
		equals("Genome-Wide RNAi of C. elegans Using the Hypersensitive rrf-3 Strain Reveals Novel Gene Functions"))
	expect_that(almtitle(doi='10.1371/journal.pbio.1001357', key=key), 
		equals("Niche-Associated Activation of Rac Promotes the Asymmetric Division of Drosophila Female Germline Stem Cells"))
})

test_that("almtitle returns the correct class", {
	expect_that(almtitle(doi='10.1371/journal.pbio.0000012', key=key), is_a("character"))
	expect_that(almtitle(doi='10.1371/journal.pbio.1001357', key=key), is_a("character"))
})

test_that("almtitle returns a title of the correct length", {
	expect_that(nchar(almtitle(doi='10.1371/journal.pbio.1001357', key=key)), equals(108))
	expect_that(nchar(almtitle(doi='10.1371/journal.pbio.0000012', key=key)), equals(97))
})
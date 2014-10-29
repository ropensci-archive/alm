# tests for alm_title fxn in alm
context("alm_title")

test_that("almtitle returns the correct value", {
	expect_that(suppressWarnings(alm_title(doi='10.1371/journal.pbio.0000012')), 
		equals("Genome-Wide RNAi of C. elegans Using the Hypersensitive rrf-3 Strain Reveals Novel Gene Functions"))
	expect_that(suppressWarnings(alm_title(doi='10.1371/journal.pbio.1001357')), 
		equals("Niche-Associated Activation of Rac Promotes the Asymmetric Division of Drosophila Female Germline Stem Cells"))
})

test_that("alm_title returns the correct class", {
	expect_that(suppressWarnings(alm_title(doi='10.1371/journal.pbio.0000012')), is_a("character"))
	expect_that(suppressWarnings(alm_title(doi='10.1371/journal.pbio.1001357')), is_a("character"))
})

test_that("alm_title returns a title of the correct length", {
	expect_that(nchar(suppressWarnings(alm_title(doi='10.1371/journal.pbio.1001357'))), equals(108))
	expect_that(nchar(suppressWarnings(alm_title(doi='10.1371/journal.pbio.0000012'))), equals(97))
})

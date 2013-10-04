if (base::getRversion() >= "2.15.1") {
  utils::globalVariables(c("value", "variable","doi")) ## Neded in functions plot_density and plot_signposts
}
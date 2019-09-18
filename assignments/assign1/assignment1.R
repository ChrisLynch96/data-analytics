library(ggplot2)
library(gridExtra)
library(maps)
library(ggplot2movies)

data <- data.frame(murder = USArrests$Murder, state = tolower(rownames(USArrests)))
map <- map_data("state")
df <- data.frame(grp = c("A", "B"), fit = 4:5, se = 1:2)
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2))

# List of ggplot2 objects
ggplot_objects <- list(
  a <- ggplot(mpg, aes(hwy)),
  b <- ggplot(mpg, aes(fl)),
  c <- ggplot(map, aes(long, lat)),
  d <- ggplot(economics, aes(date, unemploy)),
  e <- ggplot(seals, aes(x = long, y = lat)),
  f <- ggplot(mpg, aes(cty, hwy)),
  g <- ggplot(mpg, aes(class, hwy)),
  h <- ggplot(diamonds, aes(cut, color)),
  i <- ggplot(movies, aes(year, rating)),
  j <- ggplot(economics, aes(date, unemploy)),
  k <- ggplot(df, aes(grp, fit, ymin = fit-se, ymax = fit+se)),
  l <- ggplot(data, aes(fill = murder)) + expand_limits(x = map$long, y = map$lat),
  m <- ggplot(seals, aes(long, lat)),
  n <- b + geom_bar(aes(fill = fl)),
  o <- a + geom_dotplot( aes(fill = ..x..)),
  p <- f + geom_point( aes(shape = fl)),
  q <- f + geom_point( aes(size = cyl)),
  r <- b + geom_bar(),
  s <- ggplot(mpg, aes(fl, fill = drv)),
  t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
)

# List of 'ad-ons' for each ggplot2 object
layers <- list(
  a_layers <- list(
    geom_area(stat = "bin"),
    geom_density(kernel = "gaussian"),
    geom_dotplot(),
    geom_freqpoly(),
    geom_histogram(binwidth = 5)
  ),
  b_layers <- list(
    geom_bar()
  ),
  c_layers <- list(
    geom_polygon(aes(group = group))
  ),
  d_layers <- list(
    geom_path(lineend = "butt", linejoin = "round", linemitre = 1),
    geom_ribbon(aes(ymin=unemploy - 900, ymax = unemploy + 900))
  ),
  e_layers <- list(
    geom_segment(aes( xend = long + delta_long, yend = lat + delta_lat)),
    geom_rect(aes(xmin = long, ymin = lat, xmax= long + delta_long, ymax = lat + delta_lat))
  ),
  f_layers <- list(
    geom_blank(),
    geom_jitter(),
    geom_point(),
    geom_quantile(),
    geom_rug(sides = "bl"),
    geom_smooth(),
    geom_text(aes(label = cty)),
    geom_point(position = "jitter")
  ),
  g_layers <- list(
    geom_bar(stat = "identity"),
    geom_boxplot(),
    geom_dotplot(binaxis = "y", stackdir = "center"),
    geom_violin(scale = "area")
  ),
  h_layers <- list(
    geom_jitter()
  ),
  i_layers <- list(
    geom_bin2d(binwidth = c(5, 0.5)),
    geom_density2d(),
    geom_hex()
  ),
  j_layers <- list(
    geom_area(),
    geom_line(),
    geom_step(direction = "hv")
  ),
  k_layers <- list(
    geom_crossbar(fatten = 2),
    geom_errorbar(),
    geom_linerange(),
    geom_pointrange()
  ),
  l_layers <- list(
    geom_map(aes(map_id = state), map = map)
  ),
  m_layers <- list(
    geom_contour(aes(z = z)),
    geom_raster(aes(fill = z), hjust=0.5, vjust=0.5, interpolate=FALSE),
    geom_tile(aes(fill = z))
  ),
  n_layers <- list(
    scale_fill_manual(
      values = c("skyblue", "royalblue", "blue", "navy"), 
      limits = c("d", "e", "p", "r"), 
      breaks = c("d", "e", "p", "r"), 
      name = "fuel", 
      labels = c("D", "E", "P", "R")
    ),
    scale_fill_brewer( palette = "Blues"),
    scale_fill_grey(start = 0.2, end = 0.8, na.value = "red")
  ),
  o_layers <- list(
    scale_fill_gradient(low = "red", high = "yellow"),
    scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25),
    scale_fill_gradientn( colours = terrain.colors(6))
  ),
  p_layers <- list(
    scale_shape( solid = FALSE),
    scale_shape_manual( values = c(3:7))
  ),
  q_layers <- list(
    scale_size_area(max_size = 6)
  ),
  r_layers <- list(
    coord_cartesian(xlim = c(0, 5)),
    coord_fixed(ratio = 1/2),
    coord_flip(),
    coord_polar(theta = "x", direction=1 ),
    coord_trans(y = "sqrt"),
    theme_bw(),
    theme_classic(),
    theme_grey(),
    theme_minimal()
  ),
  s_layers <- list(
    geom_bar(position = "dodge"),
    geom_bar(position = "fill"),
    geom_bar(position = "stack")
  ),
  t_layers <- list(
    facet_grid(. ~ fl),
    facet_grid(year ~ .),
    facet_grid(year ~ fl)
  )
)

# Nested for loops to run through and generate all the plots
plots <- list()
counter <- 1
for(i in 1:length(ggplot_objects)) {
  for(j in 1:length(layers[[i]])) {
    plot <-ggplot_objects[[i]] + layers[[i]][[j]]
    plots[[counter]] = plot
    counter = counter + 1
  }
}

# Ending for loop to write the list of plots to a pdf file
pdf("plots.pdf", onefile = TRUE)
for (i in seq(length(plots))) {
  print(plots[[i]]) 
}
dev.off()
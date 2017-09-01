library( ggplot2 )
library(ggrepel)
library( scales )

revigo.data <- read.csv("REVIGO/pdam_specific_revigo.csv")
revigo.data$plot_X <- as.numeric(as.character(revigo.data$plot_X))
revigo.data$plot_Y <- as.numeric(as.character(revigo.data$plot_Y))
revigo.data$log_value <- log2(revigo.data$value + 1)

wrap <- function(x, len) sapply(x, function(y) paste(strwrap(y, len), collapse = "\n"), USE.NAMES = FALSE)

revigo.data$description <- wrap(revigo.data$description, 20)
revigo.data <- na.omit(revigo.data)
# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = revigo.data);
p1 <- p1 + geom_point( aes( plot_X, plot_Y, size = value), color="blue", alpha = I(0.6) ) + scale_size_area() + labs(size="Number of domains");
p1 <- p1 + scale_size( range=c(5, 30)) + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
ex <- revigo.data #[ revigo.data$dispensability < 0.2 | revigo.data$value > 5, ]; 
p1 <- p1 + geom_text_repel( data = ex, aes(plot_X, plot_Y, label = description), 
                            colour = I(alpha("black", 0.85)), size = 3,
                            lineheight = 0.7, segment.color=NA);
p1 <- p1 + labs (y = "semantic space y", x = "semantic space x");
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(revigo.data$plot_X) - min(revigo.data$plot_X);
one.y_range = max(revigo.data$plot_Y) - min(revigo.data$plot_Y);
p1 <- p1 + xlim(min(revigo.data$plot_X)-one.x_range/10,max(revigo.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(min(revigo.data$plot_Y)-one.y_range/10,max(revigo.data$plot_Y)+one.y_range/10);
p1


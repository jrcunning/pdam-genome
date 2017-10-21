library( ggplot2 )
library(ggrepel)
library( scales )

args = commandArgs(trailingOnly=TRUE)

revigo.data <- read.csv(args[1])
md <- read.csv(args[2], row.names=NULL)
revigo.data <- merge(revigo.data, md, by=1)
revigo.data$O.E <- revigo.data$Significant / revigo.data$Expected
revigo.data$plot_X <- as.numeric(as.character(revigo.data$plot_X))
revigo.data$plot_Y <- as.numeric(as.character(revigo.data$plot_Y))
revigo.data$value <- as.numeric(as.character(revigo.data$O.E))
#revigo.data$log_value <- log2(revigo.data$value + 1)

wrap <- function(x, len) sapply(x, function(y) paste(strwrap(y, len), collapse = "\n"), 
                                USE.NAMES = FALSE)

revigo.data$description <- wrap(revigo.data$description, 20)

if (any(is.na(revigo.data$plot_X))) revigo.data <- revigo.data[!is.na(revigo.data$plot_X),]
# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = revigo.data);
nonsig <- revigo.data[10^(revigo.data$log10.p.value) >= 0.05, ];
sig <- revigo.data[10^(revigo.data$log10.p.value) < 0.05, ];
#p1 <- p1 + geom_point(data=nonsig, aes( plot_X, plot_Y, size = 1), color="gray50", alpha = I(0.6) );
p1 <- p1 + geom_point(data=sig, aes( plot_X, plot_Y, size = value), color="blue", alpha = I(0.6) ) + scale_size_area() + labs(size="O/E");

p1 <- p1 + scale_size( range=c(4, 16)) + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
p1 <- p1 + geom_text_repel( data = sig, aes(plot_X, plot_Y, label = description), 
                            colour = I(alpha("black", 0.85)), size = 3,
                            lineheight = 0.7, segment.color="black");
p1 <- p1 + labs (y = "semantic space y", x = "semantic space x");
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(revigo.data$plot_X) - min(revigo.data$plot_X);
one.y_range = max(revigo.data$plot_Y) - min(revigo.data$plot_Y);
p1 <- p1 + xlim(min(revigo.data$plot_X)-one.x_range/10,max(revigo.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(min(revigo.data$plot_Y)-one.y_range/10,max(revigo.data$plot_Y)+one.y_range/10);

figure <- p1

ggsave(filename=args[3], plot = figure, device = "png",
       scale = 1, width = 7, height = 5, units = "in",
       dpi = 300)

 
  
### override default mgp in par to make better ticks
par.gill <- function(..., mgp=c(0,.05,-.05)) {
  par(..., mgp=mgp)
}

### Michael Gill's brilliant function to make transparent colors
makeTransparent<-function(someColor, alpha)
{
  newColor<-col2rgb(someColor)
  apply(newColor, 2, function(curcoldata){rgb(red=curcoldata[1], green=curcoldata[2],
                                              blue=curcoldata[3],alpha=alpha, maxColorValue=255)})
}

add_legend <- function(...) {
  opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
              mar=c(0, 0, 0, 0), new=TRUE)
  on.exit(par(opar))
  plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
  legend(...)
}

### Loess line with CI overlay
loessCI <- function(x, y, line_col="gray40", t_stat=NULL, span=NULL, trans_level=NULL, poly_col="gray85"){
  loess.color <- poly_col
  y_input <- y
  x_input <- x
  trans_level <- ifelse(is.null(trans_level),220, trans_level)
  t_stat <- ifelse(is.null(t_stat)==T,2,t_stat)
  comp_fit <- loess(y_input ~ x_input, span = ifelse(is.null(span)==T,0.6,span))
  comp_out <- predict(comp_fit, sort(x_input), se=TRUE) 
  comp_lower <- comp_out $fit-t_stat* comp_out$se.fit
  comp_upper <- comp_out $fit+t_stat* comp_out$se.fit
  polygon(c(sort(x_input), rev(sort(x_input))),  c(comp_lower, rev(comp_upper)), col= ifelse(is.null(line_col)==T, makeTransparent(loess.color, trans_level), makeTransparent(loess.color, trans_level)), border= ifelse(is.null(line_col)==T, makeTransparent(loess.color, trans_level), makeTransparent(loess.color, trans_level)))
  lines(x=x_input, y=comp_out$fit, col=line_col, lty=2, lwd=2, lend=2)
}
 
  ### function to produce nice plots
  ### preserves most defaults through "..."
  ### defaults labels to blank, axes to missing, makes points look nice
  plot.gill <- function(..., xlab="", ylab="", xaxt="n", yaxt="n", pch=21, bg="gray87", col="gray30", x_seq = NULL,  y_seq = NULL, bty=NULL, rect_col=NULL, do_axes=NULL, do_seq=T, outer.box=F, outer.box.col="black", grid_col="gray70", point.size=1.3) {
    plot(..., xlab=xlab, ylab=ylab, xaxt=xaxt, yaxt=yaxt, pch=pch, bg=bg,  bty="n")
    rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col = ifelse(is.null(rect_col),"peachpuff1", rect_col), border= ifelse(is.null(rect_col),"white", rect_col))
    # Draw sequences in background
    if(do_seq!=F){
      abline(v= seq(par("xaxp")[1], par("xaxp")[2], length.out=par("xaxp")[3]+1), col=grid_col)
      abline(h= seq(par("yaxp")[1], par("yaxp")[2], length.out= par("yaxp")[3]+1), col=grid_col)
    }
    # Add axis
    axis(side=1,lwd=0, lwd.ticks=1, tck=-0.01, col="white", col.axis="gray20", cex.axis=.8)
    axis(side=2,lwd=0, lwd.ticks=1, tck=-0.01, las=1, col="white", col.axis="gray20", cex.axis=.8)
    # Add points
    points(...,pch=21, bg=bg, col=col, lwd=1.5, cex=point.size)
    # Y/N add box around plot
    if(outer.box==T){
      box(col= outer.box.col)	
    }
  }


### create test data
set.seed(94304)
X <- 1:300
Y <-  .0002*X - .003*X^2 + rnorm(n=length(X), mean=0, sd=100)



### make some sample plots
pdf(file="newpwn.pdf", height=6, width=8)
par.gill(mfrow=c(2,2), oma=c(3,3,3,3), mar=c(.1,2,2,.1)) 
plot.gill(X, Y)
loessCI(X, Y)
 
plot.gill(X, Y, bg="cadetblue3", outer.box =T,outer.box.col="white", rect_col="gray70", grid_col="gray90")
loessCI(X, Y, line_col="#FFA3A3")

plot.gill(X, Y, bg="ghostwhite", outer.box =T,outer.box.col="white", rect_col="papayawhip", grid_col="gray79", point.size=1.4)
loessCI(X, Y, poly_col="royalblue4", line_col="ghostwhite")
 
plot.gill(X, Y, bg="cadetblue2", outer.box =T,outer.box.col="white", rect_col="lightcoral", grid_col="gray79", point.size=1.5)
loessCI(X, Y, poly_col="gray60", line_col="ghostwhite")


dev.off()

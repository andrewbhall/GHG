
source("GHG.R")


set.seed(94304)
X <- 1:300
Y <-  .0002*X - .003*X^2 + rnorm(n=length(X), mean=0, sd=100)

png(file="example_main.png", width=600, height=480, res=80)

par.gh()
plot.gh(X, Y)
loessCI(X, Y)
dev.off()


png(file="example0.png", width=600, height=480, res=80)
par.gh(mfrow=c(2,2), las=1, mar=c(1.5,2,1.5,2),oma=c(1,4,1,1),mgp=c(3,.5,0))
#1
plot.gh(X, Y)
loessCI(X, Y)
#2
plot.gh(X, Y, col="gray50", outer.box=T, rect_col="gray95", grid_col="white")
loessCI(X, Y, line_col="salmon", poly_col="salmon", trans_level=140)
#3
plot.gh(X, Y, do_seq=F,col="gray90")
loessCI(X, Y, line_col="cadetblue4",t_stat=10, trans_level=150)
#4
plot.gh(X, Y, bg="green", outer.box =T,outer.box.col="purple", rect_col="dodgerblue")
loessCI(X, Y, line_col="red", poly_col="red", trans_level=140)
dev.off()

png(file="example.png", width=600, height=480, res=80)
par.gh(mfrow=c(2,2), oma=c(3,3,3,3), mar=c(.1,2,2,.1))
plot.gh(X, Y)
loessCI(X, Y)
dev.off()

plot.gh(X, Y, bg="cadetblue3", outer.box =T,outer.box.col="white", rect_col="gray70", grid_col="gray90")
loessCI(X, Y, line_col="#FFA3A3")

plot.gh(X, Y, bg="ghostwhite", outer.box =T,outer.box.col="white", rect_col="papayawhip", grid_col="gray79", point.size=1.4)
loessCI(X, Y, poly_col="royalblue4", line_col="ghostwhite")

plot.gh(X, Y, bg="cadetblue2", outer.box =T,outer.box.col="white", rect_col="lightcoral", grid_col="gray79", point.size=1.5)
loessCI(X, Y, poly_col="gray60", line_col="ghostwhite")
dev.off()


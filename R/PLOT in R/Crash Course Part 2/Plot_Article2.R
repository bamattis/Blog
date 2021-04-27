###################################################
# Adding titles, backgrounds, and legends to plot()
#
# by: Brian Mattis - 4/26/2021
#
###################################################



plot(df$A, df$B, xlim=c(0,8), ylim=c(0,8),
     main="Chart Title",
     xlab="Series A",
     ylab="Series B",
     sub="A little subtitle")

# NOT like this - titles are overlaid:
plot(df$A, df$B, xlim=c(0,8), ylim=c(0,8))
title(main="Chart Title",
      xlab="Series A",
      ylab="Series B",
      sub="A little subtitle")

####### Stage 2: Further Title customization ###########

plot(df$A, df$B, xlim=c(0,8), ylim=c(0,8),
     main="Chart Title",cex.main=1.3, font.main=2, col.main="steelblue1",
     xlab="Series A", 
     ylab="Series B", cex.lab=1.1, font.lab=1, col.lab="gray34",
     sub="A little subtitle", cex.sub=0.8, font.sub=3, col.sub="deeppink")

#Each of these are customizable 
#  cex = sizing
#     - cex.main=, cex.lab=, cex.sub=
#  font = font style
#     - font.main=, font.lab=, font.sub=
#       1: normal, 2: bold, 3: italic, 4: bold and italic, 5: symbol font


#######  Stage 3: Background color #########

# add a background color to the plot
# par("usr") returns a the boundary of the plotting region.  By using each element of this list,
#    we can define a colored rectangle of the same shape
plot(NULL, xlim=c(0,8), ylim=c(0,8))
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],col = "gray")

#can add gradient shading with gradient.rect 
# (https://www.rdocumentation.org/packages/plotrix/versions/3.8-1/topics/gradient.rect)

plot(NULL, xlim=c(0,8), ylim=c(0,8),
     main="Chart Title",cex.main=1.3, font.main=2, col.main="steelblue1",
     xlab="Series A", 
     ylab="Series B", cex.lab=1.1, font.lab=1, col.lab="gray34",
     sub="A little subtitle", cex.sub=0.8, font.sub=3, col.sub="deeppink")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],col = "gray")
points(df$A, df$B)


#######  Stage 4: Adding Legends #########

#locations: "topleft", ....
#inset pulls it away from the chart edge
#cex scales the legend - I usually prefer ~ 0.8
legend("topleft", legend=c("B", "C"), col=c("blue", "darkgreen"),
       title="Legend", inset=c(0.02,0.02), pch=c(25,17),fill=c("red","black"),cex=0.8)

### LEGEND LOCATION REFERENCE: 
#legend location plot:  “bottomright”, “bottom”, “bottomleft”, “left”, “topleft”, “top”, “topright”, “right”, “center”
plot(NULL, xlim=c(0,8), ylim=c(0,8))
legend("topleft", legend="topleft", pch=0)
legend("top", legend="top", pch=0)
legend("topright", legend="topright", pch=0)
legend("left", legend="left", pch=0)
legend("center", legend="center", pch=0)
legend("right", legend="right", pch=0)
legend("bottomleft", legend="bottomleft", pch=0)
legend("bottom", legend="bottom", pch=0)
legend("bottomright", legend="bottomright", pch=0)


###### Adding the Legend: ############

plot(NULL, xlim=c(0,8), ylim=c(0,8),
     main="Chart Title",cex.main=1.3, font.main=2, col.main="steelblue1",
     xlab="Series A", 
     ylab="Series B, Series C", cex.lab=1.1, font.lab=1, col.lab="gray34",
     sub="A little subtitle", cex.sub=0.8, font.sub=3, col.sub="deeppink")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],col = "lightgray")

# line overlays
abline(h=0:8, col="white")
abline(v=0:8, col="white")
abline(a=0, b=1, lty="dashed", lwd=2, col="darkslateblue") 
abline(a=0, b=0.5, lty="dotdash", lwd=2, col="deeppink") 
#points:
points(df$A, df$B, col="darkslateblue", pch=18, 
       cex=1.8, lwd=2)
points(df$A, df$C, col="deeppink", pch=17, cex=1.6)
#legend
legend("topleft", legend=c("Group B", "Group C"), 
       pch=c(18,17), col=c("darkslateblue", "deeppink"), 
       pt.cex=c(1.4, 1.3), inset=c(0.05, 0.05), title="Legend")
#use pt.bg / pt.lwd if using a pch with alternate filled points


#######  Stage 5: Extra Credit - open points #########


plot(NULL, xlim=c(0,8), ylim=c(0,8),
     main="Chart Title",cex.main=1.3, font.main=2, col.main="steelblue1",
     xlab="Series A", 
     ylab="Series B, Series C", cex.lab=1.1, font.lab=1, col.lab="gray34",
     sub="A little subtitle", cex.sub=0.8, font.sub=3, col.sub="deeppink")

#background
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],
     col = "lightgray")

#grid lines
abline(h=0:8, col="white")
abline(v=0:8, col="white")

#trend lines
abline(a=0, b=1, lty="dashed", lwd=2, col="darkslateblue") 
abline(a=0, b=0.5, lty="dotdash", lwd=2, col="deeppink") 

#points:
points(df$A, df$B, col="darkslateblue", pch=25, 
       cex=1.4, lwd=2, bg="steelblue1")
points(df$A, df$C, col="deeppink", pch=17, cex=1.6)

#legend
legend("topleft", legend=c("Group B", "Group C"), pch=c(25,17),
       pt.bg="steelblue1", pt.lwd=c(2,1),
       col=c("darkslateblue", "deeppink"), pt.cex=c(1.2, 1.4), 
       inset=c(0.05, 0.05))

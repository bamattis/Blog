# Crash course in R Plot customization
# by Brian Mattis - https://medium.com/@brian.mattis

# let's make some data:
df <- data.frame (A = c(1,2,3,4,5,6,7),
                  B = c(1.2, 2.2, 2.9, 3.9, 5.2, 6, 7.1),
                  C = c(0.55, 1.1, 1.56, 1.96, 2.45, 3.11, 3.55))

# the most basic of plots:
plot(df$A, df$B)

#################################
# Colors, symbols, sizes, oh my #
#################################

plot(df$A, df$B, col="blue", xlim=c(0,8), ylim=c(0,8), 
     pch=25, bg="lightblue", cex=1.2, lwd=2)

#################################
# Adding points and lines       #
#################################

plot(df$A, df$B, col="blue", xlim=c(0,8), ylim=c(0,8), 
     pch=25, bg="lightblue", cex=1.2, lwd=2)

# the second set of points
points(df$A, df$C, col="darkgreen", pch=17, cex=1.6)

# horizontal grid lines
abline(h=0:8, col="gray")

# vertical grid lines
abline(v=0:8, col="gray")

# trendline- a: intercept, b: slope
abline(a=0, b=1, lty="dashed", lwd=2, col="blue") 

##############
# Layering   #
##############

# start with a blank canvas
plot(NULL, xlim=c(0,8), ylim=c(0,8))

# line overlays
abline(h=0:8, col="gray")
abline(v=0:8, col="gray")
abline(a=0, b=1, lty="dashed", lwd=2, col="blue") 

#points:
points(df$A, df$B, col="blue", pch=25, bg="lightblue", 
       cex=1.2, lwd=2)
points(df$A, df$C, col="darkgreen", pch=17, cex=1.6)

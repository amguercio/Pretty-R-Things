##To make boxplots

setwd("/Users/amiriamguercio/Documents/College_Research/")

#install.packages("ggplot2")
#install.packages("ggsignif") 

## load required libraries 
library(ggplot2)
library(ggsignif)


ampboxplot <- function(dataset, name) {
  p<-ggplot(dataset, aes(x=Line, y=Amplitude, fill=Line)) + 
    geom_boxplot() +
    scale_fill_manual(values=c("yellow", "light green")) +
    geom_signif(comparisons= list(c("Col", "PGM-1")), map_signif_level = T) +
    ggtitle(name)
  return(plot(p))
}
 

##For vertical gravitrophic movements
grav_v_amp <- read.delim("grav_vert_amp.txt")
grav_v_amp$Line<- as.factor(grav_v_amp$Line)
ampboxplot(grav_v_amp, "A)")

##For angle gravitrophic movements
grav_ang_amp <- read.delim("grav_ang_amp.txt")
grav_ang_amp$Line<- as.factor(grav_ang_amp$Line)
ampboxplot(grav_ang_amp, "C)")

##For horizontal circumnutation movements
circ_amp <- read.delim("circ_hor_amp.txt")
circ_amp$Line<- as.factor(circ_amp$Line)
#head(circ_amp) 
ampboxplot(circ_amp, "E)")


rateboxplot <- function(dataset, name) {
  p<-ggplot(dataset, aes(x=Line, y=Rate, fill=Line)) + 
    geom_boxplot() +
    scale_fill_manual(values=c("yellow", "light green")) +
    geom_signif(comparisons= list(c("Col", "PGM-1")), map_signif_level = T) +
    ggtitle(name)
  return(plot(p))
}


##For vertical gravitrophic rates
grav_v_rate <- read.delim("grav_vert_rate.txt")
grav_v_rate$Line<- as.factor(grav_v_rate$Line)
rateboxplot(grav_v_rate, "B)")

##For gravitrophic angle rates
grav_ang_rate <- read.delim("grav_ang_rate.txt")
grav_ang_rate$Line<- as.factor(grav_ang_rate$Line)
rateboxplot(grav_ang_rate, "D)")

##For horizontal circumnutatic rates
circ_rate <- read.delim("circ_hor_rate.txt")
circ_rate$Line<- as.factor(circ_rate$Line)
rateboxplot(circ_rate, "F)")

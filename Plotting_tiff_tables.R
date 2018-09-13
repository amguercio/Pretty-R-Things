##Script for automating putting images into a table


#Libraries to install/load
library(ggplot2)
library(gridExtra)
library(grid)
library(cowplot)
library(magick)
library(tiff)
library(stringr)
library(pdftools)


##A function to plot your images, given a prefix for the filenames you wish to plot
##default plots these as one row (in order within that row left to right)
##output is a pdf file with the name prefix.pdf and the left label of the prefix
##default input is .tiff format files

plotmyimages<-function(prefix){
  name<-as.character(prefix)
  searchpattern<- paste0(prefix, "*", sep="")
  prefix<-dir(path, pattern = searchpattern)
  prefix<-prefix[!str_detect(prefix, pattern="copy")]
  prefix<-prefix[!str_detect(prefix, pattern="pdf")]
  tifflist<-lapply(prefix, function(file) {
    image<-readTIFF(file, native=TRUE)
    drawimage<-(ggdraw() + draw_image(image, scale = 0.9))
  }
  )
  pdfname<-paste0(name, ".pdf", sep="")
  pdf(pdfname, width=16,height=3)
  print(do.call(grid.arrange, c(tifflist, nrow=1, ncol=4, left=name)))
  dev.off()
}


##For ST tissue

##First set your path to the directory where your images are held, this can be a master folder
##  we will use regular expressions to direct to the specific images we want in the table
path = "~/Documents/BradyLab/ST_Images/"
setwd(path)

##When calling the function, you need to give it the prefix you wish to look for to plot these images
##To make it easy, you can make a list of these prefixes--each will save as an individual file
prefixlist<-c("SQR_2N_CTR", "SQR_2N_Striga", "SQR_2S_CTR", "SQR_2S_Striga", "SRN39_2N_CTR", "SRN39_2N_Striga", "SRN39_2S_CTR", "SRN39_2S_Striga")

##Now let's run the plotmyimages function over all prefixes in our prefix list
for (prefix in prefixlist){
  plotmyimages(prefix)
}


##Each prefix in this list has saved as an individual file
##If you want to arrange these into one table-like pdf file:



allmyimages<-sapply(prefixlist, function(prefix) {
  filename<-paste0(prefix, ".pdf", sep="")
  new<-image_read_pdf(filename)
  image_append(image_scale(new, "x1500"), stack=TRUE)
}
)

##for some reason sapply will only save this as a list of lists
##magick won't work with these objects so we have to force it to a normal list
##to do this make sure you get
length(prefixlist)
##and then do this below for the full length
allmyimages<-c(allmyimages[[1]], allmyimages[[2]], allmyimages[[3]], allmyimages[[4]], allmyimages[[5]], allmyimages[[6]], allmyimages[[7]], allmyimages[[8]])
allmyimages

final_plot<-image_append(image_scale(allmyimages), stack=TRUE)
plot(final_plot)


pdf("ST_images.pdf")
plot(final_plot)
dev.off()

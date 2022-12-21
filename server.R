# install.packages("stringr")
# install.packages("plotly")
# install.packages("ggplot2")
# install.packages("reshape2")
# install.packages("dplyr")
#install.packages("e1071")

library("e1071")
library(dplyr)
library(reshape2)
library(plotly)
library(ggplot2)
library(stringr)
library(DT)


d<-data.frame(read.csv("D:\\TEJAS\\R Files\\df.csv"))

d<-replace(d,d==-1,NA)
d<- na.omit(d)

a<-d$flavor_profile
table(a)

x <- c("spicy", "sour","sweet","bitter")  
y <-c(102,1,74,4)
b<- paste(round(100*y/sum(y), 1),"%")
colors<-c("red","yellow","brown","green")


h1 = d$cook_time
h2 = d$prep_time
data <- cor(d[sapply(d,is.numeric)])
data1 <- melt(data)


colors2 = c("light green","red")
regions <- c('C','E','N','NE','S','W')
diet <-  c('non vegetarian','vegetarian')
Values <- matrix(c(0,3,3,22,5,40,5,5,3,34,1,59), nrow = 2, ncol = 6, byrow = TRUE)


shinyServer(function(input, output) {
    output$flavour_data<-renderDataTable({
      datatable(d[d$flavor_profile==input$flavour,],)
    })
    output$PieChart<-renderPlot({
      pie(y, labels = b, main = "Flavours Pie Chart",col = colors,init.angle = -10)
      legend("topright", c("spicy","sour","sweet","bitter"), cex = 1.2,fill =colors)     
    })
    output$heatMap<-renderPlot({
      ggplot(data1, aes(x = Var1,y = Var2,fill = value))+geom_tile()
    })
    output$barPlot<-renderPlot({
      barplot(Values,main = "Region wise diet", names.arg = regions, xlab = "region", ylab = "diet", col = colors2, beside=TRUE)
      legend("topleft", diet, cex = 1.5, fill = colors2)
    })
    output$barPlot2<-renderPlot({
      colors = c("#003f5c","#bc5090","#ff6361","#ffa600")
      regions <- c('C','E','N','NE','S','W')
      flavour <-  c('bitter','sour','spicy','sweet')
      Values <- matrix(c(0,0,2,1,0,0,5,20,2,0,34,9,0,0,5,5,0,0,19,18,2,1,37,20), nrow = 4, ncol = 6, byrow = TRUE)
      barplot(Values,main = "Region wise flavours", names.arg = regions, xlab = "region", ylab = "flavour", col = colors,beside=TRUE)
      legend("topleft", flavour, cex = 1.2, fill = colors)
    })
    output$barPlot3<-renderPlot({
      k<-d[d$course=="snack",]
      name<-k$name
      v<-as.matrix(k$prep_time)
      barplot(v,names.arg=name,xlab="Snacks",ylab="prep_time",font=1,las=2,
              beside = TRUE,
              col=c("#050A30","#000C66","#0000FF","#7EC8E3","#B0D2DA","#CAB29F",
                    "#7DA1BF","#2F4A60","#050A30","#000C66","#0000FF","#7EC8E3",
                    "#B0D2DA","#CAB29F","#7DA1BF","#2F4A60","#B0D2DA",
                    "#CAB29F","#7DA1BF","#2F4A60","#050A30","#000C66",
                    "#0000FF","#7EC8E3","#B0D2DA"),
              cex.names = 0.8,
              main="Preparation time for snacks"
      )
    })
    output$PieChart2<-renderPlot({
      east<-d[d$region=="East",]
      west<-d[d$region=="West",]
      north<-d[d$region=="North",]
      south<-d[d$region=="South",]
      y<-c(north$name,west$name,east$name,south$name)
      x<-c(nrow(north),nrow(west),nrow(east),nrow(south))
      f<-c("North","West","East","South")
      colors<-c("#EFD3B5","#5F093D","#B21368","#D67BA8")
      pie(x,labels =f ,main="Region Wise Food Items ",col = colors,init.angle = -25)
      legend(1.2,1,y,cex = 0.8,fill =colors,title="Food Items")
      legend(2.3,1,z,cex = 0.8,fill =colors,title = "State")
    })
})


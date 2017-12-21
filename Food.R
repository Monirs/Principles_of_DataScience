library(xlsx)
require(ggplot2)
library(ggplot)
library(Amelia)


setwd("F:/UM_DATA_SCIENCE/UM_COURSES/PDS/Shiny_R")
df <-  read.xlsx("raw_food_data.xlsx",sheetName = "raw_data")
typeof(df)

hemissmap(df, main = "Missing values vs observed")

sapply(df,function(x) sum(is.na(x)))



# Fill NA values by most frequent occured value.
for(i in 1:ncol(df)){
  df[is.na(df[,i]), i] <- tail(names(sort(table(df[i]))), 1)
  
}

# Check for missing data
missmap(df, main = "Missing values vs observed")


# Shorten 

#i=0

#df1["Shrt_Desc"]
#for (row in 1:nrow(df1)){
  #  print(df1("Shrt_Desc")[row])
  #v=df1(Shrt_Desc)[row]
 # V = strsplit(v,"_")
 # E1_t=sapply(V,function(x) x[1])
  #E1_t=paste(E1_t," Ratings(g)")
  #df1$Shrt_Desc[row]= E1_t
  
#}



df_oil <-head(df[grep("OIL", df$Shrt_Desc), ])
df_rice <-head(df[grep("RICE", df$Shrt_Desc), ])
df_flour <-head(df[grep("FLOUR", df$Shrt_Desc), ])

df_beef <-head(df[grep("BEEF", df$Shrt_Desc), ])
df_tomato <-head(df[grep("TOMATO", df$Shrt_Desc), ])
df_cheese <-head(df[grep("CHEESE", df$Shrt_Desc), ])
df_butter <-head(df[grep("BUTTER", df$Shrt_Desc), ])


df_cheese$Energ_Kcal=as.numeric(df_cheese$Energ_Kcal)
df_butter$Energ_Kcal=as.numeric(df_butter$Energ_Kcal)
# bins <- seq(1, 10, length.out = 20)




# Visualization
hist(df_butter$Energ_Kcal)
qplot(df_cheese$Shrt_Desc,df_cheese$Energ_Kcal)
qplot(df_butter$Shrt_Desc,df_butter$Energ_Kcal)

# ggplot




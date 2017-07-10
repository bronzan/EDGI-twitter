## Written by Kasturi Shah, May 9 2017 and May 30 2017
# FOR TV METS
# Script to check the number of retweets of just weather- versus ALL climate-related tweets 
# Also finds list of most used political keywords

rm(list=ls())
gc()
options(stringsAsFactors = FALSE) # don't get shafted

setwd('S:/KasturiShah/TwitterStreaming/Problem versus Solution/')
climate_words <- read.table("climate-change-epa.txt",header=FALSE,sep="\n",quote="") # with climate change and global warming
weather_words <- read.table("weather-word-list.txt",header=FALSE,sep="\n",quote="")
political_words <- read.table("political-word-list.txt",header=FALSE,sep="\n",quote="")

analysis_name = "tv-mets"
print("Loading data")
setwd("S:/KasturiShah/TwitterStreaming/TV_Mets_Analysis/Data/")
if (analysis_name == "tv-mets") {
  twitdatasample <- read.csv("tvmets_07June2017.csv",stringsAsFactors = FALSE)
}
ntweets <- dim(twitdatasample)[1];

# finding tweets with weather-related content

weatherhits <- as.data.frame(twitdatasample$tweet_text)
colnames(weatherhits) <- "tweet_text"
for (i in 1:dim(weather_words)[1]) { # for all weather-related words
  weatherhits <- cbind(weatherhits, grepl(weather_words[i,1],twitdatasample$tweet_text,ignore.case=TRUE)) # checking each tweet for this word
  colnames(weatherhits) <- c(colnames(weatherhits)[1:length(colnames(weatherhits))-1],weather_words[i,1]) # renaming columns
}
totalweatherhits <- rowSums(weatherhits[2:dim(weatherhits)[2]],na.rm=TRUE)
popularweatherwords <- as.data.frame(colSums(weatherhits[,2:dim(weatherhits)[2]],na.rm=TRUE))
index_tweets_weather <- totalweatherhits > 0 # which tweets have weather words?
setwd('S:/KasturiShah/TwitterStreaming/TV_Mets_Analysis/Data/')
write.csv(popularweatherwords,"weatherhits_wordcount.csv")

# finding tweets with climate-related content
climatehits <- as.data.frame(twitdatasample$tweet_text)
colnames(climatehits) <- "tweet_text"
for (i in 1:dim(climate_words)[1]) { # for all weather-related words
  climatehits <- cbind(climatehits, grepl(climate_words[i,1],twitdatasample$tweet_text,ignore.case=TRUE)) # checking each tweet for this word
  colnames(climatehits) <- c(colnames(climatehits)[1:length(colnames(climatehits))-1],climate_words[i,1]) # renaming columns
}
totalclimatehits <- rowSums(climatehits[2:dim(climatehits)[2]],na.rm=TRUE)
popularclimatewords <- as.data.frame(colSums(climatehits[,2:dim(climatehits)[2]],na.rm=TRUE))
setwd('S:/KasturiShah/TwitterStreaming/TV_Mets_Analysis/Data/')
write.csv(popularclimatewords,"climatehits_wordcount.csv")

# finding tweets with climate-related content
politicalhits <- as.data.frame(twitdatasample$tweet_text)
colnames(politicalhits) <- "tweet_text"
for (i in 1:dim(political_words)[1]) { # for all weather-related words
  politicalhits <- cbind(politicalhits, grepl(political_words[i,1],twitdatasample$tweet_text,ignore.case=TRUE)) # checking each tweet for this word
  colnames(politicalhits) <- c(colnames(politicalhits)[1:length(colnames(politicalhits))-1],political_words[i,1]) # renaming columns
}
totalpoliticalhits <- rowSums(politicalhits[2:dim(politicalhits)[2]],na.rm=TRUE)
popularpoliticalwords <- as.data.frame(colSums(politicalhits[,2:dim(politicalhits)[2]],na.rm=TRUE))
setwd('S:/KasturiShah/TwitterStreaming/TV_Mets_Analysis/Data/')
write.csv(popularpoliticalwords,"politicalhits_wordcount.csv")

# get tweet text with just climate = index 28
index_rowswithclimate <- climatehits[,29] > 0
textwithjustclimate <- climatehits[index_rowswithclimate,1]
write.csv(textwithjustclimate,"text_withonlyclimateasakeyword.csv")

index_tweets_climate <- totalclimatehits > 0 # which tweets have weather words?
tweets_climate <- twitdatasample[index_tweets_climate,] # only tweets with weather words

setwd('S:/KasturiShah/TwitterStreaming/TV_Mets_Analysis/Data/')
write.csv(tweets_climate,paste0(analysis_name,"_climate_tweets.csv"))

# finding just weather-related words
index_just_weather <- c()
for (i in 1:length(index_tweets_weather)) {
  if (sum(index_tweets_weather[i] != index_tweets_climate,na.rm=TRUE) > 0) { # tweet ONLY has weather words and no climate words
    index_just_weather <- c(index_just_weather,index_tweets_weather[i])
  }
}
tweets_weather <- twitdatasample[index_just_weather,] # only tweets with weather words
setwd('S:/KasturiShah/TwitterStreaming/TV_Mets_Analysis/Data/')
write.csv(tweets_weather,paste0(analysis_name,"_just_weather_tweets.csv"))

index_weather_and_climate_tweets <- rbind(index_just_weather,index_tweets_climate) # weather and climate words
tweets_weather_and_climate <- twitdatasample[index_just_weather,]
write.csv(tweets_weather_and_climate,paste0(analysis_name,"_weather_and_climate_tweets.csv"))

library(tidyr)
library(dplyr)
library(lubridate)

## There were a few date/time/site combinations with repeat values for the calispell creek data
## I removed them so we didn't have problems with the spread functin

wtemp2<-gather(wtemp, site, temperature, calispell_temp:winchester_temp) %>%
  group_by(date, time, site) %>%
  summarize(temperature=mean(temperature)) %>%
  spread(site, temperature, fill=NA)

# write.csv(wtemp2, "Calispell Creek and Tributary Temperatures2.csv", row.names=F)

## GENERATE MESSY FISH DATA
dat<-tbl_df(read.csv("LowSpokaneClean.csv")) %>%
  mutate(FishLength_Weight=paste(FinLength, Weight, sep="_")) %>%
  select(Date, Year, Pass, Site.No., FishNo, Species, FishLength_Weight, ScaleAge, CapturedFloyTagNo, AppliedFloyTagNo,
       AgeMethod)

efdat<-tbl_df(read.csv("Lower Spokane River_2013_effort.csv"))
  names(efdat)=c("Pass", "Site", "Start_lat", "Start_long", "End_lat",
                 "End_long", "Date", "Time", "Voltage", "Percent", "PulseFreq", "Amps", "Effort",
                 "WaterTemp", "Observers", "Boat", "GeneralLocation", "Notes")
efdat <- mutate(efdat, Date=mdy(Date)) %>%
  arrange( Site)

names(dat)=c("Date", "Year", "Pass", "Site", "FishNo", "Species", "FishLength_Weight", "ScaleAge", "CapturedFloyTagNo",
             "AppliedFloyTagNo", "AgeMethod")
dat<-mutate(dat, Date=mdy(Date))

tog<-tbl_df(merge(dat, efdat))

tog<-tog %>%
  select(Date, Site, Pass, FishNo, Species, FishLength_Weight, ScaleAge, CapturedFloyTagNo, AppliedFloyTagNo, 
          Effort) %>%
  arrange(Site)

write.csv(tog, "LittleSpokane_Messy.csv", row.names=F)



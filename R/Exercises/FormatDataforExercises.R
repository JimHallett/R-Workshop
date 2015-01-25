## There were a few date/time/site combinations with repeat values for the calispell creek data
## I removed them so we didn't have problems with the spread functin

wtemp2<-gather(wtemp, site, temperature, calispell_temp:winchester_temp) %>%
  group_by(date, time, site) %>%
  summarize(temperature=mean(temperature)) %>%
  spread(site, temperature, fill=NA)

# write.csv(wtemp2, "Calispell Creek and Tributary Temperatures2.csv", row.names=F)

dat<-tbl_df(read.csv("LowSpokaneClean.csv")) %>%
  mutate(FishLength_Weight=paste(FinLength, Weight, sep="_")) %>%
  select(Date, Year, Pass, Site.No., FishNo, Species, FishLength_Weight, ScaleAge, CapturedFloyTagNo, AppliedFloyTagNo,
         CapturedPITTagNo, ActivePITTagNo, AgeMethod)
dat



# %>%
# separate(site, c("site", "measurement")) %>%
# select(-measurement)


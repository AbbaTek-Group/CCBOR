library(tidyverse)
library(readxl)
library(plyr)

combined_data <- read.csv("Data/tidy_data/ccbordata.csv", stringsAsFactors = T)
sampling_date1 <- as.Date(combined_data$Sampling_date, "%m/%d/%y")
combined_data <- cbind(sampling_date1, combined_data)%>%select(-`Rainfall_.inches.`, Notes)
combined_data <- combined_data %>% mutate(Day = day(sampling_date1), Month = month(sampling_date1), Year = year(sampling_date1))
combined_data %>% select(Site, Day, Month, Year, Flow_rate_.0.5., Water_turbidity_.0.3., Water_temperature_.degrees.C., Total_dissolved_solids_.mg.L.,Conductivity_.µS., Salinity_.ppm.) %>% group_by(Site, Day, Month, Year)%>% summary()
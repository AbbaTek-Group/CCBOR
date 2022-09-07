library(tidyverse)
library(readxl)
library(plyr)
library(fs)


# read the raw data with all sites combined
x1_data <- "/cloud/project/Data/raw_data/CCBOR Water Testing Project data.xlsx"
ccbor_raw_data <- read_excel('CCBOR Water Testing Project data.xlsx')

# Before reading the data, we will return the names of all sheets containing 
# the site number for later use

excel_sheets(x1_data)  

# We can now read in just each site from the spreadsheet by specifying the
# the sheet name or number

df_Site_name <- read_excel(path = x1_data, sheet = "Site 1")  # or

df_Site_number <- read_excel(path = x1_data, sheet = 1)

identical(df_Site_name, df_Site_number)  # test


# write a function to read each tab and clean it up before append into a list


all_sites <- function(k) {
  
  # read data & excel sheet number 
  xl_data <- "/cloud/project/Data/raw_data/CCBOR Water Testing Project data.xlsx"
  df_Site_number <- read_excel(path = x1_data, sheet = k)
  
   
    # Time series plot
    
    #lineplot <- df_Site_number %>% mutate(date = as.Date(Sampling_date, "%m/%d/%y"), Site = as.factor(`Site(1-9)`)) %>% 
     # ggplot(aes(date, `Conductivity(µS)`, colour=Site)) + geom_line(na.rm = T) + 
      #labs(y='Conductivity(µS)')
    
    # Box and whisker plot
    
    Boxplot <- df_Site_number %>% mutate(date = as.Date(Sampling_date, "%m/%d/%y"), Site = as.factor(`Site(1-9)`)) %>% 
      ggplot(aes(date, `Conductivity(µS)`, colour=Site)) + geom_boxplot(na.rm = T) + 
      labs(y='Conductivity(µS)')
    
    
    
    # Spatial Plot
    
      
      
       }
    
############  

# Time series plot  

ccbor_raw_data <- read_excel(path = x1_data, sheet = 10)
ccbor_raw_data %>% 
  mutate(date = as.Date(Sampling_date, "%m/%d/%y"), 
         Site = as.factor(`Site(1-9)`)) %>% unite (Location1, Watershed:Location, remove = F) %>%
     ggplot(aes(date, `Conductivity(µS)`, colour=Site)) + geom_line(na.rm = T) + 
      facet_wrap(~Site) + 
  labs(title = 'Observed Conductivity(µS) in time', x = 'Date of Observation', y = 'Conductivity(µS)') + 
  theme_bw()
     

# Spatial plot
ccbor_raw_data %>% select(`Conductivity(µS)`, Lat, Long) %>%         # change here for topsoil, root and below root zone
  #select(Year, Month, Probe, soil_moisture) %>% 
  #mutate(mean_VSM = mean(soil_moisture)) %>% 
  ggplot(aes(Long, Lat)) + geom_point(aes(Long, Lat, colour = `Conductivity(µS)`), size = 5) + geom_text(aes(label = `Site(1-9)`),
                                                                                               data = ccbor_raw_data, nudge_x = 0.00005) +
  xlab('Longitude (deg)') + labs(title = 'Conductivity(µS)')


# Extract all sites into a list

Allsheets <- list(1:9)
Allsites <- list()
df <- for (i in 1:length(Allsheets)) {Allsites[[1]] <- read_excel(path = x1_data, sheet = Allsheets)}





combined_data <- read.csv("Data/tidy_data/ccbordata.csv", stringsAsFactors = T)
sampling_date1 <- as.Date(combined_data$Sampling_date, "%m/%d/%y")
combined_data <- cbind(sampling_date1, combined_data)%>%select(-`Rainfall_.inches.`, Notes)
combined_data <- combined_data %>% mutate(Day = day(sampling_date1), Month = month(sampling_date1), Year = year(sampling_date1))
combined_data %>% select(Site, Day, Month, Year, Flow_rate_.0.5., Water_turbidity_.0.3., Water_temperature_.degrees.C., Total_dissolved_solids_.mg.L.,Conductivity_.µS., Salinity_.ppm.) %>% group_by(Site, Day, Month, Year)%>% summary()
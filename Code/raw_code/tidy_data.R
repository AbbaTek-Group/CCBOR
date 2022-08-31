library(tidyverse)
library(readxl)
library(plyr)

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


# To import all sheets from a workbook. We will do this via lapply() and do.call(), 
# iterating over the names (or range) of our sheets; passing read_excel() as 
# our function. The resulting object should be a list of nine (9) data frames; 
# one (1) per tab.

tab_names <- excel_sheets(path = x1_data)

list_all_sites <- 
  lapply(tab_names[-10], function(x) read_excel(path = x1_data, sheet = x))

all_sites <- do.call('rbind',list_all_sites)  # combined all sites

GPS_locations <-     # isolated data frame with GPS locations
  lapply(tab_names[10], function(x) read_excel(path = x1_data, sheet = x))

sites_combined <- merge(all_sites, GPS_locations, by='Watershed')

sites_combined %>% 
  ggplot(aes('Sampling date','Conductivity (µS)',  colour = Watershed)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")


names(all_sites)



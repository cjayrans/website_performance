####################### global.R
library(plyr)
library(shiny)
library(shinydashboard)
library(data.table)
library(plotly)
library(tidyr)
library(feather)
library(DT)
library(rsconnect)


# Read in monthly summary files for both the entire website, and page-specific
organic_summ_all <- read_feather("~/Shiny/Sales_Data/csv_files/monthly_sales_combined.feather")
organic_summ_page_specific <- read_feather("~/Shiny/Sales_Data/csv_files/monthly_sales_page_breakout.feather")

# Gather both data frames, allowing us to treat each column as a factor
organic_summ_gather <- gather(organic_summ_all, key = 'Metric', value = 'Value', -month)
organic_page_gather <- gather(organic_summ_page_specific, key='Metric', value='Value', -month, -site_page)

# Subset 'organic_summ_all' into just sales information for standalone table
organic_summ_sales <- organic_summ_all[,c('month','buys','total_revenue','gross_spread','gross_spread_perc','spread_per_unit','cost_per_unit','salePrice_per_unit')]

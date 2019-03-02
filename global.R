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
library(scales)


# Read in monthly summary files for both the entire website, and page-specific
organic_summ_all <- read_feather("~/Shiny/Sales_Data/csv_files/monthly_sales_combined.feather")
organic_summ_page_specific <- read_feather("~/Shiny/Sales_Data/csv_files/monthly_sales_page_breakout.feather")

# Gather both data frames, allowing us to treat each column as a factor
organic_summ_gather <- gather(organic_summ_all, key = 'Metric', value = 'Value', -month)
organic_page_gather <- gather(organic_summ_page_specific, key='Metric', value='Value', -month, -site_page)


# Subset 'organic_summ_all' into just sales information for standalone table
organic_summ_sales <- organic_summ_all[,c('month','buys','total_revenue','gross_spread','gross_spread_perc','spread_per_unit','cost_per_unit','salePrice_per_unit')]



org_summ_num_temp1 <- lapply(organic_summ_sales[,c('buys')],
                             function(x) prettyNum(x, big.mark=","))

# org_summ_sales_dollars2 <- as.data.frame(apply(org_summ_sales_temp2[,
#                                                                     c('total_revenue','gross_spread','spread_per_unit','cost_per_unit','salePrice_per_unit')],
#                                                2, function(x) dollar_format()(x)))

org_summ_sales_dollars1 <- lapply(organic_summ_sales[, c('total_revenue','gross_spread','spread_per_unit','cost_per_unit','salePrice_per_unit')],
                                  function(x) dollar_format()(x))

org_summ_sales_perc1 <- lapply(organic_summ_sales[, c('gross_spread_perc')], function(x) percent(x))

# cbind(org_summ_sales_temp2[,c('Monthly','buy_count','lots_sold')], org_summ_sales_temp3, org_summ_sales_temp2[,c('spread_perc','success_rate')])
organic_summ_sales1In <- cbind(organic_summ_sales[,c('month')], org_summ_num_temp1, org_summ_sales_dollars1, org_summ_sales_perc1)

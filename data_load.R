############ Data Load
library(readr); library(rsconnect); library(data.table); library(lubridate); library(dplyr); library(feather); library(shiny); library(curl)
options(rsconnect.http.trace = TRUE)
options(rsconnect.http.verbose = TRUE)
options(rsconnect.http.trace.json = TRUE)

# Connect Rstudio to SHinyApps.io account
rsconnect::setAccountInfo(name= '<NAME>' , token='<TOKEN>', secret='<SECRET>')
rsconnect::setAccountInfo(name='cransford-shiny', token='EAE6778C1C0DEDD79910FB10FE3B222B', secret='ErBWsGCfvKUfuHVTNcQWbkR2w/DZKvTDD88NYJsJ')

## Create table containing data summarized for each month, and site page
month <- rep(seq(as.Date('2018-02-01'), Sys.Date(), by='month'), 3)
num_months <- length(month)
site_page <- rep(c("landing_page","clearance_page","inventory_page"),num_months/3)
total_arrivals <- round(rnorm(num_months, mean = 100000, sd=1200))
step_1 <- round(rnorm(num_months, mean=80000, sd=900))
step_2 <- round(rnorm(num_months, mean=70000, sd=1200))
step_3 <- round(rnorm(num_months, mean=62000, sd=500))
buys <- round(rnorm(num_months, mean=53000, sd=600))
total_revenue <- round(rnorm(num_months, mean=7155000, sd=100000))
gross_spread <- round(rnorm(num_months, mean=2647350, sd=50000))

# Combine all vectors created above into a single data frame
df_pages <- data.frame(month=month, site_page=site_page, total_arrivals=total_arrivals, step_1=step_1, step_2=step_2, step_3=step_3,
                       buys=buys, total_revenue=total_revenue, gross_spread=gross_spread)

# Convert 'site_page' variable back to character format
df_pages$site_page <- as.character(df_pages$site_page)

# Create conversion variables - % of users that make it from one step to another
df_pages <- df_pages %>% mutate(arrivals_conversion = round(step_1/total_arrivals,2),
                                step1_conv = round(step_2/step_1,2),
                                step2_conv = round(step_3/step_2,2),
                                step3_conv = round(buys/step_3,2),
                                gross_spread_perc = round(gross_spread/total_revenue,2),
                                spread_per_unit = round(gross_spread/buys),
                                cost_per_unit = round((total_revenue-gross_spread)/buys),
                                salePrice_per_unit = round(total_revenue/buys))

# Save file to feather document - faster saving/loading
write_feather(df_pages, "~/Shiny/Sales_Data/csv_files/monthly_sales_page_breakout.feather")




# Create table containing data summarized by month
df_all <- setDT(df_pages)[,
                          list(
                            total_arrivals = sum(total_arrivals),
                            step_1 = sum(step_1),
                            step_2 = sum(step_2),
                            step_3 = sum(step_3),
                            buys = sum(buys),
                            total_revenue = sum(total_revenue),
                            gross_spread = sum(gross_spread)
                          ),
                          by = month]

# Create conversion variables - % of users that make it from one step to another
df_all <- df_all %>% mutate(arrivals_conversion = round(step_1/total_arrivals,2),
                            step1_conv = round(step_2/step_1,2),
                            step2_conv = round(step_3/step_2,2),
                            step3_conv = round(buys/step_3,2),
                            gross_spread_perc = round(gross_spread/total_revenue,2),
                            spread_per_unit = round(gross_spread/buys),
                            cost_per_unit = round((total_revenue-gross_spread)/buys),
                            salePrice_per_unit = round(total_revenue/buys))

# Save file to feather document - faster saving/loading
write_feather(df_all, "~/Shiny/Sales_Data/csv_files/monthly_sales_combined.feather")

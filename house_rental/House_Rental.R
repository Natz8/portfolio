# House_Rental
# Stanley Lais


# Library  ---------------------------------------------------------------------

## Install
install.packages("dplyr")         # to Manipulating houseRental Frame
install.packages("tidyr")         # to cleaning up houseRental
install.packages("readr")         # to read rectangular text houseRental
install.packages("stringr")       # to working with string or text information
install.packages("ggplot2")       # for creating graphics or houseRental visualization
install.packages("wesanderson")   # color palette 

## Import/Load
library(dplyr)                    # to Manipulating houseRental Frame 
library(tidyr)                    # to cleaning up houseRental
library(readr)                    # to read rectangular text houseRental
library(stringr)                  # to working with string or text information
library(ggplot2)                  # to load different graph to view the houseRental
library(wesanderson)              # color palette 


# Import Data ------------------------------------------------------------------

filepath <-'D:\\Portofolio data analyst\\House_Rental\\House_Rental_Dataset.csv'
houseRental <- read.csv(filepath,           # Import from csv
                        header = TRUE,        # True if file has header
                        sep = ',')            # separator or Delimiter is "," (comma)


# Data Exploration -------------------------------------------------------------

head(houseRental)                 # Preview Column names and 6 first row
str(houseRental)                  # Check the houseRental structures(the houseRental structure of houseRental is houseRental frame)
sum(is.na(houseRental))           # Check is there any NA values in the houseRental
summary(houseRental)              # Create Summary for each column (min, median, mean, max)
houseRental %>% sapply(class)     # information about class of each column in houseRental

houseRental %>% 
  group_by(area_type) %>%         # {dplyr} group houseRental 
  drop_na() %>%                     # {tidyr} drop_na() drop row with a NA Value 
  summarise(n_area_type = n())      # {dplyr} n() count how much houseRental in each group


# Data Cleaning ----------------------------------------------------------------

names(houseRental) = c("p_date", # to rename each column names
                "bhk", 
                "rent", 
                "size", 
                "floor", 
                "a_type", 
                "a_locality", 
                "city",
                "f_status",
                "t_preferred",
                "bathroom",
                "contact") 

summary(houseRental$p_date)       # Data type is character, we want to change it into time
houseRental$p_date <- as.POSIXct(x=houseRental$p_date,
                                 format = "%m/%e/%y")   # data type changed from character into time (POSIXct)
summary(houseRental$p_date)       # Data type is date 

# Data Analysis ----------------------------------------------------------------


## Pie Chart

### Analysis 1: Which furnishing status has higher count
houseRental %>% group_by(f_status) %>% summarise(count = n()) %>%
  ggplot(aes(x = "", y = count, fill = f_status)) + 
  geom_bar(stat="identity") +
  coord_polar("y") +  
  scale_fill_manual(values = wes_palette("Moonrise3", 3, type = "discrete")) +
  labs(title = "Rental House Furnish Status",x ="",y ="",fill="")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))
  

### Analysis 2: Total Number of Area Types	
houseRental %>% group_by(a_type) %>% summarise( count = n()) %>%
  ggplot(aes(x="", y= count, fill=a_type)) +
  geom_bar(stat="identity") +
  coord_polar(theta='y') +
  scale_fill_manual(values = wes_palette("Cavalcanti1", 3, type = "discrete")) +
  labs(title = "Total Number of Area Types",
       x = "", y = "",fill = "")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))



### Analysis 3: Total Furnished House That Is Handled by Each Contact
houseRental %>% group_by(contact, f_status) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x="", y=count, fill=f_status)) +
  geom_bar(stat="identity",position = position_fill()) +
  coord_polar(theta='y') +
  facet_wrap(vars(contact))+
  scale_fill_manual(values = wes_palette("Zissou1", 3, type = "discrete")) +
  labs(title = "Total Furnished House That Is Handled by Each Contact",
       x = "", y = "",fill = "")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.text.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2)) 

### Analysis 4: Total of Area Type Handled by Different Contacts
houseRental %>% group_by(contact, a_type) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x="", y=count, fill=a_type)) +
  geom_bar(stat="identity",position = position_fill()) +
  coord_polar(theta='y') +
  facet_wrap(~contact)+
  scale_fill_manual(values = wes_palette("Zissou1", 3, type = "discrete")) +
  labs(title = "Total of Area Type Handled by Different Contacts",
       x = "", y = "",fill = "")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.text.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))


## Column Chart / Bar Chart

### Analysis 5: Relationship between furnishing status and tenant preferred class
houseRental %>% group_by(f_status, t_preferred) %>% 
  summarise(Total_Count = n()) %>%
  ggplot(aes(x=t_preferred, y=Total_Count,fill=f_status)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_fill_manual(values = wes_palette("Zissou1", 3, type = "discrete")) +
  geom_text(aes(label=Total_Count), vjust=1.6, color="white",
            position = position_dodge(0.9),size=3)+
  labs(title = "Furnishing Status and Tenant Preferred",
       x = "Tenant Preffered", y = "",fill = "Furnishing Status") +
  theme_minimal()+
  theme(
    plot.background=element_rect(fill = "#816c5b"),
    text = element_text(color = "white"),
    axis.text = element_text(color = "white"))



### Analysis 6: furnishing status in each city
houseRental %>% group_by(f_status, city) %>% 
  summarise(Total_Count = n()) %>%
  ggplot()+
  geom_bar(aes(x = f_status, y = Total_Count, fill = f_status), stat="identity")+
  facet_wrap(vars(city))+
  scale_fill_manual(values = wes_palette("Zissou1", 3, type = "discrete"))+
  labs(title = "Furnishing Status in Each City",
       x = "", y = "",fill = "Furnishing Status")+
  theme(
    axis.text.y = element_text(color = "white"),
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    plot.background=element_rect(fill = "#816c5b"), 
    panel.background = element_blank(),
    plot.title = element_text(color = "White",size = 15),
    strip.background = element_blank(),
    strip.text = element_text(color = "white", size = 12, ),
    legend.background = element_blank(),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white"))


### Analysis 7: Total houses available in each city	
houseRental %>%
  ggplot(aes(x =city ,fill= city)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = wes_palette("Moonrise3", 6, type = "continuous"))+
  labs(title = "Total Houses Available in Each City	",
       y = "Count", x = "",fill = "")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 8: Preferred Tenant in Each City	
houseRental %>%
  ggplot(aes(x =t_preferred,fill=t_preferred)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = wes_palette("Royal2", 3, type = "continuous"))+
  facet_wrap(vars(city))+
  labs(title = "Preferred Tenant in Each City		",
       y = "Count", x = "",fill = "Preferred Tenant")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.text.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 9: Preferred Tenant	
houseRental %>%
  ggplot(aes(x =t_preferred ,fill=t_preferred)) +
  geom_bar(stat="count") +
  coord_flip()+
  scale_fill_manual(values = wes_palette("Darjeeling1", 3, type = "discrete"))+
  labs(title = "Total House Preferred for Bachelor and Families	",
       y = "Count", x = "",fill = "")+
  theme(
    panel.background = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))  

### Analysis 10: Type of BHK Popular in Different City
houseRental %>% 
  ggplot()+
  geom_bar(aes(x =as.character(bhk), fill =as.character(bhk)), stat="count")+
  facet_wrap(vars(city))+
  scale_fill_manual(values = wes_palette("BottleRocket1", 6, type = "discrete"))+
  labs(title = "Type of BHK Popular in Different City",
       x = "BHK", y = "",fill = "BHK")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.title.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 11: Popular Contact Numbers for Renting Houses
houseRental %>%
  ggplot(aes(x =contact ,fill=contact)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = wes_palette("GrandBudapest1", 3, type = "discrete"))+
  labs(title = "Popular Contact Numbers for Renting Houses",
       y = "Count", x = "",fill = "")+
  theme(
    panel.background = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))


## Box plot

### Analysis 12: Comparison of Rent Prices to Furnishing Status
houseRental %>% filter(rent < 100000) %>%
  ggplot(aes(x=f_status, y=rent,fill=f_status)) + 
  geom_boxplot(lwd = 1,colour = "white", outlier.alpha = 0.1, outlier.size = 5) +
  scale_fill_manual(values = wes_palette("GrandBudapest1", 3, type = "discrete"))+                                # Color3_cba
  labs(title = "Rental House Price Based on Furnish Status",
       subtitle = "Price Range INR 0 - 100.000 / Month", y = "Rent Price (INR/Month)", 
       x = "",fill = "Furnishing Status")+
  theme(
    axis.text.y = element_text(color = "white"),
    axis.text.x = element_blank(),
    axis.title = element_text(color = "white"),
    axis.ticks = element_blank(),
    plot.background=element_rect(fill = "#816c5b"), 
    panel.background = element_blank(),
    plot.title = element_text(color = "White"),
    plot.subtitle = element_text(color = "White"),
    legend.background = element_blank(),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white"),
    legend.key = element_blank())

### Analysis 13: Rental House Price in Each City
houseRental %>% filter(rent < 100000) %>%
  ggplot(aes(x=city, y=rent,fill=city)) + 
  geom_boxplot(lwd = 1,colour = "black", outlier.alpha = 0.1, outlier.size = 5) +
  scale_fill_manual(values = wes_palette("Rushmore1", 6, type = "continuous"))+
  labs(title = "Rental House Price in Each City ",
       subtitle = "Range INR 0 - 100.000 / month", y = "Rent Price (INR/Month)", 
       x = "",fill = "City")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 14: Rental House Size in Each City
houseRental %>% filter(size < 4000) %>%
  ggplot(aes(x=city, y=size,fill=city)) + 
  geom_boxplot(lwd = 1,colour = "black", outlier.alpha = 0.1, outlier.size = 5) +
  scale_fill_manual(values = wes_palette("Royal1", 6, type = "continuous"))+
  labs(title = "Rental House size in Each City ",
       subtitle = "Size 0 - 4.000 Sq.Ft", y = "Size (Sq.Ft)", 
       x = "",fill = "City")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 15: House Rental Prices by Each Contact	
houseRental %>% filter(rent < 100000) %>%
  ggplot(aes(x=contact, y=rent,fill=contact)) + 
  geom_boxplot(lwd = 1,colour = "black", outlier.alpha = 0.1, outlier.size = 5) +
  scale_fill_manual(values = wes_palette("IsleofDogs2", 3, type = "discrete"))+
  labs(title = "House Rental Prices by Each Contact",
       subtitle = "Range INR 0 - 100.000 / Month", y = "Rent Price (INR/Month)", 
       x = "",fill = "")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 16: House Size Handled by Different Contacts
houseRental %>% filter(size < 4000) %>%
  ggplot(aes(x=contact, y=size,fill=contact)) + 
  geom_boxplot(lwd = 1,colour = "black", outlier.alpha = 0.1, outlier.size = 5) +
  scale_fill_manual(values = wes_palette("Rushmore", 3, type = "discrete"))+
  labs(title = "House Size Handled by Different Contacts",
       subtitle = "Size from 0 - 4.000 sqft", y = "Size (sqft)", 
       x = "",fill = "")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))


## histogram

### Analysis 17: Number of houses for rent posted over time       
houseRental %>%
  ggplot(aes(p_date, fill=..count..)) +
  geom_histogram()+
  scale_fill_gradientn(colours = wes_palette("Rushmore", 50, type = "continuous")) +
  labs(title = "Rent House Posting Trends") +
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.title.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))


## Line Chart 

### Analysis 18: Rental house area type trend 
houseRental %>%
  ggplot(aes(x=p_date,color=a_type)) +
  geom_line(stat = "count",size=1) +
  scale_color_manual(values = wes_palette("Darjeeling1", 3, type = "discrete")) +
  labs(title = "Rental House Area Type Trend ")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.title.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))

### Analysis 19: Number of houses for rent in each city over time
houseRental %>%
  ggplot(aes(x=p_date,color=city)) +
  geom_line(stat = "count",size=1) +
  scale_color_manual(values = wes_palette("BottleRocket1", 6, type = "discrete")) +
  labs(title = "Rent House Posted Overtime")+
  facet_grid(vars(city))+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.title.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_line(colour = "#99928d", linetype = 2))


## Bubble Chart / geom count

### Analysis 20: Rental House Prices Over Time
houseRental %>% filter(rent < 100000) %>%
  ggplot(aes(x=p_date, y=rent))+
  geom_count(aes(color = after_stat(n))) +
  scale_colour_gradientn(colours = wes_palette("Darjeeling1", 2, type = "continuous"))+
  labs(title = "Rent House Posted Based on Price",
       subtitle = "Price Range INR 0 - 100.000 / month", y = "Price (INR/Month)")+
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.title.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    panel.grid = element_line(colour = "#99928d", linetype = 2))


### Analysis 21: Rental House Size Over Time
houseRental %>% filter(size < 4000) %>%
  ggplot(aes(x=p_date, y=size))+
  geom_count(aes(color = after_stat(n))) +
  scale_colour_gradientn(colours = wes_palette("Darjeeling1", 2, type = "continuous"))+
  labs(title = "Rental House Posted Based on Size",
       subtitle = "Size Range 0 - 4.000 sqft", y = "Size (sqft)") +
  theme(
    panel.background = element_blank(),
    legend.position = "bottom",
    legend.background = element_blank(),
    axis.title.x = element_blank(),
    plot.background = element_rect(fill = "#fcf4dd"),
    panel.grid = element_line(colour = "#99928d", linetype = 2))
















# Craigslist Used Cars
This is the walkthrough and breakdown of the entire process from obtaining the used car data, cleaning the data, querying in SQL, and finally visualizing in Tableau


# Obtaining data
Have a deep passion for cars and have always been interested in how different factors play a role in the overall pricing of vehicles. Went on the search for a challenging dataset which would give us some key insights that we would have to work for. After searching for a bit saw most of the car datasets were often too clean, not too much data, or were not local (US). I eventually came across this dataset which was scraped from craigslist. It was very messy, unorganized, but at a glance could tell it contained a lot of useful information. Ultimately imported this dataset into excel to get a better look at what we were dealing with. 


Original excel file...

# Questions about the data
After getting a good understanding of the data, I came up with some questions I would like to answer. 
- Average price and mileage of cars per state?
- Number of listings per manufacturer?
- Do manual cars tend to have higher mileage?
- How does the type of car impact price or even location?
- Does paint color have an effect on price or maybe location?
  - Overall was curious how each of these factors/fields correlate to the price of the     
    vehicles relative to their mileage (Obviously mileage has a big impact on price → Going to     
    have to continuously work with the data because we can then get a better idea of how we 
    can draw better conclusions. As of now there are still a lot of factors at play. 
    For example, although our analysis might present that manual cars cost a lot more, it 
    could be possible that our dataset contains a lot of low mileage manual cars and doesn't 
    necessarily represent the entire truth. Just something to keep in mind. 

# Cleaning the data
After determining some questions, we then made a copy of our file. This is especially useful because it allows us to manipulate our dataset in various ways without the pressure of potentially losing valuable information or permanently impacting our original data. After creating our copy, the first step was to make sure all the data was cleaned and only the information that was needed remained.

- Columns deleted: urls, latitude/longitude coordinates, county (empty), description (often paragraphs long and not containing any contributing information → This is also why copying the original dataset is useful.
- Removed all duplicates and heavily blank records. 

- Previous order/name of columns:
Id, region, price, year, manufacturer, model, condition, cylinders, fuel, odometer, title_status, transmission, VIN, drive, size, type, paint_color, state, posting_date

- New order/name of columns:
ID, PostDate, State, Region, Year, Make, Model, Type, Mileage, Price, Condition, Cylinders, Fuel, Transmission, Drivetrain, Paint, TitleStatus

In this project we just wanted to answer a few questions based on our data, because of this I decided to get rid of any data that would not be useful in our analysis. For example, any data that had numerous blanks or overall incorrect information would be removed. Due to having over 400,000 rows worth of craigslist listing, it would not hurt, but rather improve our analysis through having clean, structured, and easily readable data. Our data would still included listings for all US states. 

The first alarming field in the dataset was the "Model" of the vehicle, which is based on the input made from the craigslist user. This leaves us with many values which do not represent the true model of the vehicle. For example, some values within this column contain the model of vehicle as well as other information such as mileage, condition, parts, modifications, etc. To get rid of these, we simply use our filter special function to examine which values within this column do not represent the true model of the vehicle. Filter allows us to see any unwanted information. For example, we used the filter ability to get rid of any “parts only” listings

“Type” had “truck” and “pickup” → changed to just truck using find and replace.

Changed all “other” values in the transmission type to just be “automatic”. With manuals being the minority, and knowing a vehicle is either automatic, manual, or a CVT, we went ahead and grouped CVT transmission with automatics. 

Saw that there were some harley-davidson values in “make” and “model”. I personally know harley-davidson does not manufacture or own any trucks. They only partner with current manufacturers to create harley-davidson edition trucks. With that said the only two possible cases are the listing was either a motorcycle or a harley-davidson edition truck but we lacked the actual make and model of the vehicle so I went ahead and got rid of this data. 

Also noticed price numbers were off for vehicles. We had values going up to 1000 increasing by 1. Decided to only show prices greater than 1000 and less than 200,000. Anything not in this range was not valid and was used just as a filler value within the listing. 

Decided we don't want lowercase abbreviation for state. Used find and replace for this. 
We also want the first letter of each cell, especially state/region capitalized for proper use of the word. Although the formula we are going to use could have been used for the State, it was not necessary and the find and replace was just as effective for this because we wanted to change the entire value, but that is not the case here. 
So we began by inserting a new blank column to the right of the region in order to create our new properly formatted regions. After copying our column title over, we used the “=Proper()” formula with the parameter of our lowercase region in the cell to the left. We copy this all the way down and can see we now have each region properly formatted. Although this is right, we still have our previous column that we referenced to get our new proper formatting. If we were to delete our old column, it would impact our newly formatted column. To avoid this we copy our new formatted column and paste it in our previous column using paste special → values only. We can now delete our old column. We did this for all other columns.
- Used UPPER() for Drivetrain (4WD, RWD, FWD)

PostDate is formatted as “2021-05-03T14:02:03-0500”. I don't think the time is necessary so we will delete everything from “T” onwards. This is done using ctrl + h (Find & Replace) and replacing “T*” with nothing (blank). 

Our data is now clean and very organized with no blanks or invalid values.
Formatted as table for alternating colors, formatted fonts and positioning, and froze top row —> much easier to read and navigate.

Cleaned data: 


Copied the newly cleaned sheet as a separate CCSV file. Kept it separate, organized, and in CSV format so we can easily upload and work with the data in SQL and Tableau. 



# Craigslist Used Cars
This is the walkthrough and breakdown of the entire process from obtaining the used car data, cleaning the data, querying in SQL, and finally visualizing in Tableau


# Obtaining data
I have always had deep passion for cars and have always been interested in how different factors effect the market and overall pricing of vehicles. I went on the search for a challenging dataset which would give us some key insights regarding our interests. Throughout my search I noticed most of the car datasets were often too clean (not realistic), very small in size, or were not local (US). I eventually came across a dataset which was scraped from craigslist and uploaded to kaggle.com. It was very messy, unorganized, but at a glance I could tell it contained a lot of useful information. Ultimately, I imported this dataset into excel to get a better look at what we were dealing with. 


Original file preview: Seen in repository as "CraigslistCars(Raw).IPYNB"

# Questions about the data
After getting a good understanding of the data, I came up with some questions I would like to answer. 
- Average price and mileage of cars per state?
- Most popular manufacturers?
- Do manual cars tend to have higher mileage?
- How does the type of car impact price or even location (expect more AWD/4WD in colder climates)?
- Does paint color have an effect on price?
  - Overall was curious how each of these factors/fields correlate to the price of the     
    vehicles relative to their mileage (Obviously mileage has a big impact on price → Going to     
    have to continuously work with the data so we can get a better idea of how we'll be able to draw better conclusions. As of now there are 
    still a lot of factors at play. 
    - For example, although our analysis might present that manual cars cost a lot more, it 
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

In this project we just wanted to answer a few questions based on our data, because of this I decided to get rid of any data that would not be useful in our analysis. For example, any data that had numerous blanks or overall incorrect information would be removed. Due to having over 400,000 rows worth of craigslist listing, it would not hurt, but rather improve our analysis through having clean, structured, and easily readable data. Our data would still included listings for all 50 US states. 

The first alarming field in the dataset was the "Model" of the vehicle, which is based on the input made from the craigslist user. This leaves us with many values which do not represent the true model of the vehicle. For example, some values within this column contained the model of vehicle as well as other information such as mileage, condition, parts, modifications, etc. To get rid of these, we simply use our filter special function to examine which values within this column do not represent the true model of the vehicle. Filter allows us to see any unwanted information. For example, we used the filter ability to get rid of any “parts only” listings. Although not included here, we did use SQL's "LIKE" operator to further inspect some suspicious values. 

“Type” had “truck” and “pickup” → changed to just truck using find and replace.

Changed all “other” values in the transmission type to just be “automatic”. With manuals being the minority, and knowing a vehicle is either automatic, manual, or a CVT, we went ahead and grouped CVT transmission with automatics. 

Saw that there were some harley-davidson values in “make” and “model”. I personally know harley-davidson does not manufacture or own any trucks. They only partner with current manufacturers to create harley-davidson edition trucks. With that said the only two possible cases are the listing was either a motorcycle or a harley-davidson edition truck but we lacked the actual make and model of the vehicle so I went ahead and got rid of this data. 

Also noticed price numbers were off for vehicles. We had values going up to 1000 increasing by 1. Often times people will put a price place holder such as "123456", so we decided to get rid of anything similar to this. Ultimately decided to only show prices greater than 1000 and less than 200,000. Anything not in this range was not valid and was used just as a filler value within the listing. 

Decided we don't want lowercase abbreviation for state. Used find and replace for this. 
We also want the first letter of each cell, especially state/region capitalized for proper use of the word.
So we began by inserting a new blank column to the right of the region in order to create our new properly formatted regions. After copying our column title over, we used the “=Proper()” formula with the parameter of our lowercase region in the cell to the left. We copy this all the way down and can see we now have each region properly formatted. Although this is right, we still have our previous column that we referenced to get our new proper formatting. If we were to delete our old column, it would impact our newly formatted column. To avoid this we copy our newly formatted column and paste it in our previous column using paste special → values only. We can now delete our old column. We did this for all other columns.
- Used UPPER() for Drivetrain (4WD, RWD, FWD)

PostDate is formatted as “2021-05-03T14:02:03-0500”. I don't think the time is necessary so we will delete everything from “T” onwards. This is done using ctrl + h (Find & Replace) and replacing “T*” with nothing (blank). 

Our data is now clean and very organized with no blanks or invalid values.
Formatted as table for alternating colors, formatted fonts and positioning, and froze top row —> much easier to read and navigate.

Cleaned data preview: Seen in repository as "CraigslistCars(Cleaned).IPYNB"

Copied the newly cleaned sheet as a separate CCSV file. Kept it separate, organized, and in CSV format so we can easily upload and work with the data in SQL and Tableau. 

Visualization can be found at: https://public.tableau.com/app/profile/dylan.raposo
SQL queries can be found in: "CraigslistCarsQueries.sql"

Thoughts: Although we gained a lot of valuable insights from the data, I defintely plan on redoing this project in the future. Unfortunately, this dataset was scraped throughout the course of only a month and tried to obtain as much information from craigslist as possible. Of course this left us a lot of options, but it wasnt EXACTLY what we were looking for and made the database unnecessarily large and messy. When I eventually redo this project I plan on having a much stronger skillset which will enable me to cater the project to more of what I was aiming for. Next time around I plan to scrape data with fields much more specific to my needs and elimate any unwanted information. I would also like a much larger time range so we can see how time plays a role in the used car market. This will allow us to not only save space, but to also be much more effective and accurate throughout our analysis. 

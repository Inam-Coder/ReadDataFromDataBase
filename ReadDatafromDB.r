#Before Start Read data from DB first we install package
install.packages("RQLite")
library("RSQLite")
#load mt cars data frame
data("mtcars")
#create row in mtcars 
mtcars$car_name<-rownames(mtcars)
mtcars$car_name
rownames(mtcars)<-c()
head(mtcars)
#Create database and table
#create or connect database
coon<-dbConnect(RSQLite::SQLite(),"CarDB.db")
coon
#create the table in database .tabe name car_data
dbWriteTable(coon,"car_data",mtcars)
#list all the table in database
dbListTables(coon)
#Quick access 
dbListFields(coon,"car_data")
red<-dbReadTable(coon,"car_data")

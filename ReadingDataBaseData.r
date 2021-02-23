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
#Execute Query
dbGetQuery(coon,"select *from car_data LIMIT 5")
dbGetQuery(coon,"select mpg,cyl disp from car_data")
dbGetQuery(coon,"select car_name,hp,cyl from car_data where cyl=8")
dbGetQuery(coon,"select car_name,hp,cyl from car_data where car_name LIKE 'M%'AND cyl in (6,8)")
dbGetQuery(coon,"select cyl,AVG(hp) as 'average_hp',AVG(mpg) as 'average_mpg' from car_data GROUP BY cyl ORDER BY average_hp")
avrgeHPcyl<-dbGetQuery(coon,"select cyl,AVG(hp) as 'average_hp',AVG(mpg) as 'average_mpg' from car_data GROUP BY cyl ORDER BY average_hp")
avrgeHPcyl
class(avrgeHPcyl)
#Parametrize Query
mpg<-18
cyl<-4
result<-dbGetQuery(coon,"select car_name,mpg ,cyl from car_data where mpg<=? AND cyl>=?",params=c(mpg,cyl))
result
#non tabular results
dbExecute(coon,"delete from car_data where car_name='Mazda RX4'")
dbGetQuery(coon,"select *from car_data")
dbExecute(coon,"insert into car_data values (45,8,71.0,95.0,55.2,45.0,11.0,94,15,26,73,'Mazda RX4')")
dbGetQuery(coon,"select *from car_data")
#Fetch the results
res<-dbSendQuery(coon,"select *from car_data where cyl=4")
dbFetch(res)
dbClearResult(res)
#disconnect from database
dbDisconnect(coon)
#......work on MYSQL.....
install.packages("RMySQL")
library('RMySQL')
ucscsb<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucscsb,"show databases;")
result
dbDisconnect(ucscsb)
#connecting to a database
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)
allTables
length(allTables)
allTables[1:5]
#for disconnect
dbDisconnect(hg19)

install.packages("mongolite")
install.packages("rjson")


library(mongolite) #Para conectar con mongo
library(jsonlite) #Para usa sintaxis json

#conexión con el cluster
#la url depende de tu cluster
con<-mongo(collection = "match", url= "mongodb+srv://<usuario>:<contraseña>@cluster0.eia5q.mongodb.net/match_games")


#pruebas de comandos de Mongo
#con$count('{}')
#con$find('{}')
#con$find('{"Date":"2017-12-09"}')


#Realiza una consulta utilizando la sintaxis de Mongodb, 
#en la base de datos para conocer el número de goles que metió el Real Madrid
#el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

#Como en la base proporsionada no hay juegos del 2015 se busco uno del 2017-12-09
con$find('{"$and":[{"Date":"2017-12-09"},{"$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}]}')

con$find('{}')

#respuesta a DF
respuesta<-con$find('{"$and":[{"Date":"2017-12-09"},{"$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}]}')
respuesta
class(respuesta)

#Impresión de respuesta
cat("El",respuesta[1,1],"Real Madrid jugó contra Sevilla y gano",respuesta[1,4],"-",respuesta[1,5])

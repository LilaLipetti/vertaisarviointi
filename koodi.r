
#jos data.table ei ole asennettu niin aja
#seuraava komento
#install.packages("data.table")
#

#ladataan tarvittavat kirjastot
library(data.table)
library(readr)


#luetaan nimet tiedostosta ja talletetaan taulukkoon
osallistujat <- read_csv("osallistujat.csv")
nimet <- as.data.table(osallistujat)

#samplätään uusi järjestys
jarjestys <- sample (1:nrow(nimet),nrow(nimet),replace=F)

#luodaan taulukko jossa jarjestys ja nimet ovat sarakkeina
arviointiT <- data.table(jarjestys,nimet)

#lajitellaan taulukko nousevaan jarjestykseen sarakkeen jarjestys perusteella
arviointiT <- arviointiT[order(jarjestys)]

#luodaan arvioija sarakkeet käyttäen hyväksi R:n data.table:n ominaisuuksia
arvioijat1 <- rbind( arviointiT[2:15,2] , arviointiT[,arviointiT[1:1,2]])
arvioijat2 <- rbind( arviointiT[3:15,2] , arviointiT[,arviointiT[1:2,2]])
arvioijat3 <- rbind( arviointiT[4:15,2] , arviointiT[,arviointiT[1:3,2]])

#ja lisätään ne sarakkeina taulukkoon
arviointiT <- arviointiT[, arvioija1:=arvioijat1]
arviointiT <- arviointiT[, arvioija2:=arvioijat2]
arviointiT <- arviointiT[, arvioija3:=arvioijat3]

#ja talletetaan lopuksi tiedostoon
write.csv(arviointiT,"vertais_arvioijat.csv")

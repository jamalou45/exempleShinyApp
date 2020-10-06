# Exemple GGPLOT2
library(ggplot2)

tempDataCovid <- read.csv(file = "https://www.data.gouv.fr/fr/datasets/r/63352e38-d353-4b54-bfd1-f1b3ee1cabd7", sep = ";")

# Paramètres
departement <- c(36, 37, 45)
sexe        <- 0
dateDebut   <- as.Date("2020-03-18")
dateFin     <- as.Date("2020-10-05")

# Execution
tempData                                       <- tempDataCovid[which(tempDataCovid$dep %in% departement & tempDataCovid$sexe == sexe),]
tempData[,"jour2"]                             <- as.Date(as.character(tempData$jour), format = "%Y-%m-%d", origin = "1970-01-01")
tempData[which(is.na(tempData$jour2)),"jour2"] <- as.Date(as.character(tempData$jour[which(is.na(tempData$jour2))]), format = "%d/%m/%Y", origin = "1970-01-01")
tempData$jour                                  <- tempData$jour2
tempData                                       <- tempData[,-which(colnames(tempData) == "jour2")]
tempData                                       <- tempData[which(tempData$jour >= dateDebut & tempData$jour <= dateFin),]

# Graphique
graph <- ggplot2::ggplot(data = tempData, aes(x = jour, y = hosp, color = dep)) +
  geom_line() +
  theme_minimal() +
  labs(x = "Date", y = "Nombre d'hospitalisation")

graph
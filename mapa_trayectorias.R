
# Autora: Neri

# ============================
# Cargar paquetes necesarios
# ============================
library(tidyverse)
library(readr)
library(dplyr)
library(googledrive)
library(ggplot2)
# Autenticarse (si es necesario)
drive_auth()
#https://drive.google.com/file/d/1-p5VRufz0KTYTA-k-GGtAtniS6Ie8d8b/view?usp=drive_link
# Descargar por ID
file_id1 <- "1-p5VRufz0KTYTA-k-GGtAtniS6Ie8d8b"
drive_download(as_id(file_id), 
               path = "superficie_por_grupo_funcional_1985_2023.csv",
               overwrite = TRUE)

#https://drive.google.com/file/d/1MPh3R8EN148NTgC1xy5usaYUwkko_BRf/view?usp=drive_link
file_id2 <- "1MPh3R8EN148NTgC1xy5usaYUwkko_BRf"
drive_download(as_id(file_id), 
               path = "transiciones_bosque_agro_y_ganancia.csv",
               overwrite = TRUE)
# Paso 2: Cargar los datos
datos_cobertura <- read_csv("superficie_por_grupo_funcional_1985_2023.csv")
datos_transiciones <- read_csv("transiciones_bosque_agro_y_ganancia.csv")
# Paso 3: Explorar los datos (vista inicial)
glimpse(datos_cobertura)
glimpse(datos_transiciones)
#Paso 4: Limpiar y organizar 
cobertura <- datos_cobertura %>%
  select(año, grupo, area_ha) %>%
  pivot_wider(names_from = grupo, values_from = area_ha) %>%
  rename(bosque_ha = formacion_boscosa,
         agro_ha = agropecuario)

# Ver resultado
head(cobertura)

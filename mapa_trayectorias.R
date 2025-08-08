# Script para visualizar el GeoTIFF de trayectorias
# Autora: Neri

# ============================
# Cargar paquetes necesarios
# ============================
library(sf)
library(sp)
library(tmap)
library(terra)
library(rcolorbrewer)
library(dplyr)
library(googledrive)
library(ggplot2)


# 1. Descargar imagen desde Drive
url <- "https://drive.google.com/file/d/1nrTrNEbUETik1p3zPDiTidGLeaaxsxwR/view?usp=drive_link"
download.file(url, "trayectorias_bosque_agro_bidireccional.tif", mode = "wb")

# Cargar y visualizar
raster_gee <- rast("trayectorias_bosque_agro_bidireccional.tif")
plot(raster_gee, main = "Imagen desde GEE")
# 3. Visualizar con ggplot2
ggplot() +
  layer_raster(raster_gee) +
  scale_fill_viridis_c() +
  labs(title = "Imagen desde GEE") +
  theme_minimal()


# Aquí va el código más adelante...

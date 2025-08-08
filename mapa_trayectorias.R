# Script para visualizar el GeoTIFF de trayectorias
# Autora: Neri

# ============================
# Cargar paquetes necesarios
# ============================
library(sf)
library(sp)
library(tmap)
library(terra)
library(RColorBrewer)
library(dplyr)
library(googledrive)
library(ggplot2)
# Autenticarse (si es necesario)
drive_auth()

# Descargar por ID
file_id <- "1nrTrNEbUETik1p3zPDiTidGLeaaxsxwR"
drive_download(as_id(file_id), 
               path = "trayectorias_bosque_agro_bidireccional.tif",
               overwrite = TRUE)

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

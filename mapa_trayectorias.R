# Script para visualizar el GeoTIFF de trayectorias
# Autora: Neri

# ============================
# Cargar paquetes necesarios
# ============================
library(googledrive)
library(raster)
library(ggplot2)

# 1. Descargar imagen desde Drive
url <- "https://drive.google.com/file/d/1nrTrNEbUETik1p3zPDiTidGLeaaxsxwR/view?usp=drive_link"
download.file(url, "trayectorias_bosque_agro_bidireccional.tif", mode = "wb")

# 2. Cargar con raster (compatible universal)
raster_gee <- raster("trayectorias_bosque_agro_bidireccional.tif")

# 3. Visualizar con ggplot2
ggplot() +
  layer_raster(raster_gee) +
  scale_fill_viridis_c() +
  labs(title = "Imagen desde GEE") +
  theme_minimal()


# Aquí va el código más adelante...

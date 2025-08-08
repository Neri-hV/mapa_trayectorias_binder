# Script para visualizar el GeoTIFF de trayectorias
# Autora: Neri

# ============================
# Cargar paquetes necesarios
# ============================
# Descargar y procesar el .tif desde Drive
library(terra)
library(googledrive)

# Enlace directo (usa el ID de tu archivo)
url <- "https://drive.google.com/file/d/1nrTrNEbUETik1p3zPDiTidGLeaaxsxwR/view?usp=sharing"
download.file(url, "trayectorias_bosque_agro_bidireccional.tif", mode = "wb")  # "wb" es clave para archivos binarios

# Cargar y visualizar
raster_gee <- rast("trayectorias_bosque_agro_bidireccional.tif")
plot(raster_gee, main = "Imagen desde GEE")


# Aquí va el código más adelante...

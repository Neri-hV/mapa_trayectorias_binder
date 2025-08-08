# Paquetes principales para GIS y visualización
install.packages(c("sf", "raster", "ggplot2", "dplyr", "stars", "googledrive"))

# Verificar instalación de sf (requiere librerías del sistema)
if (!require("sf")) {
  install.packages("sf", configure.args = "--with-gdal=/usr/bin/gdal-config")
}

# Paquetes principales para GIS y visualización
install.packages("sp")
install.packages("RColorBrewer")
install.packages("dplyr")
install.packages("googledrive")
install.packages("ggplot2")
# Reinstalar paquetes problemáticos
install.packages(c("sf", "terra", "tmap"), 
                 configure.args = c("--with-proj-lib=/usr/lib"))


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
#Paso 5: Gráfico exploratorio – Evolución de coberturas
ggplot(cobertura, aes(x = año)) +
  geom_line(aes(y = bosque_ha / 1e6, color = "Bosque"), size = 1.2) +
  geom_line(aes(y = agro_ha / 1e6, color = "Agropecuario"), size = 1.2) +
  labs(
    title = "Evolución de coberturas (1985–2023)",
    subtitle = "Superficie en millones de hectáreas",
    x = "Año",
    y = "Superficie (millones de ha)",
    color = "Cobertura"
  ) +
  scale_color_manual(values = c("Bosque" = "darkgreen", "Agropecuario" = "orange")) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 14, face = "bold")
  )
# Paso 6: Calcular cambios netos
cobertura <- cobertura %>%
  arrange(año) %>%
  mutate(
    delta_bosque = bosque_ha - lag(bosque_ha),
    delta_agro = agro_ha - lag(agro_ha)
  )

# Ver cambios recientes
tail(cobertura, 3)

#Paso 7: Explorar transiciones (bosque ↔ agro)
transiciones <- datos_transiciones %>%
  select(periodo, transicion, area_ha) %>%
  pivot_wider(names_from = transicion, values_from = area_ha) %>%
  rename(
    bosque_a_agro = bosque_a_agropecuario,
    agro_a_bosque = agropecuario_a_bosque
  ) %>%
  mutate(
    neto_perdida = bosque_a_agro - agro_a_bosque,
    tasa_retencion = agro_a_bosque / (bosque_a_agro + agro_a_bosque),
    tasa_conversion = bosque_a_agro / (bosque_a_agro + agro_a_bosque)
  )

# Ver
print(transiciones)
#Paso 8: Comparar pérdida total vs. pérdida por conversión
# Pérdida total de bosque (1985–2023)
perdida_total <- cobertura %>%
  filter(año == 1985 | año == 2023) %>%
  summarise(
    inicial = first(bosque_ha),
    final = last(bosque_ha),
    perdida_total = inicial - final
  )

# Pérdida neta por conversión directa
perdida_por_transicion <- transiciones %>%
  summarise(
    perdida_neta_transiciones = sum(bosque_a_agro - agro_a_bosque, na.rm = TRUE)
  )

# Mostrar
perdida_total
perdida_por_transicion
# Resumen
perdida_total <- pull(cobertura, bosque_ha)[1] - tail(cobertura$bosque_ha, 1)
perdida_transiciones <- sum(transiciones$neto, na.rm = TRUE)

cat("Pérdida total de bosque: ", format(perdida_total / 1e6, digits = 3), "millones de ha\n")
cat("Pérdida por conversión:  ", format(perdida_transiciones / 1e6, digits = 3), "millones de ha\n")

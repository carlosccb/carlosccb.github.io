library(tidyverse)

PATH <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(PATH)

df_data <- read_csv("iris_class_data.csv")#,
                    #col_types=col(target=col_factor()))
df_data <- df_data %>%
  mutate(target=replace(target, target==0, "healthy"))
df_data$target <- factor(df_data$target, levels=c("healthy", 1, 2))

plot_theme <- function() {
  theme(legend.position = "bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.title = element_blank(),#element_text(size=15),
        legend.text = element_text(size=14),
  )
}

# Plot with 3 classes
ggplot(df_data, aes(x=x, y=y, color=target, shape=target)) +
  geom_point(size=2.5) +
  theme_classic() + # TODO: El causante de que salgan dos leyendas es theme_classic ¿?
  scale_color_manual(values=c("#00ba38", "#619bff", "#f8766d")) +
  plot_theme() +
  labs(color="Degree",
       shape="Degree")
ggsave(file="ord_fig.png", device="png", path="../figs/", scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

# Plot with 2 classes
df_data_bi <- df_data %>%
  mutate(target=replace(target, target==2, 1))

df_data_bi$target <- recode_factor(df_data_bi$target, Healthy="healthy", "1" = "ill")

ggplot(df_data_bi, aes(x=x, y=y, color=target, shape=target)) +
  geom_point(size=2.5) +
  theme_classic() +
  scale_color_manual(values=c("#00ba38", "#f8766d")) +
  plot_theme() +
  labs(color="Degree",
       shape="Degree")
ggsave(file="nom_fig.png", device="png", path="../figs/", scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

# Create new data to plot both cases side by side

# Add task column
df_data_bi$Task <- "Nominal"
df_data$Task    <- "Ordinal"
# Combine data
df_data_both <- rbind(df_data_bi, df_data)
# Melt
df_data_both %>%
  pivot_longer(1:2)

# No me convence la leyenda cómo se queda
ggplot(df_data_both, aes(x=x, y=y, color=target, shape=target)) +
  geom_point(size=2.5) +
  theme_classic() +
  plot_theme() +
  scale_color_manual(values=c("#00ba38", "#619bff", "#f8766d", "#619bff")) +
  scale_shape_manual(values=c(16,17, 18 ,17)) +
  facet_grid(cols=vars(Task))
# ggsave(file="nom_vs_ord_fig.png", device="png", path="../figs/", scale=1.5, dpi=320)#, units="px")
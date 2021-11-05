library(tidyverse)

df_data <- read_csv("~/Downloads/iris_class_data.csv")#,
                    #col_types=col(target=col_factor()))
df_data$target <- as.factor(df_data$target)

plot_theme <- function() {
  theme(legend.position = "bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.title = element_text(size=15),
        legend.text = element_text(size=14),
  )
}

# Plot with 3 classes
# TODO: use one single legend with shape and color
ggplot(df_data, aes(x=x, y=y, color=target, shape=target)) +
  geom_point(size=2.5) +
  theme_classic() + # TODO: El causante de que salgan dos leyendas es theme_classic ¿?
  plot_theme() +
  labs(color="Degree")
ggsave(file="ord_fig.png", device="png", path="~/Downloads/", scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

# Plot with 2 classes
# TODO: use one single legend with shape and color
df_data %>%
  mutate(target=replace(target, target==2, 1)) %>%
  ggplot(aes(x=x, y=y, color=target, shape=target)) +
  geom_point(size=2.5) +
  theme_classic() +
  plot_theme() +
  labs(color="Degree")
ggsave(file="nom_fig.png", device="png", path="~/Downloads/", scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

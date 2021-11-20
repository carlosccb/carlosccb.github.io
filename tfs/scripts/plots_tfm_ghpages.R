library(tidyverse)
library(reshape2)

PLOTS_PATH <- "~/Documents/Codes/carlosccb.github.io/tfs/figs/"

df_tfm_res_table <- read_csv("Documents/Codes/carlosccb.github.io/_includes/table_res_tfm.csv")

df_tfm_res_table$Config <- factor(df_tfm_res_table$Config,
                                  levels=df_tfm_res_table$Config[order(df_tfm_res_table$QWK)])

gg_pub_fig_theme <- function() {
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_text(size=16),
        axis.text.y=element_text(size=12),
        #axis.title.x=element_text(size=16),
        legend.title=element_text(size=15),
        legend.text=element_text(size=14))
}

ggplot(df_tfm_res_table, aes(x=Config, y=QWK, fill=Config)) +
  geom_bar(stat="identity") +
  coord_cartesian(ylim=c(0.7,0.92)) +
  scale_y_continuous(expand = c(0, 0)) +
  geom_text(aes(label=QWK), vjust=-0.3, size=5) +
  gg_pub_fig_theme()
ggsave(file="TFM_comp_QWK.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

ggplot(df_tfm_res_table, aes(x=Config, y=Accuracy, fill=Config)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Accuracy), vjust=-0.3, size=5) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian(ylim=c(0.3,0.55)) +
  gg_pub_fig_theme()
ggsave(file="TFM_comp_Acc.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

ggplot(df_tfm_res_table, aes(x=Config, y=`Top-2`, fill=Config)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=`Top-2`), vjust=-0.3, size=5) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian(ylim=c(0.6,0.8)) +
  gg_pub_fig_theme()
ggsave(file="TFM_comp_Top-2.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

ggplot(df_tfm_res_table, aes(x=Config, y=`Top-3`, fill=Config)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=`Top-3`), vjust=-0.3, size=5) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian(ylim=c(0.7,0.92)) +
  gg_pub_fig_theme()
ggsave(file="TFM_comp_Top-3.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

# === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  ==  
# === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

df_tfm_res_table_melted <- df_tfm_res_table %>%
  reshape2::melt(id.vars="Config")

gg_pub_fig_theme_faceted <- function() {
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        # axis.title.x=element_blank(),
        # axis.title.y=element_text(size=16),
        axis.text.y=element_text(size=10),
        # #axis.title.x=element_text(size=16),
        legend.title=element_text(size=14),
        legend.text=element_text(size=13)
        )
}

ggplot(df_tfm_res_table_melted, aes(x=Config, y=value, fill=Config)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=value), vjust=-0.3) +
  facet_wrap(~variable, scales = "free") +
  scale_y_continuous(expand = expansion(add=c(0, 0.05))) +
  gg_pub_fig_theme_faceted()
ggsave(file="TFM_comp_Complete.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

library(ggsci)
library(wesanderson)

ggplot(df_tfm_res_table_melted, aes(x=Config, y=value, fill=Config)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=value), size=3, vjust=-0.3) +
  facet_grid(~variable, scales = "free") +
  theme_bw() +
  scale_y_continuous(expand = expansion(add=c(0, 0.05))) +
  gg_pub_fig_theme_faceted() +
  theme(legend.position="top",)
  # scale_fill_jco()
ggsave(file="TFM_comp_Complete_grid.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

ggplot(df_tfm_res_table_melted, aes(x=variable, y=value,  color=Config)) +
  geom_point(size=3.5) +
  geom_line(aes(group =Config), size=0.75) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size=15),
        axis.text.y=element_text(size=14),
        legend.title=element_text(size=15),
        legend.text=element_text(size=14))
ggsave(file="TFM_comp_Lines.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)


ggplot(df_tfm_res_table_melted, aes(x=variable, y=value,  color=Config)) +
  geom_line(aes(group =Config), size=1.75) +
  geom_point(size=5) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        legend.position="top",
        legend.title=element_text(size=25),
        legend.text=element_text(size=22),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),)
ggsave(file="TFM_comp_Lines_BIG.png", device="png", path=PLOTS_PATH, scale=1.5, dpi=320)#, units="px")#, width=1290, height=1080)

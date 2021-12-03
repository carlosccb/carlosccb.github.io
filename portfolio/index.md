---
layout: page #page_centered
permalink: "/portfolio"
title: Portfolio
rights: True
---

# Portfolio

Here are some projects that I have worked on. All of them have links for further reading.

-----------------

## Ordinal Clasification with Residual Networks
**[BSc thesis project, 2018]**. The goal was to recognize the age of a person from a picture of their face. For this, a ResNet model was trained on images of faces. This problem is an ordinal classification problem.

The most important achievements were an improvement in the state-of-the-art methodology: training time reduced by 50% by porting code from theano to tensorflow, improving the training process, optimizing multiple internal operations, changing weight initialization, among other changes.

In the figure, the reduction in time for various configurations is shown.

{:refdef: style="text-align: center;"}
![](/portfolio/figs/time_comparison_th-tf_BIG.png){:width="60%" :align="center"}
{: refdef}

The source code for this project is available on [Github](https://github.com/carlosccb/Ordinal-Clasification-with-Residual-Networks). This work was continued with the next project. Read on for more details.

-----------------


## Comparative Study of Different Loss Functions for Deep Neural Networks on Ordinal Classification Problems
**[Master thesis project, 2019]**. Continuation of _Ordinal Clasification with Residual Networks_. Used new and original loss functions for ordinal classification problems with Deep Neural Networks. By using ordinal costs in the loss function during training, the state-of-the-art classification results were improved.

In the figure, the results for each model configuration are shown for different metrics. One of the proposals, <span style="color: #d669cf">_binom_qmse_</span>, improves all other methods in all metrics.

{:refdef: style="text-align: center;"}
![](/portfolio/figs/TFM_comp_Lines_BIG.png){:width="80%" :align="center"}
{: refdef}

More information is available about this project on this same website, in the [MSc thesis section](/tfs/). A very brief [introduction to ordinal classification](/tfs/#ordinal-classification) is included. For a quick overview, read the [abstract](/tfs/#abstract) and then head to [experimental results](/tfs/#experimental-results) and [conclusions](/tfs/#conclusions) to get a general sense of the work and the results achieved.

-----------------


##  Analysis and Prediction of Dammed Water Level in a Hydropower Reservoir Using Machine Learning and Persistence-Based Techniques

**[Peer-reviewed publication, 2020]**. Prediction of damned water level in a reservoir which was used for electricity production and human water consumption. This is a regression problem.

The data was quite noisy and had many outliers that had to be removed to improve training and the resulting predictions. Many methods and techniques were used to predict the water level on a weekly basis, the main being Machine Learning regressors (SVR, MLP, ELM, Gaussian Process) using different data treatments and preprocessing techniques. 

Most importantly, a new approach was created by mixing existing and new methodologies which improved a standard machine learning setup. In the figure bellow, one of the new approaches is shown, combining predictions for different seasons.

For more information the full [publication is available (and open) online.]({{ site.author.publications.water_reservoir }})

{:refdef: style="text-align: center;"}
![](/portfolio/figs/Embalse_final_predictions.png){:width="80%" :align="center"}
{: refdef}

-----------------

## Machine Learning Regression and Classification Methods for Fog Events Prediction: A Performance-based Study

**[(Manuscript)]** _This work is currently in the manuscript stage_.

Here the problem at hand was trying to predict the visibility on a road that has to be closured many times a year due to events of very low visibility. A varied study was carried out to predict the visibility in the next 30 minutes.

The data was massively imbalanced and so it was crucial to treat and preprocess the data by resampling the classes. The problem was approached as both regression and classification (nominal and ordinal). Most of the classifiers and regressors used were ensemble methods (AdaBoost, GradientBoosting, RandomForest, etc).

<!-- No figures are included for now just in case. -->

<!-- Figures commented just in case -->
In the figures bellow: for the regression task, the predictions by some of the regression models are shown; for the classification task, the F1-scores on test are shown.

| Regression | Classification |
| :---: | :---: |
| ![](/portfolio/figs/Regression-CompleteComparison-thick_l_v4.png){:width="100%" :align="center"} | ![](/portfolio/figs/Best_overall-F1_v4.png){:width="100%" :align="center"} |


-----------------
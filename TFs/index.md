---
layout: page_centered #page
permalink: "/tfs"
title: MSc thesis
---

## MSc thesis

In this section I will show what I did for my MSc and my BSc thesis. As the first is an improvement over the later, it will all be shown as if it were one thing. The code for my BSc thesis is [available on GitHub](https://github.com/carlosccb/Ordinal-Clasification-with-Residual-Networks).

<!-- <br><br> -->

<!--
Right now ({{ 'now' | date: '%Y-%m-%d' }}) the web is pretty much under construction. I dedicate as much free time as I can but I can't get everything up here as soon as I'd like to. Sorry for the inconvenience.
{:refdef: style="text-align: center;"}
![Page under construction](/assets/img/under-construction-sign.jpg){:width="5%" :align="center"}
{: refdef}
 -->

__Table of contents__
<!-- * ToC
{:toc} -->

<ul id="markdown-toc">
  <li><a href="#comparative-study-of-different-loss-functions-for-deep-neural-networks-on-ordinal-classification-problems" id="markdown-toc-comparative-study-of-different-loss-functions-for-deep-neural-networks-on-ordinal-classification-problems">Comparative Study of Different Loss Functions for Deep Neural Networks on Ordinal Classification Problems</a>    <ul>
      <li><a href="#abstract" id="markdown-toc-abstract">Abstract</a></li>
      <li><a href="#ordinal-classification" id="markdown-toc-ordinal-classification">Ordinal Classification</a>        <ul>
          <li><a href="#unimodal-distributions" id="markdown-toc-unimodal-distributions">Unimodal distributions</a></li>
          <li><a href="#evaluation-metrics" id="markdown-toc-evaluation-metrics">Evaluation Metrics</a>            <ul>
              <li><a href="#accuracy" id="markdown-toc-accuracy">Accuracy:</a></li>
              <li><a href="#top-k-accuracy" id="markdown-toc-top-k-accuracy">Top-k Accuracy:</a></li>
              <li><a href="#quadratic-weighted-kappa" id="markdown-toc-quadratic-weighted-kappa">Quadratic Weighted Kappa:</a></li>
            </ul>
          </li>
        </ul>
      </li>
      <li><a href="#deep-learning-for-ordinal-classification" id="markdown-toc-deep-learning-for-ordinal-classification">Deep Learning for Ordinal Classification</a>
      	<ul>
          <li><a href="#ordinal-loss-functions" id="markdown-toc-ordinal-loss-functions">Ordinal Loss Functions</a></li>
        </ul>
      </li>
      <li><a href="#experimental-results" id="markdown-toc-experimental-results">Experimental Results</a></li>
      <li><a href="#conclusions" id="markdown-toc-conclusions">Conclusions</a></li>
      <li><a href="#the-end" id="markdown-toc-the-end">The End</a></li>
    </ul>
  </li>
</ul>


## Comparative Study of Different Loss Functions for Deep Neural Networks on Ordinal Classification Problems

### Abstract

This work was a new approach for ordinal classification problems using deep learning models, based on the use of ordinal loss functions and probability density functions, which took advantage of the ordinality information that the labels hold. The method on which this approach was based uses unimodal probability distributions (based on the work of [Beckham et al.](http://proceedings.mlr.press/v70/beckham17a.html)) to transform the output distribution given by a deep neural network. Given that the model does not use the distance of the errors in the training process to modify its weights and that the ordinality is only considered in the distribution layer, we improved this approach by adding ordinal functions.

With this approach, we present a comparative study of the results obtained when different ordinal loss functions are used in conjunction with unimodal probability distributions for the network output, when non-ordinal loss functions are used on a baseline model and when a model takes into account ordinality only with an unimodal probability function. For the comparison, an ordinal dataset is considered. This dataset, [Adience](https://talhassner.github.io/home/projects/Adience/Adience-data.html), contains images of faces, which are in the public domain, with a label indicating a range of ages.

For this study we selected two loss functions previously presented in the literature, QWK, Quadratic Weighted Kappa, and EMD, Earth Mover’s Distance, and a new proposal, an ordinal loss function based on the MSE, Mean Squared Error. From this proposed loss function, two alternatives are derived depending on the weighting of the costs, one with an absolute value weighting, named WMSE, Weighted MSE, and another one with a quadratic weighting, QWMSE, Quadratic Weighted MSE.

The experimentation presented has been made on equal terms for all the configurations tested, using the same partitions of the dataset, namely, training, validation and test, and setting the seed to the same value before each of the experiments. The obtained results show that the application of ordinal loss functions improves the base results obtained in other works using the same dataset and in the baseline models used on this study. We also conclude from the results that the quadratic ponderation in the cost of misclassification improves an absolute weighting.

### Ordinal Classification

Ordinal classification is a ML task which tackles a problem where there is an inherent order in the classes to predict. The goal is to leverage the information given by the ordering of the classes to improve the training and inference when new samples are presented. The main trait that sets it apart from nominal classification is that the misclassification error is not the same among any pair of classes, the error increases with the distance among classes.

The common characteristics to any ordinal classification problem are: 
* Discreet classes
* Natural order

Some examples of ordinal classification are:
* Predicting the severity of a disease
* Ranking or preference prediction
* Exam grades
* Credit score

In the following figure you can see the same problem treated as a nominal and ordinal classification problem. On the left we have two classes, <span style="color:blue">healthy</span>, or <span style="color:red">ill</span>. If we transform the problem adding ordinality, the we have: <span style="color:green">_healthy_</span>; and in the ill class we have: <span style="color:blue">common</span> or <span style="color:red">severe</span>.

<!-- =============================================================================================================== -->
<!-- Nominal vs Ordinal fig -->
{:refdef: style="text-align: center;"}
<!-- ![](https://drive.google.com/uc?export=view&id=1RGQl7g7ZeU8KOGkQMGZ5ISi5QjhdseUi){:width="40%" :align="center"} -->
![Nominal vs Ordinal figure](/tfs/figs/nominal_vs_ordinal_new_.png){:width="40%" :align="center"}
{:refdef}
<!-- =============================================================================================================== -->

__How to treat ordinal problems__

One way to tackle ordinal problems is to transform the problem into other simpler problems. As presented in [Ordinal Regression Methods: Survey and Experimental Study](https://ieeexplore.ieee.org/abstract/document/7161338), these are some common ways are:
* Naïve approaches
	* Regression
	* Nominal Classification
	* Cost-sensitive classification
* Binary decomposition
	* One vs All
	* One vs One
* Threshold models
	* Proportional Odds Models

The interested reader can find these approaches explained in more detail in the linked paper. As this is not the point of the post, it only merits mentioning what the common ways to treat the problem. In this work we use a different and mixed approach, the use of unimodal probability distributions and ordinal loss functions.

#### Unimodal distributions

So, what's an unimodal distribution?, you might wonder. It's a probability distribution that, as the name implies, only has one mode. Simply put it means that it has one single value that repeats the most often. In the figure bellow it's the distribution to the left. The other distributions have two and three values which are the most common respectively.

<!-- =============================================================================================================== -->
<!-- Different Prob Distributions -->
{:refdef: style="text-align: center;"}
<!-- ![](https://drive.google.com/uc?export=view&id=1Rd1PZFw0ZHXSDiqYGr8Gsviqqp2JLXRp){:width="30%" :align="center"} -->
![Different Prob Distributions](/tfs/figs/unimodal_vs_multimodal.png){:width="30%" :align="center"}
{:refdef}
<!-- =============================================================================================================== -->

As we want to approximate the logical reasoning of what a person would think when looking at a picture the best option is to force the output of the DNN to be a unimodal probability distribution. As you can see in figure bellow, the distance between classes is very important because nobody would mistake the picture of a baby with a grown man with a beard, right? It would make sense to mistake a baby with a toddler, or a grown man with a young adult or an older person, but not two ages that different. So when using unimodal probabilities distributions you're forcing the net to predict the most likely class and make the probability for each class descend as it gets further from the most likely. Using the figure above, if it were the output of a network predicting the age of young adult from a picture, it easy to see that the most correct distribution would be the first, the second would mean that the network thinks it's either a baby or a older person, which would have to be penalized during training as it doesn't make much sense.


The following probability distributions were used:
* Binomial
* Poisson
* Chi-squared
* Student's t

Only the first distribution, Binomial, improved the baseline consistently and was clearly better than the other distributions, so that was the one included in the final study.

#### Evaluation Metrics

##### Accuracy:

It's the most common and simplest way to measure the performance of a classifier when predicting new instances. It's as simple as the rate of correctly classified samples, namely:

_Accuracy = (Number of instances correctly predicted) / (Number of total instances)_.

It's easy to calculate, but can be deceitful when the data is imbalanced, which causes many problems.

##### Top-k Accuracy:

<!-- No me acuerdo del nombre del dataset con 1000 clases, [](), añadir si me acuerdo del nombre o lo encuentro -->
This is the same as the normal accuracy but if the correct class is among the first _k_ predicted classes, it's considered as a correct prediction. It's typically used in problems with a huge number of classes. For this metric to be usable with a classification model, the model has to output a probability for each class to order the predictions.

In this case it makes sense as an ordinal classification metric because we're also using unimodal distributions at the end of our DNN.

##### Quadratic Weighted Kappa:

It's a modified version of the Cohen's Kappa statistic with weighting. In this case we use a quadratic weighting system, which means that the weights increase as the quadratic of the distance among classes increases. It's the best metric to compare the performance on a ordinal dataset as it truly takes into account the magnitude of the error. For further reading [this post on Kaggle](https://www.kaggle.com/reighns/understanding-the-quadratic-weighted-kappa) explains it very well.


### Deep Learning for Ordinal Classification

As mentioned earlier the approach taken in this work was novel because it used two different methods to account for ordinality during training. First, a layer at the end of the ResNet was added that shaped the unimodal distribution during training. Secondly, because new loss functions were implemented during training to account for the distances in the errors. 

#### Ordinal Loss Functions

The point of training DNNs with a gradient descent algorithm is to modify the weights of the network during training to correct the errors made when predicting the class of new instances. To improve a DNN in a ordinal problem the best bet is to take into account the distance between the predicted class in training and the ground truth. This is done with a loss function that calculates the error across multiple instances (batch) and propagates the error backwards into the weights of the network to modify them according to the amount of error. It's here that we can best take into account the distance of classes and correct the network in direct relation to the distance of the error.

To achieve this we have to use functions that calculate the distance between probability distributions, as we want to turn the output distribution of the network into the ideal distribution, namely a probability of 1 for the real class and 0 for the rest. The most common loss function used, the cross entropy loss function, doesn't take into account the shape of the distribution meaning that different distributions could have the same loss value. 

The loss functions used were:
* Quadratic Weighted Kappa (QWK): proposed as a loss function in [this article](https://www.sciencedirect.com/science/article/abs/pii/S0167865517301666)
* Earth Mover's Distance (EMD): measure of the distance between two probability distributions, find more on [wikipedia](https://en.wikipedia.org/wiki/Earth_mover%27s_distance). Proposed as a loss function in this [article](https://arxiv.org/abs/1611.05916).
* MSE: this is a novel proposition from this work. Two versions were used:
	1. wMSE: uses linear weights to penalize the distance between classes
	2. qMSE: uses quadratic weights to penalize distance between classes

### Experimental Results

I'll spare you all the details from the experimental setup, the data partitions, data augmentation, the training parameters, the residual architecture, the convergence graphics and whatnot, and I'll go directly to the results. (Also, congratulations and thank you if you've made it this far, seriously!)


For the comparison of the performance of the different methods we used a baseline model, which was a ResNet without the ordinal modifications and that treats the problem as a nominal classification problem instead of an ordinal one, and five different combinations of ordinal models. So the configurations used are:
1. Baseline, loss: cross entropy
2. Binomial, loss: cross entropy
3. Binomial, loss: EMD
4. Binomial, loss: QWK
5. Binomial, loss: wMSE
6. Binomial, loss: qMSE

The results obtained for the comparison metrics are included in the next table. The rows correspond to the each of the elements in the previous list and the columns are the values for each evaluation metric.


{% include tfm_results_comparison.html %}

<!-- TODO: Complete -->
<!-- TODO; Hay que meter las imágenes en el repositorio que si no GDrive a veces (si se entra muchas veces, no carga) -->
<!-- TODO; Las imágenes de comparación de métricas se podrían hacer de nuevo en ggplot -->

The same data of the table put in a barplot is shown bellow. It can be seen that (logically) increasing the _k_ parameter in Top-k Accuracy makes the models achieve higher values of accuracy, but it doesn't seem to reflect the performance of the ordinal models with unimodal probability distributions in its output, so a intrinsic ordinal metric is required, like Quadratic Weighted Kappa. With this metric, there's a greater difference between the ordinal models and the (nominal) baseline. The best result is obtained by the model with the quadratic weighted MSE loss function followed by the one that used QWK as the loss function.

<!-- =============================================================================================================== -->
<!-- Imagen de la comparación completa en grid -->
{:refdef: style="text-align: center;"}
<!-- Google Drive fig -->
<!-- ![](https://drive.google.com/uc?export=view&id=1sYJN9n93wN8f6-JMjjPxr9LojTxbL_v2){:width="65%" :align="center"} -->
<!-- Local fig -->
![Complete metrics comparison in grid format](/tfs/figs/TFM_comp_Complete_grid.png){:width="65%" :align="center"}
<!-- Comparación en cuadrantes (2x2) -->
<!-- ![](https://drive.google.com/uc?export=view&id=1_22vCG8_Zbo1mS9VqI0R_Fko9vY_pVtI){:width="60%" :align="center"} -->
{:refdef}
<!-- =============================================================================================================== -->


In the following figure the difference between evaluating the training process with a non-ordinal and an ordinal metric can be seen. In the accuracy figure (left) the baseline model (trained with cross entropy loss) starts to score better values of Accuracy than the rest of the models early on, approximately in epoch 20. This same training, when evaluated with a ordinal metric, QWK, (central figure) paints a very different picture. The baseline model takes longer to converge than the rest of the models, and in the end appears to beat most of them, but in reality, if we watch the QWK validation plot (the one to the right) it turns out that in reality it's overtraining, as its values end as the worst in the validation partition.

| Train Accuracy  | Train QWK       | Validation QWK  |
| :-------------: | :-------------: | :-------------: |
| ![Comparison of training accuracy](/tfs/figs/comp_train_acc.png){:width="90%" :align="center"} | ![Comparison of training QWK](/tfs/figs/comp_train_qwk.png){:width="90%" :align="center"} | ![Comparison of validation QWK](/tfs/figs/comp_val_qwk.png){:width="90%" :align="center"} |


<!--
	| ![](https://drive.google.com/uc?export=view&id=1n2TVU87wFced83Pk3-9INlRQXYQ8E-6R){:width="80%" :align="center"} | ![](https://drive.google.com/uc?export=view&id=1SfMVoK8ClTBImjSfZnuYOgzE3WWpaKas){:width="80%" :align="center"} | ![](https://drive.google.com/uc?export=view&id=1qi3tM9hsjYLIkH6HqHfq_aD7XDERr0kt){:width="80%" :align="center"} |
-->

As shown in the figure bellow, the baseline model trained with cross entropy under performs on all metrics with respect to the other models that have some kind of ordinality. In the non-ordinal metrics this difference is not very big but it increases when comparing the results obtained with QWK. The second worse model is the model with the binomial output and without an ordinal loss function. From this we can reason that the models that worked the best were the ones with an unimodal probability distribution and an ordinal loss function.


{:refdef: style="text-align: center;"}
![Comparison of metrics](/tfs/figs/TFM_comp_Lines.png){:width="50%" :align="center"}
{:refdef}


### Conclusions 

With the results obtained and shown in the [last section](#experimental-results), it can be seen that when working with ordinal classification problems, the usage of models adapted to account for the ordinality in the data, both in it's output probability distribution and during the training process with ordinal loss functions, increases notably the performance of a baseline model that treats the problem without taking into consideration the ordinal nature. It can also be seen that using ordinal loss functions prevents overfitting during training, and the need to use the proper metrics to evaluate the problem. Using the proper evaluation metrics when using datasets with an ordinal nature is as important as using metrics to take into consideration underrepresented classes in imbalanced problems, where one may end up with an accuracy of 95% or higher while completely omitting imbalanced classes.

It is worth pointing out that this area of classification is often rarely used outside of academia, even when achieving noteworthy improvements. When treating ordinal problems as nominal classification, an important and intrinsic part of the information included in the data is being omitted, so correctly using all the available information is crucial to improve the predictions. If ordinal classification is often rarely used outside of academia, the usage with Deep Learning model is even rarer, and surely requires future work to improve on this area.

### The End

That's it. Once again, congratulations and thank you if you've made it this far! Seriously!
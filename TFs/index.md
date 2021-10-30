---
layout: page_centered #page
permalink: "/TFs"
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

## Comparative Study of Different Loss Functions for Deep Neural Networks on Ordinal Classification Problems

### Abstract

This work was a new approach for ordinal classification problems using deep learning models, based on the use of ordinal loss functions and probability density functions, which took advantage of the ordinality information that the labels hold. The method on which this approach was based uses unimodal probability distributions (based on the work of [Beckham et al.](http://proceedings.mlr.press/v70/beckham17a.html)) to transform the output distribution given by a deep neural network. Given that the model does not use the distance of the errors in the training process to modify its weights and that the ordinality is only considered in the distribution layer, we improved this approach by adding ordinal functions.

With this approach, we present a comparative study of the results obtained when different ordinal loss functions are used in conjunction with unimodal probability distributions for the network output, when non-ordinal loss functions are used on a baseline model and when a model takes into account ordinality only with an unimodal probability function. For the comparison, an ordinal dataset is considered. This dataset, [Adience](https://talhassner.github.io/home/projects/Adience/Adience-data.html) contains images of faces, which are in the public domain, with a label indicating a range of ages.

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

{:refdef: style="text-align: center;"}
![](https://drive.google.com/uc?export=view&id=1RGQl7g7ZeU8KOGkQMGZ5ISi5QjhdseUi){:width="40%" :align="center"}
{:refdef}

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

{:refdef: style="text-align: center;"}
![](https://drive.google.com/uc?export=view&id=1Rd1PZFw0ZHXSDiqYGr8Gsviqqp2JLXRp){:width="25%" :align="center"}
{:refdef}


As we want to approximate the logical reasoning of what a person would think when looking at a picture the best option is to force the output of the DNN to be a unimodal probability distribution. As you can see in figure bellow, the distance between classes is very important because nobody would mistake the picture of a baby with a grown man with a beard, right? It makes sens to mistake a baby with a toddler, or a grown man with a young adult or an older person, but not two ages that different. So when using unimodal probabilities distributions you're forcing the net to predict the most likely class and make the probability for each class descend as it gets further from the most likely. Using the figure above, if it were the output of a network predicting the age of young adult from a picture, it easy to see that the most correct distribution would be the first, the second would mean that the network thinks it's either a baby or a older person, which would have to be penalized during training as it doesn't make much sense.

<!-- TODO: Make distribution plot with predictions -->

The following probability distributions were used:
* Binomial
* Poisson
* Chi-squared
* Student's t

Only the first distribution improved the baseline consistently and was clearly better than the other distributions, so that was the one included in the final study.

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

For the comparison of the performance of the different methods we used a baseline model, which was a ResNet without the ordinal modifications and that "saw" the problem as a nominal classification instead of ordinal and five different combinations of ordinal models. So the configurations used are:
1. Baseline, loss: cross entropy
2. Binomial, loss: cross entropy
3. Binomial, loss: EMD
4. Binomial, loss: QWK
5. Binomial, loss: wMSE
6. Binomial, loss: qMSE

I'll spare you all the details from the experimental setup, the data partitions, data augmentation, the training parameters, the convergence graphics and whatnot, and I'll go directly to the results. (Congratulations and thank you if you've made it this far, seriously!)

The metrics comparison table:

{% include tfm_results_comparison.html %}

<!-- TODO: Complete -->

The rows correspond to the elements in the previous list and the columns are the evaluation metrics.

<!--
| Accuracy chart  | QWK chart |
| ------------- | ------------- |
| {:refdef: style="text-align: center;"} ![](https://drive.google.com/uc?export=view&id=1LZp11FwWgpxCvsgVr-vG5q0woxyutfHE){:width="25%" :align="center"} {:refdef}  | {:refdef: style="text-align: center;"}![](https://drive.google.com/uc?export=view&id=1fJec-a2qXgI70f07Dl1NDObTOOcJIsnZ){:width="25%" :align="center"}{:refdef}  |
-->

<!-- {:refdef: style="text-align: center;"} ![](https://drive.google.com/uc?export=view&id=1LZp11FwWgpxCvsgVr-vG5q0woxyutfHE){:width="25%" :align="center"} {:refdef}
{:refdef: style="text-align: center;"}![](https://drive.google.com/uc?export=view&id=1fJec-a2qXgI70f07Dl1NDObTOOcJIsnZ){:width="25%" :align="center"}{:refdef} -->

### Resultados 

<!-- (Esto son las conclusiones)

Con los resultados obtenidos en la sección anterior 5, se puede comprobar cómo el uso de modelos adaptados para problemas ordinales mejora en gran medida las predicciones obtenidas, incrementando notablemente el rendimiento alcanzado por un mismo clasificador sobre la misma tarea.

Como se ha demostrado en la sección de resultados 5, utilizando funciones de coste ordinales se previene el sobreaprendizaje del modelo durante el entrenamiento. Esto permite que para un mismo problema se obtengan valores muy superiores de acierto. También se ha hecho patente la necesidad del uso de métricas de evaluación ordinales, ya que las métricas comúnmente utilizadas en tareas de clasificación no ponderan correctamente los errores según la distancia de las clases, lo cual es muy importante.

El uso de métricas ordinales en problemas de esta naturaleza es similar en su importancia al uso de métricas distintas al Accuracy en problemas desbalanceados, donde si el ratio de desequilibrio es demasiado grande, el clasificador puede tener un ratio de acierto cercano al 100 % a pesar de ignorar totalmente la clase minoritaria, que puede ser la más relevante en el problema tratado. Esto sucede por ejemplo en problemas médicos, donde la clase positiva suele ser minoritaria, debido a que existen un mayor número de personas sanas que enfermas.

Es interesante hacer notar que esta faceta del aprendizaje automático no es muy conocida fuera del ámbito de la investigación, a pesar de aportar grandes ventajas a un gran número de problemas. Normalmente los problemas de clasificación ordinal suelen ser tratados como problemas de clasificación supervisada nominal, perdiendo potencialmente calidad en los resultados obtenidos. Es importante también mencionar que si este campo no suele ser muy utilizado fuera de la investigación, sus aplicaciones al aprendizaje profundo lo son menos aún, por lo que se considera que el estudio realizado en este trabajo es importante para mostrar, ya no solo las ventajas de utilizar métricas y funciones de coste ordinales, si no evaluar el rendimiento de varias de ellas mediante su comparación directa con el mismo modelo base y el mismo conjunto de datos. -->

### The End

That's it. Once again, congratulations and thank you if you've made it this far! Seriously!

<!-- README.md is generated from README.Rmd. Please edit that file -->

# transmed

<!-- badges: start -->
<!-- badges: end -->

The goal of transmed is to translate medical terms from English to
Chinese and vice versa.

## Installation

First you need to install the Python environment and transformers
library. To install the python environment, you can download and install
Anaconda from [here](https://www.anaconda.com/download/). Once you have
installed Anaconda, you can create the environment by running the
following commands in the Anaconda terminal:

``` bash
conda update conda
conda create -n transmed python==3.10.11
conda activate transmed
conda install numpy scipy scikit-learn ipython
conda install pytorch -c pytorch
conda install transformers sentencepiece sacremoses
```

The next step is to install transformer models into the Anaconda cache.
You can do this by running `ipython` in the Anaconda terminal:

``` python
from transformers import pipeline
trans_en_to_zh = pipeline("translation", model="Helsinki-NLP/opus-mt-en-zh")
trans_zh_to_en = pipeline("translation", model="Helsinki-NLP/opus-mt-zh-en")
```

The transformer will download models automatically from `HuggingFace`.
If no error occurs, you can try the free-text translation under the
`ipython` environment, or exit `ipython` by typing `exit()`.

``` python
trans_en_to_zh("This sentence will be translated into chinese.")
```

The next step is to install the R package `transmed`. You can use
`install.packages` to install the package from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("linkessence/transmed-r")
```

## Usage

The first step is to initialize the transformer in `R`, which will load
the python environment, and store the transformer object into the global
environment. You can do this by running the following command:

``` r
library(transmed)
transformer <- init_transformer("C:/Users/MyUserName/Anaconda3/envs/transmed")
```

The first argument is the path to the python environment, which is just
the path you have created when installing `Anaconda` and setting up the
`transmed` environment. The second and third arguments are optional. You
can use your customized (fine-tuned) transformer models by specifying
the path to the models.

Once the transformer is initialized, you can use the `med_translate_xxx`
function to translate medical terms.

After you have finished using the transformer, you can close the python
environment by just removing the transformer object from the global
environment:

``` r
rm(transformer)
```

## Examples

1.  To translate a single term:

``` r
library(transmed)
transformer <- init_transformer("C:/Users/MyUserName/Anaconda3/envs/transmed")

med_translate_str_en_to_zh("Enteritis", transformer)
med_translate_str_zh_to_en("肠炎", transformer)
```

2.  To translate a free text:

``` r
library(transmed)
transformer <- init_transformer("C:/Users/MyUserName/Anaconda3/envs/transmed")

med_translate_str_en_zh("Enteritis is an inflammation of your small intestine. It’s most often caused by eating or drinking things that are contaminated with bacteria or viruses.", transformer)
med_translate_str_zh_en("肠炎是小肠的炎症。它最常见的原因是吃或喝被细菌或病毒污染的东西。", transformer)
```

3.  To translate a vector of terms:

``` r
library(transmed)
transformer <- init_transformer("C:/Users/MyUserName/Anaconda3/envs/transmed")

med_translate_col_en_to_zh(c("Enteritis", "Gastritis"), transformer)
med_translate_col_zh_to_en(c("肠炎", "胃炎"), transformer)
```

4.  To translate a data frame with multiple columns:

``` r
library(transmed)
transformer <- init_transformer("C:/Users/MyUserName/Anaconda3/envs/transmed")

df <- data.frame(
  Name = c("John", "Mary"),
  Age = c(29, 32),
  Gender = c("Male", "Female"),
  Disease = c("Enteritis", "Gastritis")
)

med_translate_df_en_to_zh(df, transformer, col_names = c("Gender", "Disease"))
```

## Use your own dictionary

You can use customized dictionary to translate medical terms. First,
define a dictionary in a csv file, and then use the `read.csv` function
to read the dictionary into memory. Before using the dictionary, you
must use the `make_hash_from_dictionary` function to convert the
dictionary into a hash table.

For example, your dictionary looks like

    English,Chinese
    Enteritis,肠炎
    Gastritis,胃炎

You can read the dictionary into memory by running

``` r
dict <- read.csv("my_dictionary.csv", stringsAsFactors = FALSE)
```

Then you can convert the dictionary into a hash table by running

``` r
hash_en_zh <- make_hash_from_dictionary(dict, from_column="English", to_column="Chinese")
```

Finally, you can use the hash table as the `dict_hash` parameter, in any
of the `med_translate_xxx` functions. For example, you can run

``` r
med_translate_str_en_to_zh("Enteritis", transformer, dict_hash = hash_en_zh)
```

## Prohibits free-text translation

Under some conditions, you may want to prohibit free-text translation,
and use the dictionary only. In this case, just set the `transformer`
parameter to `NULL`. For example, you can run

``` r
med_translate_col_en_to_zh(c("Enteritis", "Gastritis"), transformer = NULL)
```

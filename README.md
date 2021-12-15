# DeepECG

## Basic Overview
Atrial Fibrillation detection with a deep probabilistic model. Backend for [Diagnose Report ](https://github.com/truongnmt/diagnose-report) app. Use [PhysioNet dataset](https://physionet.org/challenge/2017/) for model training and testing.

## Dependencies
The following dependencies are required.
* Python
* [Tensorflow](https://www.tensorflow.org/install/)
* [Keras](https://keras.io/)
* [Cardio Framework](https://github.com/analysiscenter/cardio)


## Demo
Demo from the frontend: [Diagnose Report ](https://github.com/truongnmt/diagnose-report) app.

|Sign Up|Dashboard|Report detail| Create report|
|-|-|-|-|
|![](https://github.com/truongnmt/diagnose-report/blob/master/screenshots/signup.png)|<img src="https://github.com/truongnmt/diagnose-report/blob/master/screenshots/dashboard.png" width="850" />|![](https://github.com/truongnmt/diagnose-report/blob/master/screenshots/report_detail.png)|![](https://github.com/truongnmt/diagnose-report/blob/master/screenshots/create_report.png)|


## Usage
I have already ran training for you. You can use the saved model in `dirichlet_model` folder to predict right away.
But make sure to change the path in `direchlet_model/checkpoint` according to your path.

If you want to train again by yourself, run this following notebook file: [dirichlet_model_training.ipynb](https://github.com/truongnmt/DeepECG/blob/master/dirichlet_model_training.ipynb), download the [dataset](https://physionet.org/challenge/2017/) and start training. Notice that on 1000 epochs, the training will take some time. Mine took about 8-9 hours on Tesla K80.

For the project I'm working on, I create some shell file and python files to convert and predict stuffs.

* To predict whether an image is AF (Atrial Fibrillation) or not:
```shell
predict <image file path>
```
It will return something like this
```js
[{'target_pred': {'A': 0.021675685, 'NO': 0.9783243},
  'uncertainty': 0.0073926448822021484}]
```
Which `A` is – Atrial fibrillation
`N` – Normal rhythm, `O` – Other rhythm, so `NO` is no problem.

See more in [test.ipynb](https://github.com/truongnmt/DeepECG/blob/master/test.ipynb) for more test case and example.

* To generate image from csv:
```shell
gnuplot -e "fileIn='csv/04015.csv'; fileOut='uploads/04015.png'" csv2img.gnuplot
```

* To convert single file to csv and image:
```shell
./raw2img <filename without extension>
```

* To convert image to csv:
```shell
python img2csv.py '<full path to file>'
```

* To convert MAT to csv:
```shell
python mat2csv.py "raw/A00001.mat"
```

* To convert csv to signal, with Gain equal 1000, Frequency 300Hz. Notice that you can specify `-f` mean from which line (remove if from beginning of file) and also `-t` mean to which line.
```shell
wrsamp -i raw/A00001.csv -o raw/A00001-converted -G 1000 -F 300 -z
```

* To convert signal back to MAT:
```shell
wfdb2mat -r raw/A00001-converted
```

## License
This project is licensed under the terms of the **MIT** license.

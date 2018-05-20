# DeepECG

## Basic Overview
Atrial Fibrillation detection with a deep probabilistic model. Backend for [Diagnose Report ](https://github.com/truongnmt/diagnose-report) app. Use [PhysioNet dataset](https://physionet.org/challenge/2017/) for model training and testing.

## Dependencies
The following dependencies are required.
* Python
* [Tensorflow](https://www.tensorflow.org/install/)
* [Keras](https://keras.io/)
* [Cardio Framework](https://github.com/analysiscenter/cardio)

## Usage [WIP]
I have already ran training for you. You can use the saved model in `dirichlet_model` folder to predict right away.
But make sure to change the path in `direchlet_model/checkpoint` according to your path.

If you want to train again by yourself, run this following notebook file: `dirichlet_model_training.ipynb`, download the dataset and start training. Notice that on 1000 epochs, the training will take some time. Mine took about 8-9 hours on Tesla K80.

For the project I'm working on, I create some shell file and python files to convert and predict stuffs.

* To predict whether an image is AF (Atrial Fibrillation) or not:
```
predict <image file path>
```
See more in `test.ipynb` for more test case and example.

* To generate image from csv:
```
./gnuplot -e "fileIn='<input csv>'; fileOut='<output image>'" csv2img.gnuplot
Eg: gnuplot -e "fileIn='csv/04015.csv'; fileOut='uploads/04015.png'" csv2img.gnuplot
```

* To convert single file to csv and image:
```
./raw2img <filename without extension>
Eg: ./raw2img 04015
```

* To convert image to csv:
```
python img2csv.py '<full path to file>'
Eg: python img2csv.py '/Users/truongnm/Downloads/data/uploads/04015.png'
```

* To convert MAT to csv:
```
python mat2csv.py "raw/A00001.mat"
```

* To convert csv to signal, with Gain equal 1000, Frequency 300Hz. Notice that you can specify `-f` mean from which line (remove if from beginning of file) and also `-t` mean to which line.
```
wrsamp -i raw/A00001.csv -o raw/A00001-converted -G 1000 -F 300 -z
```

* To convert signal back to MAT:
```
wfdb2mat -r raw/A00001-converted
```

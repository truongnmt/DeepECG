# DeepECG

## Usage [WIP]
* To generat image from csv:
```
./gnuplot -e "fileIn='<input csv>'; fileOut='<output image>'" csv2img.gnuplot
Eg: gnuplot -e "fileIn='csv/04015.csv'; fileOut='uploads/04015.png'" csv2img.gnuplot
```
* To convert all raw data to csv and image (include above step already):
```
./raws2img
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
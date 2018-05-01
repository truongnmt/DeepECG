import scipy.io as sio
import os
import sys

# PATH= "/Users/truongnm/coding/cnn/ecg/ecg-process/raw/A00004.mat"
PATH = sys.argv[1]
output_folder = os.path.dirname(PATH)
output_filename = os.path.splitext(os.path.basename(PATH))[0]
output_path = output_folder + "/" + output_filename + ".csv"
mat_struct = sio.loadmat(PATH)

with open(output_path, 'w+') as f:
    for index, value in enumerate(mat_struct['val'][0]):        
        f.write('{0},{1}\n'.format(index*0.004, value))

import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import sys
stderr = sys.stderr
sys.stderr = open(os.devnull, 'w')
from functools import partial
import numpy as np
import tensorflow as tf
import cardio.dataset as ds
from cardio import EcgDataset
from cardio.dataset import B, V, F
from cardio.models.dirichlet_model import DirichletModel, concatenate_ecg_batch
sys.stderr = stderr

# signal_path = "/Users/truongnm/coding/cnn/DeepECG/raw/A00001.mat"
signal_path = sys.argv[1]
MODEL_PATH = "/Users/truongnm/coding/cnn/DeepECG/dirichlet_model"
BATCH_SIZE = 100

gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=0.5, allow_growth=True)
model_config = {
    "session": {"config": tf.ConfigProto(gpu_options=gpu_options)},
    "build": False,
    "load": {"path": MODEL_PATH},
}

template_predict_ppl = (
    ds.Pipeline()
      .init_model("static", DirichletModel, name="dirichlet", config=model_config)
      .init_variable("predictions_list", init_on_each_run=list)
      .load(fmt="wfdb", components=["signal", "meta"])
      .flip_signals()
      .split_signals(2048, 2048)
      .predict_model("dirichlet", make_data=partial(concatenate_ecg_batch, return_targets=False),
                     fetches="predictions", save_to=V("predictions_list"), mode="e")
      .run(batch_size=BATCH_SIZE, shuffle=False, drop_last=False, n_epochs=1, lazy=True)
)

predict_eds = EcgDataset(path=signal_path, no_ext=True, sort=True)
predict_ppl = (predict_eds >> template_predict_ppl).run()
print(predict_ppl.get_variable("predictions_list"))

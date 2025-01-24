tar xzvf v1.5.1.tar.gz
cd BirdNET-Analyzer-1.5.1
python3 -m venv venv-birdnet
source venv-birdnet/bin/activate
python -m pip install -U pip
pip3 install tflite-runtime
pip3 install librosa resampy
pip3 install keras_tuner
pip3 install tensorflow==2.15.0
python3 -m birdnet_analyzer.analyze

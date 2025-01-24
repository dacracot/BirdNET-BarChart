# BirdNET-Analyzer Configuration

Setup of the BirdNET-Analyzer dependency.

---

### Components:

* Expand the release file obtained from the BirdNET-Analyzer GitHub.
	* `tar xzvf v1.5.1.tar.gz`
* Enter the resultant directory.
	* `cd BirdNET-Analyzer-1.5.1`
* Create the Python virtual environment.
	* `python3 -m venv venv-birdnet`
* Activate the Python virtual environment.
	* `source venv-birdnet/bin/activate`
* Add the analyzer dependencies.
	* `python -m pip install -U pip`
	* `pip3 install tflite-runtime`
	* `pip3 install librosa resampy`
	* `pip3 install keras_tuner`
	* `pip3 install tensorflow==2.15.0`
* Run the analyzer test.
	* `python3 -m birdnet_analyzer.analyze`

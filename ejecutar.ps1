mkdir test_outputs
python -m venv .venv 
./.venv/Scripts/activate
python -m pip install --upgrade pip
python -m pip install --upgrade wheel
pip install numpy==1.16.4
pip install -r requirements.txt
python test_unet.py
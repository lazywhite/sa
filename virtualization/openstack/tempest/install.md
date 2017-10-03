git clone https://github.com/openstack/tempest.git
git checkout -f 15.0.0
virtualenv tempestenv
source tempestenv/bin/activate
pip install -r requirements.txt
python setup.py install

mkdir /etc/tempest/
tempest init ws01
tempest run --parallel --workspace ws01


tempest verify-config

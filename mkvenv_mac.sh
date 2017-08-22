#! /bin/sh

python -m venv --without-pip env
source env/bin/activate
curl https://bootstrap.pypa.io/get-pip.py | python
deactivate
source env/bin/activate
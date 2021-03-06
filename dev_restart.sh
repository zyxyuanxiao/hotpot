#!/bin/sh
rm -f ./settings.ini
ln -s ./settings.ini.dev ./settings.ini
find . -name '*.py' | xargs yapf -i
ps -ef | grep hotpot | grep -v grep | awk '{print $2}' | xargs kill -9
python3 hotpot.py
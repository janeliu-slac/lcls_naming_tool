#!/bin/bash


export ACCESS_LOG_FORMAT='%(h)s %(l)s %({REMOTE_USER}i)s %(t)s "%(r)s" "%(q)s" %(s)s %(b)s %(D)s'

source /reg/g/pcds/engineering_tools/latest-released/scripts/pcds_conda

cd lcls_naming_tool/web

rm lcls_naming_tool.py

rm -rf taxons

cp ../lcls_naming_tool.py .

cp -r ../taxons .

exec gunicorn start:app -b 0.0.0.0:8319 \
       --log-level=${LOG_LEVEL} --capture-output --enable-stdio-inheritance \
       --timeout 300 --graceful-timeout 1 \
       --access-logfile - --access-logformat "${ACCESS_LOG_FORMAT}"
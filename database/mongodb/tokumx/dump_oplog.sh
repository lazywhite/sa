#!/bin/bash
export LANG=en_US.utf-8
export TS=`date +%F-%H-%M`
echo 'Dumping oplog of mongodb', $TS
python oplog.py |grep -v 'keepOplogAlive' > ${oplog-$TS}

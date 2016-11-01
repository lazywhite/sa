#!/bin/bash
echo 'nice to meet you'
exec "$@"

echo $PGUSER
echo $PGPASSWORD

/bin/bash

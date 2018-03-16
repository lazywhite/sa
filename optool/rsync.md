## Example
```
rsync -avrz --delete --exclude=.git -e 'ssh -p 2133' build/  root@192.168.21.33:/mnt/nexttao_www/build/

目录后面必须加/
    rsync -avrz --delete root@192.168.1.12:/root/vue-ssr/  vue-ssr/
```


## Parameter
```
    --delete
    -a: archive
    -v: verbose
    -z: compress
    -q: quiet
    --exclude=PATTERN: exclude files matching PATTERN
```

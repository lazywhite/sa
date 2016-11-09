## Example
```
rsync -avrz --delete --exclude=.git -e 'ssh -p 2133' build/  root@192.168.21.33:/mnt/nexttao_www/build/

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

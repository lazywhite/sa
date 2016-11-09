## install android-sdk on linux

## update sdk 
```
## update android sdk
android list sdk -a |grep 23.0.3 # output sdk with index
android update sdk -a -u -t <index>

## install com.android.support package
android list sdk -a|grep -i 'support'
android update sdk -a -u -t 163
```


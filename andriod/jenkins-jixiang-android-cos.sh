#!/bin/bash

cd Jixiang

base=`pwd`
if [[ $GIT_BRANCH != 'origin/master' ]]; then
    VERSION=${GIT_BRANCH//origin\//}
fi
full_version=${VERSION}-b$BUILD_NUMBER-${GIT_COMMIT:0:7}
version_file="$base/app/src/main/res/values/strings.xml"


VERSION=`grep 'version_name' $version_file|awk -F'[<>]' '{print $3}'`

rm -rf $base/app/build

git checkout -f .

ANDROID_HOME=/mnt/DATA/android-sdk-linux /mnt/DATA/gradle-2.14.1/bin/gradle build

apk="$base/app/build/outputs/apk/app-release.apk"


[ ! -e "$apk" ] && exit 1


#oss_bucket_name="nt-customer"
#oss_host="http://${oss_bucket_name}.oss-cn-hangzhou.aliyuncs.com"
#oss_dir="dist"

cos_appid=100
cos_bucket=jixia

apkname=f`date +%Y%m%d%H%M`

apkname_full=${apkname}.apk

#apk_url="$oss_host/$oss_dir/${apkname}.apk"

apk_url="http://${cos_bucket}-${cos_appid}.file.myqcloud.com/android/${apkname_full}"

#aliyuncli oss MultiUpload $apk oss://$oss_bucket_name/$oss_dir/${apkname}.apk

python<<EOF
from qcloud_cos import CosClient
from qcloud_cos import UploadSliceFileRequest

secret_id = u'AKIDDer4jhUHZeJLETi0P7j3IeF'
secret_key = u'mGpUDHTzP0hguQWHC5gQrvGc'

cos_client = CosClient(int(${cos_appid}), secret_id, secret_key)

request = UploadSliceFileRequest(unicode('${cos_bucket}'), unicode('/android/%s' % '${apkname_full}'), unicode('${apk}'))
request.set_insert_only(0)
ret = cos_client.upload_slice_file(request)
EOF

size=`ls -alh $apk|awk '{print $5}'`


python<<EOF
import xmlrpclib
import base64
import socket
import sys
import json


vals = {}
vals['app_id'] = ${DIST_APP_ID}
vals['app_version_name'] = "${apkname}.apk"
vals['app_version'] = "${VERSION}"
vals['app_dwn_path'] = "${apk_url}"
vals['size'] = "$size"


sock_common = xmlrpclib.ServerProxy('http://dist.nexttao.com:8069/xmlrpc/common', verbose=1, allow_none=1)
oe_uid = sock_common.login('app_dist', "iposbuilder", "5FB2C70A-2631-4584-AC31-")


if oe_uid != False:
    print("login ok")
    sock = xmlrpclib.ServerProxy('http://dist.nexttao.com:8069/xmlrpc/object', verbose=1, allow_none=1)

    result = sock.execute('app_dist', oe_uid, "5FB2C70A-2631-4584-AC31-", 'nt.app.distribute.version', 'register', vals)

EOF

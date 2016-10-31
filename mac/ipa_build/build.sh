#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

base_dir=$(cd `dirname $0` && pwd)
git_repo='git@gitlab.test.com:project/jixiang-ios.git'
obj_id=47

upload_type='oss'
#upload_type='sys' # or oss
scp_host='dist.test.com'
scp_path='/var/www/app_dist_files'
sys_url_prefix="http://dist.test.com/app_dist_files"

oss_bucket_name="nt-customer"
oss_host="http://${oss_bucket_name}.oss-cn-hangzhou.aliyuncs.com"
oss_dir="dist"


function clean {
    rm -f "$base_dir/building"
}
if [ ! -e "$base_dir/building" ]; then
    echo "Checking git repository head"
    if [ -d  "$base_dir/build" ]; then
        rm -rf $base_dir/build
    fi
    mkdir $base_dir/build
    echo "date +'%s'" > "$base_dir/building"
    set -e
    trap clean EXIT
    if [ ! -e "$base_dir/count" ]; then
        echo 0 > "$base_dir/count"
    fi

    if [ ! -e "$base_dir/src/.git" ]; then
        git clone $git_repo $base_dir/src
            cd $base_dir/src
        else
            cd $base_dir/src
    fi
    git fetch --prune
    git fetch --all
    git config  user.name "iPOS-Builder"
    git config  user.email "iPOS-Builder@test.com.cn"
    git ls-remote |grep 'refs/heads' | while read branch
    do
        echo "Checking branch $branch"
        branch=(`echo $branch|tr '' '\n'`)
        head=${branch[0]}
        branch=${branch[1]}
        branch=${branch//refs\/heads\//}
        version=${branch//v/}
        ipaname=f`date +%Y%m%d%H%M`
        if [[ $branch == 'log' ]]; then
            continue
        fi

        cd "$base_dir/src"
        ## commented because untracked files are needed to compile this project, use gitignore instead
#        git clean -fdx
        git reset --hard HEAD
        git checkout $branch
        git pull origin $branch
        head=`git rev-parse HEAD`
        #version=`python -c "import plistlib; print plistlib.readPlist('$base_dir/src/Flower/Flower-Sirius-Info.plist')['CFBundleShortVersionString']"`

        if [[ ! -e "$base_dir/head/$branch" || $head != `cat "$base_dir/head/$branch"` ]]; then
            echo $head > "$base_dir/head/$branch"
            echo "==============================================================="
            count=`cat "$base_dir/count"`
            full_version=$version-b$count-${head:0:7}
            echo "$(($count+1))" > "$base_dir/count"
            echo "Start building iPOS $full_version `date`"
            python <<EOF
import plistlib
pl=plistlib.readPlist('$base_dir/src/JiXiang/Info.plist')
pl['CFBundleVersion']='$full_version'
pl['CFBundleShortVersionString']='$version'
plistlib.writePlist(pl,'$base_dir/src/Jixiang/Info.plist')
EOF
            security -v unlock-keychain -p Initial0 /Users/developer/Library/Keychains/login.keychain
            ipa="$base_dir/build/$branch.ipa"
            xcodebuild clean  archive -scheme JiXiang -configuration Release -workspace "$base_dir/src/JiXiang.xcworkspace" -archivePath "$base_dir/build/jixiang.xcarchive"
            xcodebuild -exportArchive  -exportFormat IPA -archivePath "$base_dir/build/jixiang.xcarchive" -exportPath "$ipa" -exportProvisioningProfile "catering"

            if [[ $? == 0 ]]; then
                if [ $upload_type == 'sys' ];then
                    # generate file path
                    ipa_url="${sys_url_prefix}/${ipaname}.ipa"
                    plist_url="${sys_url_prefix}/${ipaname}.plist"
                    # generate plist file
                    plist=$(python $base_dir/gen_plist.py $ipa $ipa_url)
                    # upload by upload_type
                    scp $ipa  openerp@$scp_host:$scp_path/$ipaname.ipa
                    scp $plist  openerp@$scp_host:$scp_path/$ipaname.plist
                fi
                if [ $upload_type == 'oss' ];then
                    ipa_url="$oss_host/$oss_dir/$ipaname.ipa"
                    plist_url="$oss_host/$oss_dir/$ipaname.plist"
                    # generate plist file
                    plist=$(python $base_dir/gen_plist.py $ipa $ipa_url)
                    # upload by upload_type
                    aliyuncli oss MultiUpload $ipa oss://$oss_bucket_name/$oss_dir/$ipaname.ipa
                    aliyuncli oss MultiUpload $plist oss://$oss_bucket_name/$oss_dir/$ipaname.plist

                fi
                size=`ls -alh $ipa|awk '{print $5}'`
                python $base_dir/register.py "$obj_id" "$ipaname.ipa" "$full_version" "$ipa_url" "$plist_url" "$size" 
                        
            else
                echo "No new commits"
           fi
        fi
    done
fi

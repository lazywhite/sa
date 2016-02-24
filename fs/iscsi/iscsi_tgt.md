tgtadm --lld iscsi --mode target --op new --tid=1 --targetname iqn.2009-02.com.example:for.all

tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 --backing-store gv0@gs215:disk1 --bstype glfs


tgtadm --lld iscsi --mode target --op bind --tid 1 -I ALL

tgtadm --lld iscsi --mode target --op show


iscsiadm -m discovery -t sendtargets -p gs215

iscsiadm -m node --login

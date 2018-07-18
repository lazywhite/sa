
ceph osd crush add-bucket root-sata root
ceph osd crush add-bucket root-ssd root
ceph osd crush add-bucket ceph-1-sata host
ceph osd crush add-bucket ceph-2-sata host
ceph osd crush add-bucket ceph-1-ssd host
ceph osd crush add-bucket ceph-2-ssd host

ceph osd crush move ceph-1-sata root=root-sata
ceph osd crush move ceph-2-sata root=root-sata
ceph osd crush move ceph-1-ssd root=root-ssd
ceph osd crush move ceph-2-ssd root=root-ssd

ceph osd crush add osd.0 2.7 host=ceph-1-sata
ceph osd crush add osd.1 2.7 host=ceph-1-sata
ceph osd crush add osd.2 2.7 host=ceph-1-sata
#
ceph osd crush add osd.3 2.7 host=ceph-2-sata
ceph osd crush add osd.4 2.7 host=ceph-2-sata
ceph osd crush add osd.5 2.7 host=ceph-2-sata
#
ceph osd crush add osd.6 2.7 host=ceph-1-ssd
ceph osd crush add osd.7 2.7 host=ceph-1-ssd
ceph osd crush add osd.8 2.7 host=ceph-1-ssd
#
ceph osd crush add osd.9 2.7 host=ceph-2-ssd
ceph osd crush add osd.10 2.7 host=ceph-2-ssd
ceph osd crush add osd.11 2.7 host=ceph-2-ssd
#
#
ceph osd pool set rbd pg_num 256
ceph osd pool set rbd pgp_num 256



ceph osd getcrushmap -o crushmap
crushtool -d crushmap -o crush.txt
edit crush.txt
crushtool -c crush.txt -o crush.bin
ceph osd setcrushmap -i crush.bin

ceph osd pool create sata-pool 256 replicated_sata
ceph osd pool create ssd-pool 256 replicated_ssd

ceph osd pool list
ceph df




ceph osd pool set sata-pool pg_num 512
ceph osd pool set ssd-pool pg_num 512
ceph osd pool set sata-pool pgp_num 512
ceph osd pool set ssd-pool pgp_num 512


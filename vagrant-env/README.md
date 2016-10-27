# Shrinking

1. Boot gues machine in recovery mode (by pressing `Shift` key during the boot)
2. Drop to the root shell and run `zerofree /dev/mapper/vagrant...`
3. Power off guest machine
4. On host machine download vmware-vdiskmanager from https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1023856 (see Attachments section)
5. Run `vmware-vdiskmanager -k ubuntu1604-desktop-disk1.vmdk` on host machine

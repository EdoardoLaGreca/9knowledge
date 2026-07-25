Booting with GRUB 2
===================

This setup is especially useful when multi-booting 9front with another operating system that makes use of GRUB 2 as bootloader; typically, but not limited to, Linux.

## UEFI

Although writing multiple ESPs in the same disk is a bad idea, I believe that one ESP per disk is fine. I like to be able to boot each of my disks indipendently of one another, and I also install one operating system per disk anyway so...

That being said, this section assumes that you installed 9front on a separate disk of the same PC, a different disk from the one GRUB is installed into. In fact, GRUB is going to "chain-load" another bootloader, which is going to be the 9front's bootloader.

In order to find out how your 9front ESP is called in terms of UEFI disk/partition names, you'll need to boot (or reboot) your PC up until the GRUB menu appears. Then, you'll need to type `c` to enter command-line mode and type `ls` to get a list of disks and partitions that GRUB can see. They are typically named like `(hd1,gpt1)`, `(hd1,gpt2)`, `(hd2,gpt1)`, etc. In other words, it's a pair of disk enumeration and partition enumeration. With `ls` followed by a space and a disk-partition pair, try each partition of each disk until you find one that says "Filesystem is fat". ESPs are formatted with FAT, so it's a candidate. Then, run the same command with a `/` at the end. If the contents are `plan9.ini`, `9pc64`, `efi/`, etc. then you found it; otherwise, keep searching.

With the disk-partition pair you found, copy the following `menuentry` into `/etc/grub.d/40_custom` with the `root=(...)` part adjusted with your pair.

```
menuentry "9front" {
	set root=(hd1,gpt2)
	chainloader /efi/boot/bootx64.efi
}
```

After writing the entry, remember to save the file and update the GRUB bootloader with the new configuration. Some operating systems have a script for that, others require to run `grub-mkconfig` by hand.

## BIOS

(to do)


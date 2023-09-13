# 00: Plan 9 installation

## Running via QEMU

If you're not using QEMU, skip this section.

First, you need to create a QEMU disk image for Plan 9 (using the [`qemu-img`](https://www.qemu.org/docs/master/tools/qemu-img.html) utility) and download the Plan 9 4th release ISO image (see [links.md](links.md)). It is recommended a **30 GB** qcow2 disk image and the original Plan 9 4th edition, instead of a fork (e.g. 9front), for an original experience.

Then, run s/virt9.sh and specify both the QEMU disk image path and the ISO path. virt9.sh is a script that contains a working QEMU command to boot Plan 9. The arguments are specified as follows.

```
./s/virt9.sh <disk> <iso>
```

Once the installation will finish, to avoid specifying the ISO path every time you want to virtualize Plan 9, you can omit that argument.

```
./s/virt9.sh <disk>
```

## Installation process

The installation process is very straightforward and carefully explained.

Before loading the user interface, some prompts may appear.

- Whether to use [DMA](https://en.wikipedia.org/wiki/Direct_memory_access) for the drive. The default option is good for almost all cases, so just press Enter.
- Which mouse port to use. The default option (should be "ps2") is good. Press Enter again.
- The screen size to use. If you're not uncomfortable with relatively small screens, use the default option again.
- The monitor type. The default one is good.

Then, the user interface loads and prompts appear for the following tasks. Every task begins with `Task to do [<taskname>]:`, in which you just need to press Enter, unless you'd like to perform another task.

1. `configfs` -- this allows to choose which filesystem to use. Unless you need an archival dump server, go with the default option (`fossil`).
2. `partdisk` -- choose here which disk to install Plan 9 into. The choices should be something like `sd` + an uppercase letter + a number.
	1. It may ask whether to install [MBR](https://en.wikipedia.org/wiki/Master_boot_record) on the disk you chose. If you're using QEMU on an empty disk, type `y`. Otherwise, carefully choose.
	2. It asks to partition the Plan 9 disk. The suggested partition(s) are good for almost all cases, so type `w` and then `q`.
3. `prepdisk` -- because you partitioned your disk just now, it will automatically detect the Plan 9 partition. Use the default option.
	1. It asks to perform a Plan 9 partition subdivision. The default options are good. Just type `w` and then `q`.
4. `fmtfossil` -- use this task to initialize disks.
	1. It asks for the partition to format. The default option is good.
5. `mountfs` -- mount file system partitions. The fossil partition should be automatically detected and presented as default option, which is good.
6. `configdist` -- choose the distribution archive. "local", which should be the default option, is good.
7. `mountdist` -- mount the distribution. It asks to choose the storage media that contains the distribution. Since there is no suggested option, you should choose the option that has `(iso9660 cdrom)` option aside.
	1. Now you should browse to the archive. To do so, press Enter at the prompt to start browsing. Then, check that you're in the right directory using `lc`, and then use `exit`. You're able to recognize the right directory because it has files like "LICENSE" and "NOTICE".
8. `copydist` -- this is perhaps the most time-consuming task. You just have to wait for Plan 9 to copy all the distribution files.
9. `bootsetup` -- configure hard disk for booting. A prompt asks for the boot method. If you're on QEMU, type `plan9`. Otherwise, choose one that is suitable to your case.
	1. Another prompt appears, asking whether to install Plan 9's MBR. Unless you have another MBR, type `y`.
10. `finish` -- congrats, you completed the install!

Now you can boot Plan 9 again, without the installation medium, and follow [01_boot.md](01_boot.md).

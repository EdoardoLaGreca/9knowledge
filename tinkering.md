# tinkering

If you'd like to try Plan 9 using QEMU, use the script in s/virt9.sh to run it.

The scripts requires two arguments: the path to the **ISO file** (see [links.md](links.md) for the download link) and the path to the **QEMU disk image**. It is recommended a **30 GB** qcow2 image for disk and the original Plan 4 4th edition, instead of a fork (e.g. 9front), for an original experience.

```
./s/virt9.sh <iso> <disk>
```

If you run into errors, [this](http://fqa.9front.org/fqa3.html#3.3.1) can help.

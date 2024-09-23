Booting with GRUB 2
===================

## UEFI

In order to boot 9front using GRUB 2, use the following GRUB menu entry. In Unix-like operating systems (Linux, *BSD, etc.), write the menu entry into `/etc/grub.d/40_custom`.

```
menuentry "9front" {
	set root=(hd1,gpt2)
	chainloader /efi/boot/bootx64.efi
}
```

You may need to adjust the line `set root=(...)` with the disk and partition where your 9front installation resides. In order to find the correct disk and partition, it is advised the use of the EFI shell. For this purpose, `map`, `cd`, and `ls` are useful EFI shell commands.

After writing the entry, remember to save the file and run

```
grub-mkconfig -o /boot/grub/grub.cfg
```

## BIOS

(to do)


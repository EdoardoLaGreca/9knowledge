# Useful things to do, right after a 9front installation

Disclaimer: do not follow all sections just because the title says that they are "useful". Only follow the ones that are useful to you.

## Disabling the boot prompts

```
9fs 9fat
acme /n/9fat/plan9.ini
```

and add

```
nobootprompt=<value>
user=<user>
```

where `<value>` is the root file system of choice and `<user>` is the default login user.

## Changing the monitor size

```
9fs 9fat
acme /n/9fat/plan9.ini
```

and add or change

```
vgasize=<width>x<height>x<depth>
```

where `<width>`, `<height>`, and `<depth>` are the desired width, height, and depth.

# Useful things to do, right after a 9front installation

Disclaimer: do not follow all sections just because the title says that they are "useful". Only follow those which are useful to you.

## Disable the boot prompts

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

More info: [plan9.ini(8)](https://man.9front.org/8/plan9.ini).

## Change the monitor size

```
9fs 9fat
acme /n/9fat/plan9.ini
```

and add or change

```
vgasize=<width>x<height>x<depth>
```

where `<width>`, `<height>`, and `<depth>` are the desired width, height, and depth.

Not all widths, heights, and depths are allowed. You can find all valid VESA modes [here](https://en.wikipedia.org/wiki/VESA_BIOS_Extensions#Modes_defined_by_VESA), along with other common modes.

More info: [plan9.ini(8)](https://man.9front.org/8/plan9.ini), [vga(8)](https://man.9front.org/8/vga).

## Enable automatic DHCP client

Warning: automatic DHCP may have been set up during installation. If that is the case, you probably don't need to read this section.

```
acme /lib/ndb/local
```

and add `ether=<addr>` in a new tuple, where `<addr>` is the address (MAC address) of the ethernet interface for which you'd like to set up DHCP. You can get a list of available MAC addresses by using the following command.

```
cat /net/ether*/stats | grep 'addr:'
```

If that command does not show any output, I have bad news for you.

More info: [ether(3)](https://man.9front.org/3/ether), [ndb(6)](https://man.9front.org/6/ndb), [dhcpd(8)](https://man.9front.org/8/dhcpd)..

## Change the machine's hostname

```
acme /lib/ndb/local
```

and add `sys=<name>` (`<name>` is the hostname) in the network in which you'd like that hostname to be used.

More info: [ndb(6)](https://man.9front.org/6/ndb).

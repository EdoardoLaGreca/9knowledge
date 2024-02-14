# Useful day-to-day stuff

Use `man [section] title` to search for the manual page `title` in `section`, or `lookman key` to search for all manual pages that contain `key`.

Pressing Control-D in Rio generates an EOT character, which is like a newline, but it is not delivered to the running program. An EOT serves as EOF indication. Control-D in Plan 9 has a similar effect to Control-C in Unix.

## Text processing and stream I/O

- [`echo`](https://man.9front.org/1/echo) - write text to stdout
- [`cat`](https://man.9front.org/1/cat) - concatenate files
- [`grep`](https://man.9front.org/1/grep) - pattern search
- [`sed`](https://man.9front.org/1/sed) - edit stream
- [`awk`](https://man.9front.org/1/awk) - scan and process
- [`wc`](https://man.9front.org/1/wc) - count words

## System administration

- [`ip/ping`](http://man.9front.org/8/ping) - ping a device
- [`ps`](https://man.9front.org/1/ps) - print information about running processes
- [`fshalt`](https://man.9front.org/8/fshalt) - halt file system and shut down the machine
- [`reboot`](https://man.9front.org/8/reboot) - reboot the system

## File system

- [`file`](https://man.9front.org/1/file) - classify file
- [`bind`](https://man.9front.org/1/bind) - bind a source file to a destination file, so that the destination is an alias for the source
- [`mount`](https://man.9front.org/1/bind) - mount (i.e. "attach") the contents of a directory tree to another directory tree
- [`unmount`](https://man.9front.org/1/bind) - undo bind or mount
- [`9fs`](https://man.9front.org/4/srv) - dial a machine and mount its file system
- [`ns`](https://man.9front.org/1/ns) - represent the name spaces of a process
- [`rcpu`](https://man.9front.org/1/rcpu) - connect to a CPU server and start a shell on it
- [`rimport`](https://man.9front.org/1/rcpu) - connect to a CPU server and mount a directory tree from it
- [`rexport`](https://man.9front.org/1/rcpu) - connect to a CPU server and mount a local directory tree into it

### Name spaces

[What are name spaces?](namespaces.md)

Common mount points for file servers, unless manually specified, are in:

- `/n` (for file trees imported from remote systems)
- `/srv` (just an empty unwritable directory that acts as place holder for mounted services)
- `/mnt` (for applications)

Plan 9 provides a default name space to processes as soon as they spawn.

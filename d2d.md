# Useful day-to-day stuff

Use `man [section] title` to search for the manual page `title` in `section`, or `lookman key` to search for all manual pages that contain `key`.

Pressing Control-D in Rio generates an EOT character, which is like a newline, but it is not delivered to the running program. An EOT serves as EOF indication. Control-D in Plan 9 has a similar effect to Control-C in Unix.

## Text processing and pipeline I/O

- [`echo`](https://man.9front.org/1/echo) - write a line to stdout
- [`cat`](https://man.9front.org/1/cat) - concatenate files
- [`grep`](https://man.9front.org/1/grep) - pattern search
- [`sed`](https://man.9front.org/1/sed) - edit stream
- [`awk`](https://man.9front.org/1/awk) - scan and process
- [`wc`](https://man.9front.org/1/wc) - count words

## File system and system administration

- [`file`](https://man.9front.org/1/file) - classify file
- [`bind` and `mount`](https://man.9front.org/1/bind) - modify the name space of the current process
- [`9fs`](https://man.9front.org/4/srv) - dial a machine and mount its file system
- [`ns`](https://man.9front.org/1/ns) - represent the name spaces of a process
- [`ps`](https://man.9front.org/1/ps) - print information about running processes
- [`fshalt`](https://man.9front.org/8/fshalt) - halt file system and shut down the machine

### Name spaces

[What are name spaces?](namespaces.md)

Common mount points for file trees, unless manually specified:

- `/n`
- `/srv`
- `/mnt`

Plan 9 provides a default name space to processes as soon as they spawn.

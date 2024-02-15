# Glossary of Plan 9

**9front**: A fork of Plan 9 from Bell Labs that includes patches, bug fixes, device drivers, and other enhancements. From the user's perspective, 9front differs very little from Plan 9. 9front was kindly brought to existence by the [9front contributors](https://fqa.9front.org/fqa1.html#1.6).

**9P**: Plan 9's file system protocol. It allows sharing directory trees between Plan 9 machines. Ports to Unix systems exist as well.

**Auth server**: A computer running Plan 9, whose purpose is to manage authentication for an entire Plan 9 network. It runs on a disk-less machine and usually performs no other functions to reduce the danger of potential security breaches. However, to enable remote access, the auth server is usually also configured as a CPU server.

**Bind**: An operation that modifies the current name space. By binding two files or two directories, the contents of the second one mirror those of the first. Binding a file with a directory (or vice versa) is not possible, as it would be inconsistent.

**CPU server**: A computer running Plan 9, whose purpose is to serve its resources for remote computation. Programs in CPU servers run in isolation.

**Directory**: An abstract container of files and directories. Files and directories in the same parent directory are usually related to their parent directory.

**Directory tree**: The file system that originates from a certain directory called *root directory*. The root directory of a directory tree may not (and, usually, does not) coincide with the whole file system's root directory.

**Disk-less**: Adjective used to describe a computer that lacks a persistent memory, such as a disk.

**Drawterm**: A program that users of operating systems other than Plan 9 can use to establish graphical connections with Plan 9 CPU servers.

**File**: A textual interface. It allows programs to communicate with each other, with operations as simple as writing and reading disk data. Not all files present in the file system are stored in the disk.

**File server**: A computer running Plan 9, whose purpose is to serve (i.e. make available) its files to other computers on the same network. A traditional Plan 9 grid only contains one file server. In 9front, the same computer that functions as a file server, is also a CPU server. Some programs, including Plan 9's kernel, take the form of file servers, because they serve files in the current name space.

**File system**: A set of files and directories organized as a tree, in which directories are internal nodes and files are leaf nodes. Often shortened as "fs".

**Glenda**: A little bunny and the Plan 9 mascot. The user *glenda* has special privileges in a Plan 9 machine, but not as much as the *root* user on Unix systems.

**Grid**: A network of Plan 9 computers. A grid may include: auth servers, CPU servers, file servers, and terminals.

**IL**: A connection-based transport-layer protocol made for carrying 9P packets. Similar to TCP, but simpler. Since the Fourth edition of Plan 9, IL is *deprecated* in favor of TCP/IP, because it doesn't handle long-distance connections well.

**Mount**: Bind directory trees from services in /srv. [TODO: explain better]

**Mouse chording**: The act of clicking or holding down multiple mouse buttons to perform an action.

**Name space**: A unique view of the file system. In Plan 9, name spaces are private to each process and may be modified using `bind`, `mount`, and `unmount`.

**Plan 9 from Bell Labs**: A distributed operating system developed at Bell Labs. It focuses on simplicity, distributed computing, and the idea that *everything is a file*. The foundations of the system are built on two ideas: a per-process name space and a simple message-oriented file system protocol. Also called "Plan 9", for short.

**Plan9port**: A collection of some Plan 9 utilities and libraries ported to Unix by [9fans](https://github.com/9fans).

**Terminal**: A computer used by an end user. In a Plan 9 grid, terminals are often disk-less and are made of cheap hardware.

**Unix philosophy**: The philosophy that shaped Unix. It was also partly adopted on Plan 9, with few differences. For more, see [links.md](links.md).

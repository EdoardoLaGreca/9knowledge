# Glossary of Plan 9

**9front**: A fork of Plan 9 from Bell Labs that includes many patches and bug fixes. Kindly brought you by the [9front contributors](https://fqa.9front.org/fqa1.html#1.6).

**9P**: The Plan 9's file system protocol. It allows to share file systems between Plan 9 machines. Ports to Unix exist too.

**Auth server**: A computer running Plan 9, whose purpose is to manage authentication for an entire Plan 9 network. It runs on a disk-less machine and performs no other functions, to reduce the danger of a potential security breach. However, to enable remote access, the auth server is usually also configured as a cpu server.

**Bind**: Remap a QID (file/directory ID) through a command of the same name. In other words, it modifies the current name space so that one file or directory appears joined with another file or directory under the path of one of the two.

**CPU server**: A computer running Plan 9, whose purpose is to serve its resources for remote computation. Programs in CPU servers run in isolation.

**Directory**: An abstract container of files and directories. Files and directories in the same parent directory are usually related to their parent directory.

**Disk-less**: Adjective used to describe a computer that lacks a persistent memory.

**Drawterm**: A program that users of non-Plan 9 systems can use to establish graphical connections with Plan 9 CPU servers.

**File**: A textual interface. It allows programs to communicate with each other, with operations as simple as writing and reading disk data. Not all files present in the file system are stored in the disk.

**File server**: A computer running Plan 9, whose purpose is to serve (i.e. make available) its files to other computers on the same network. A traditional Plan 9 grid only contains one file server. In 9front, the same computer that functions as a file server, is also a CPU server. Some programs--including Plan 9's kernel--take the form of file servers, since they serve a file tree in the current name space which other programs can use to communicate.

**File system**: A set of files and directories organized as a tree, in which directories are internal nodes and files are leaf nodes. Often shortened as "fs".

**Glenda**: A little bunny, as well as the Plan 9 mascot. The user *glenda* has special privileges in a Plan 9, similar to the *root* user in Unix.

**Grid**: A network of Plan 9 computers. A grid may include: auth servers, CPU servers, file servers, and terminals.

**IL**: A connection-based transport-layer protocol used to carry 9P. Similar to TCP, but simpler. Since the Fourth edition of Plan 9, IL is *deprecated* in favor of TCP/IP, because it doesn't handle long-distance connections well.

**Kernel**: The *core* of an operating system. It manages the essential aspects of an operating system and provides interfaces to communicate with the hardware it is running on.

**Mount**: An operation that, through a command of the same name, connects the current name space to a 9P server. The `unmount` commands does the opposite.

**Mouse chording**: The act of clicking or holding down multiple mouse buttons to perform an action.

**Name space**: A unique view of the file system. A name space may be modified using `bind`, `mount`, and `unmount`.

**Plan 9 from Bell Labs**: A distributed operating system developed at Bell Labs that focuses on simplicity and complies with the Unix philosophy. The foundations of the system are built on two ideas: a per-process name space and a simple message-oriented file system protocol. Also called "Plan 9", for short.

**Plan9port**: A collection of some Plan 9 utilities and libraries ported to Unix.

**Terminal**: A computer used by an end user. In a Plan 9 grid, terminals are often disk-less.

**Unix philosophy**: (see [links.md](links.md))

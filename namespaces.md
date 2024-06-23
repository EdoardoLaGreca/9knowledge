# Name spaces

## Informal definition of "name space"

When I first read about Plan 9 I noticed the recurring term "name space", which I never heard before in the context of an operating system. My first days of learning Plan 9 were accompanied by a doubt that followed me for several months.

> What is a name space, exactly?

But I couldn't find any useful resource that could clarify that concept.

Some time have passed, I learned more about Plan 9 and now I understand what name spaces are (at least on the surface, I didn't look at their implementation yet). If I could go back to my younger self to tell him what name spaces are, what would I say?

> Think of name spaces as *perspectives*.

A name space can be thought as a certain perspective of the file system. You see, the disk stores some persistent files, and those are just data in a memory device. Every file in the disk has a certain path, which informs about the location of the file. Unless you change the path of a file, or create or delete a file somewhere, the paths are fixed. However, thanks to the `bind` and `mount` operations, one can temporarily change the file system and model it at will. You can tell the operating system to mirror the changes to a file or directory to another file or directory (`bind`), or to add an remote file system to the local one and make it look local (`mount`).

One may read somewhere that name spaces are "unique to each process" or that they are "per-process name spaces". Both expressions refer to the same fact, which is that each name space is held by only one process, regardless of whether two name spaces are identical. A name space is not just a certain perspective, but an instance of that perspective, associated to a process.

## Bind and mount

Bind and mount are arguably the most important operations (and commands) to change a name space.

### Bind: make aliases and unions

When a **bind** is performed, either two files or two directories, let's name them A and B, are "overlapped". Bind operations alter B, not A.

In case of files, B is replaced by A, which means that B is still visible but every read and write operation done on B is actually performed on A and the path to B is actually an alias for the path to A.

In case of directories, there are three possible outcomes, depending on the options provided to the bind operation.

- Without any argument, just like for files, B becomes an alias for A, so all files and sub-directories that were visible in B temporarily disappear and are replaced with those in A.
- With the `-b` flag (or `MBEFORE` in the library function), files and sub-directories in A are made available through B, together with the already existing contents of B. In case of conflicts (that is, if A contains one or more files or sub-directories which have the same name as other ones in B), then A prevails over B and the conflicting entities in B become aliases for those found in A.
- With the `-a` flag (or `MAFTER` in the library function), the bind operation works the same as with '-b' with one difference: in case of conflicts, then B prevails over A.

A mnemonic way to memorize which between A and B has precedence over the other is this: with `-b` (before) A comes *before* B, so it has higher precedence, with '-a` (after) A comes *after* B, so it has lower precedence.

Note that, if you recursively list all files and directories (using `du -a`) after a bind with `-b` or `-a`, some may appear duplicated. That happens when there is a conflict. However, if you try to display the content of a duplicated file or directory, you will notice that only one can only be accessed, precisely that which comes from the directory with higher precedence.

### Mount: add filesystems

# Name spaces

## Informal definition of "name space"

When I first read about Plan 9 I noticed the recurring term "name space", which I never heard before in the context of an operating system. My first days of learning Plan 9 were accompanied by a doubt that followed me for several months.

> What is a name space, exactly?

But I couldn't find any useful resource that could clarify this concept.

Some time have passed, I learned more about Plan 9 and now I understand what name spaces are (at least on the surface, I didn't look at their implementation yet). If I could go back to my younger self to tell him what name spaces are, what would I say?

> Think of name spaces as *perspectives*.

A name space can be thought as a certain perspective of the file system. You see, the disk stores some persistent files, and those are just data in a memory device. Every file in the disk has a certain path, which informs about the location of the file. Unless you change the path of a file, or create or delete a new file somewhere, the paths are fixed. However, thanks to the `bind` and `mount` operations, one can temporarily change the file system and model it at will. The changes to a file or directory can be mirrored to another file or directory (`bind`), or an external file system can be added to the file system as if it was local (`mount`).

Now that this is clear, one may read somewhere that name spaces are "unique to each process" or that they are "per-process name spaces". Both expressions refer to the same fact, which is that each name space is held by only one process, regardless of whether two name spaces are identical. A name space is not just a certain perspective, but an instance of that perspective, associated to a process.

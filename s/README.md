Scripts
=======

Each script begins with a description of itself, which informs the user about what the script does and how it is supposed to be used. It is sometimes followed by a few variables that can be customised at will, along with their own informative comments.


POSIX shell scripts
-------------------

Scripts ending in `.sh` are supposed to run on Unix-like operating systems and are therefore written in a mostly POSIX-compliant fashion.

As for their syntax, they are guaranteed to be strictly limited to the shell language syntax defined by the POSIX standard. This means that they can be run in any shell that is also POSIX-compliant. However, as for the utilities invoked in such scripts and their options, although likewise POSIX-compliant for the most part, there might be exceptions due to some scripts targeting one or few specific operating systems. In other words, POSIX-compliance regarding the invocation of utilities is only discarded for scripts that are not supposed to run everywhere anyway.

Targeting specific operating systems may be unavoidable: some better suite the script's purpose, some provide necessary system-specific utilities for which POSIX doesn't define a standard, some implement the same functionality but expose different interfaces.


Plan 9 Rc scripts
-----------------

On the other hand, scripts whose name ends in `.rc` are supposed to be run on 9front.


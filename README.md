# Conatiner Helper

Tool for making containers easier to use instinctively on the command line.

This is typically to support my usage of containers as an experimentation utility.

All containers end up having `$PWD` mounted into `/var/hostdata` , and the default working
directory set at `/var/hostdata`

# Help

see [src/HELP.md](src/HELP.md)

## Language choice

Because of the shell nature of this, it would be best written in bash/bbash

However, as an experiment in using argument parsing and subprocess launching/awaiting, could be written using a new language. Currently I am thinking of either Zig or Nim.

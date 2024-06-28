# Conatiner Helper

Tool for making containers easier to use instinctively on the command line.

This is typically to support my usage of containers as an experimentation utility.

All containers end up having `$PWD` mounted into `/var/hostdata` , and the default working
directory set at `/var/hostdata`

## Commands

A basic summary of all minimal requirements commands

```sh
# Start a new container, and on exit, cement it as a new image
contain image <name> from <image>

# Create a new image using a Dockerfile, implicitly using the Dockerfile's parent as context (overridable)
contain build <name> from <Dockefile-path> [-t <context-dir>]

# Start a new named container that persists
contain use <name> from <image>

# Start a new container ; on exit, prompt for deletion
contain use <image>

# Open an existing container
contain reuse <name>

# Start a container from an image
# On exit, be prompted to replace the old iteration
#   with the new container's state
contain reimage <image>

# List containers and images
contain containers
contaim images
```

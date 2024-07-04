# `contain`

Helper for managing local experimentation containers.

Run a container from any image with `run`. When you exit the container you will be prompted to commit it as a new image. This is optional,
but helps retain improvements from during your session.

The `build` command allows you to specify a particular Dockerfile to use, and optionally any alternative contexts to use.

Every container is run with the current working directory bind-mounted to `/hostdata` . This is not retained in images that are cut from the containers.

## Commands

Very simple. Create an image by using the `build` command, or using the `run` command and comitting upon exiting the container.

```sh
# Create a new image using a Dockerfile, implicitly using the Dockerfile's parent as context (overridable)
contain build <name> <Dockerfile-path>

# Start a new container
contain run <image>
# On exit, be prompted to remove the container or commit it
```


## Overview

- This is an open source fork of
  [Kubeflow notebook servers][Kubeflow notebook servers link]
  with new features, latest packages and others.

- The following images are considered base images, which you can extend:
  - [base](./base): The common base for all other images
  - [jupyter](./jupyter): The base __JupyterLab__
    image with built-in [__Elyra__][Elyra link] supports

## How do I extend these images?

- Any changes made by users __after spawning__ a Kubeflow notebook
  will only last the lifetime of the pod, unless they are
  installed into a PVC-backed directory

### Adding pip packages

- Extend one of the base images and install any
  `pip` packages your Kubeflow notebook
  users are likely to need.

### Adding apt-get packages

- Extend one of the base images and install any
  `apt-get` packages your Kubeflow notebook
  users are likely to need.
  - __WARNING__: ensure you swap to `root` in the
    Dockerfile before running `apt-get`,
    and swap back to `jovyan` after.

### Adding container startup scripts

- Some use-cases might require custom scripts to run
  during the startup of the Notebook Server container,
  or advanced users might want to add additional
  services that run inside the container.
- To make this easy, we use the
  [s6-overlay][s6 overlay link].
- The [s6-overlay][s6 overlay link]
  differs from other init systems, such as the popular
  [tini](https://github.com/krallin/tini).
- While `tini` was created to handle a single process running
  in a container as PID 1, the `s6-overlay` is built to manage
  multiple processes and allows the creator of the image to
  determine which process failures should silently restart,
  and which should cause the container to exit.

### Custom startup scripts:

- Scripts that need to run during the startup of the
  container can be placed in `/etc/cont-init.d/`,
  and are executed in ascending alphanumeric order.
- This script uses the
  [with-contenv][s6 container environment link]
  helper so that environment variables (passed to container)
  are available in the script.
- The purpose of this script is to snapshot any `KUBERNETES_*`
  environment variables into the `Renviron.site` at pod startup,
  as without these variables `kubectl` does not work.

### Custom service scripts:

- Extra services to be monitored by `s6-overlay` should be
  placed in their own folder under `/etc/services.d/`
  containing a script called `run` and
  optionally a finishing script `finish`.
  - An example of a service can be found in
    [jupyter/s6/services.d/jupyterlab](jupyter/s6/services.d/jupyterlab)
    which is used to start JupyterLab itself.
  - For more information about the `run` and
    `finish` scripts, please see the
    [s6-overlay documentation][s6 writing a service script link].
  - __WARNING__: our example images run `s6-overlay` as
    `$NB_USER` not `root`, meaning any files or scripts
    related to `s6-overlay` should be
    owned by the `$NB_USER` user.
- There may be cases when you need to run a service as root.
  - To do this, you can change the Dockerfile to have `USER root`
    at the end, and then use `s6-setuidgid` to run the
    user-facing services as `$NB_USER`.

[Kubeflow notebook servers link]: https://github.com/kubeflow/kubeflow/tree/master/components/example-notebook-servers
[s6 overlay link]: https://github.com/just-containers/s6-overlay
[s6 container environment link]: https://github.com/just-containers/s6-overlay#container-environment
[s6 writing a service script link]: https://github.com/just-containers/s6-overlay#writing-a-service-script
[Elyra link]:https://github.com/elyra-ai/elyra

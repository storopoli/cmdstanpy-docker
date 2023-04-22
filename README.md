# CmdStanPy OCI Images

Includes:

- CmdStan built to `/opt/cmdstan-VERSION` with multithreading and OpenMPI support
- CmdStanPy (already configured to use the `CMDSTAN` path)
- `pandas`, `numpy`, `seaborn`, `arviz`, and `jupyter`

## How to use it

- Docker: `docker pull jstoropoli/cmdstanpy`
- GitHub Repository Container (GHCR): `docker pull ghcr.io/storopoli/cmdstanpy`

The image follows from the official [Python Docker image](https://hub.docker.com/_/python/).

If you want to run Jupyter you can do so with: `docker run --rm -ti -p 8888 cmdstanpy`

Followed by: `jupyter notebook --ip=0.0.0.0 --no-browser`

## LICENSE

MIT

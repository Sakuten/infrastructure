# Use `tfenv`

This repository requires [tfenv](https://github.com/tfutils/tfenv) to be installed on your system.

See the following instructions to install `tfenv`:

## 1. Delete existing `terraform` installation

```bash
# this operation may requires root privilege
sudo rm "$(which terraform)"
```

## 2. Install `tfenv`

```bash
brew install tfenv
```

for manual installation, see [tfutils/tfenv](https://github.com/tfutils/tfenv)

Terraform Module
============
This repository serves as a generic terraform template, enhanced with a Makefile and Docker Compose for streamlined setup and usage.

## 🪜 Repository Structure
> [utilizable/github-actions-semver-tagging](https://github.com/utilizable/github-actions-semver-tagging)
>> [utilizable/terraform-module](https://github.com/utilizable/terraform-module)
>>> [utilizable/terrafrom-module-ansible](https://github.com/utilizable/terrafrom-module-ansible)

## Table of Contents
- [Requirements](#-requirements)
- [Quick start](#%EF%B8%8F-quick-start)
- [Module options](#-module-options)
- [Configuration](#%EF%B8%8F-configuration)
- [Makefile stages](#-make-stages)
- [Repository structure](#-repository-structure-1)
- [Versioning model](#-versioning-model)

## 🧰 Requirements
<sup>[(Back to top)](#table-of-contents)</sup>

Make sure you have installed both - latest docker and gnu make!

  - `Docker` - https://docs.docker.com/desktop/install/
  - `Make` - https://ftp.gnu.org/gnu/make/

## ⚡️ Quick start
<sup>[(Back to top)](#table-of-contents)</sup>

  1. Clone repository
  2. adjust [.env](./build/.env)
  3. execute `make init`

## 📔 Module Options
<sup>[(Back to top)](#table-of-contents)</sup>

Module is based on [example](https://registry.terraform.io/providers/) provider.

#### Input Variables
```tf
# ./terraform/main.tf
...
```
#### Environment Requirements
```ini
# ./build/.env
...
```
## ⚙️ Configuration
<sup>[(Back to top)](#table-of-contents)</sup>

You can overload default `.env` configuration file using ENV_FILE variable. 

#### Command Line:
```sh
ENV_FILE=.env.override make apply
```
```sh
export ENV_FILE=.env.override
make apply
```
#### Github Actions:
```sh
- name: Terraform apply
  run: |
    echo "${{ secrets.ENV_PRODUCTION }}" > .env.override
    ENV_FILE=.env.override make apply
```

## 📒 Make stages
<sup>[(Back to top)](#table-of-contents)</sup>

Stages definied in makefile.

- `make prune` - Wipe all docker-related resources associated with the current project,
- `make show` - Show executed containers (dokcer-compose ps -a),
- `make backend` - Setup [MinIO](https://min.io/) S3 backend with pre-definied bucket (`backend_bucket` variable based),
- `make init` - Execute `terraform init` for modules located in `./terraform` inside docker container,
- `make plan` - Execute `terraform plan` for modules located in `./terraform` inside docker container,
- `make apply` - Execute `terraform apply` for modules located in `./terraform` inside docker container,
- `make destroy` - Execute `terraform destroy` for modules located in `./terraform` inside docker container.

## 🗄 Repository structure
<sup>[(Back to top)](#table-of-contents)</sup>

- `./terraform` terraform related resources, workdir for compose-containers,
- `./build/compose.yml` each step contains its own docker container,
- `./Makefile` entrypoint,
- `./build/.env` default configurations.

## 🔖 Versioning model
<sup>[(Back to top)](#table-of-contents)</sup>

Versions have the format `<MAJOR>.<MINOR>(.<PATCH>)?` where:

- `<MAJOR>` Triggered manualy from default branch,
- `<MINOR>` Triggered automaticly after each push from default branch,
- `<PATCH>` Triggered automaticly after each push from fix/[0-9].[0-9].x branch.

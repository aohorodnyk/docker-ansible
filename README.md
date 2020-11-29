# Ansible Docker Container

* [Motivation](#motivation)
* [Versions](#versions)
* [Examples](#examples)
* [Contributing](#contributing)

## Motivation
Ansible is great tool for deployment, but one disadvantage is - "python and a lot of dependencies". In my "ideal world", I do not install a lot of dependencies from various programs on my working computer.
This `docker-ansible` image was created to provide all needed dependencies inside the image and as a result ansible can be used from docker without additional dependencies on local computer.

Docker repository is located `ghcr.io/aohorodnyk/ansible`.

## Versions
The latest version of docker repository is located in `latest` tag.
Every version has tag in the repository as `2.10.2`.
All patch, minor and major versions are tagged hierarchically, as an example:
* We have the version `2.10.3`
* We have the version `2.10.4`
* We have the version `2.11.1`
* We have the version `2.11.2`
* Tag `2.10` contains the latest `2.10` version, in our example - `2.10.4`
* Tag `2.11` contains the latest `2.11` version, in our example - `2.11.2`
* Tag `2` contains the latest `2` version, in our example - `2.11.2`

## Examples
Running ansible playbook
```bash
$ docker run -v $(pwd):/playbook:ro -v ~/.ssh:/root/.ssh:rw -ti ghcr.io/aohorodnyk/ansible:latest ansible-playbook -i inventory --vault-password-file=.vault_pass playbook.yml
```

Running ansible vault
```bash
$ docker run -v $(pwd):/playbook:rw -v ~/.ssh:/root/.ssh:rw -ti ghcr.io/aohorodnyk/ansible:latest ansible-vault encrypt --vault-password-file=.vault_pass /playbook/secrets/secret.key
```

## Contributing
All contributions have to follow the [CONTRIBUTING.md document](https://github.com/aohorodnyk/uid/blob/main/CONTRIBUTING.md)
If you have any questions/issues/feature requests do not hesitate to create a ticket.

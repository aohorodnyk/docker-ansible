# Ansible Docker Container

* [Motivation](#motivation)
* [Examples](#examples)
* [Contributing](#contributing)

## Motivation
Ansible is great tool for deployment, but one disadvantage is exist - "python and a lot of dependencies". In my "ideal world", I do not install a lot of dependencies from various programs on my working computer.
One from the solution is containers. This docker-ansible image was created to provide all needed dependencies and as a result ansible can be used from docker without additional dependencies on local computer.

## Examples
Running ansible playbook
```bash
$ docker run -v $(pwd):/playbook:ro -v ~/.ssh:/root/.ssh:rw -ti ansible ansible-playbook -i inventory --vault-password-file=.vault_pass playbook.yml
```

Running ansible vault
```bash
$ docker run -v $(pwd):/playbook:rw -v ~/.ssh:/root/.ssh:rw -ti ansible ansible-vault encrypt --vault-password-file=.vault_pass /playbook/secrets/secret.key
```

## Contributing
All contributions have to follow the [CONTRIBUTING.md document](https://github.com/aohorodnyk/uid/blob/main/CONTRIBUTING.md)
If you have any questions/issues/feature requests do not hesitate to create a ticket.

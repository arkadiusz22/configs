# .gitconfig

Create `~/.gitconfig` as below, and leverage the include to `~/projects/configs/.gitconfig_shared`.

```
[user]
	name = <user_name>
	email = <user_email>
	signingkey = <gpg_key_id>
[include]
    path = ~/projects/config/git/.gitconfig_shared
```

# .bashrc

Leverage symlink from `~/projects/configs/.bashrc` to `~/.bashrc`.
Keep `.bash_aliases` in `~/projects/configs`.
Keep `.bash_secrets` in `~/`.

```
ln -sf ~/projects/configs/.bashrc ~/.bashrc
```

# Git Setup

Git is installed and managed exclusively within **WSL**. The Windows installation section is for reference only

## .gitconfig

Create `~/.gitconfig` as below, and leverage the include to shared file `~/projects/configs/.gitconfig_shared`.

```
[user]
	name = <user_name>
	email = <user_email>
	signingkey = <gpg_key_id>
[include]
    path = ~/projects/configs/git/.gitconfig_shared
```

## Git for Windows — Installer Options

For future reference - set of options for git on windows installation.

| Option                          | Choice                                | Why?                                                         |
| :------------------------------ | :------------------------------------ | :----------------------------------------------------------- |
| **Components**                  | LFS, Scalar, Check for updates        | Essential development extensions.                            |
| **Default editor**              | VS Code                               | Ensures consistency with WSL environment.                    |
| **PATH environment**            | Git from the command line...          | Standard access for Windows tools/VS Code.                   |
| **SSH executable**              | Use bundled OpenSSH                   | Standard integration with SSH-based remotes.                 |
| **HTTPS transport**             | Use the OpenSSL library               | Default security layer.                                      |
| **Line ending conversions**     | **Checkout as-is, commit Unix-style** | **Crucial:** Matches `autocrlf = input` from shared config.  |
| **Terminal emulator**           | Use Windows' default console          | Clean integration with Windows Terminal.                     |
| **Default `git pull` behavior** | Fast-forward or merge                 | Standard behavior (overridden by `rebase` in shared config). |
| **Credential helper**           | **Git Credential Manager**            | Reliable auth handler for GitHub/Azure DevOps.               |
| **Extra options**               | Enable file system caching            | Critical for performance when accessing NTFS drives.         |

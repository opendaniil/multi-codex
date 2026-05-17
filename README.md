# multi-codex

Tiny Bash launcher for isolated Codex CLI profiles.

`multi-codex` stores each profile as a direct child of `$HOME/.multi-codex` and runs `codex` with the selected isolated profile.

## Platform Support

- Supported/tested: macOS
- Expected to work: Linux
- Windows: not supported yet

## Requirements

- Bash
- Codex CLI

## Install

Inspect the install script before running it.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/opendaniil/multi-codex/main/install.sh)"
```

The installer downloads `multi-codex`, installs it as an executable named `multi-codex`, and does not edit shell startup files.

### Manual Install

Download `multi-codex`, inspect it, place it somewhere on your PATH, and make it executable:

```bash
curl -fsSL -o multi-codex https://raw.githubusercontent.com/opendaniil/multi-codex/main/multi-codex
chmod +x multi-codex
```

Then move it to a directory on your PATH, for example:

```bash
mkdir -p "$HOME/.local/bin"
mv multi-codex "$HOME/.local/bin/multi-codex"
```

## Quick Start

```bash
multi-codex new work
multi-codex new home
multi-codex work
```

## Commands

| Command                        | Description                            |
| ------------------------------ | -------------------------------------- |
| `new <profile>`                | Create an isolated Codex profile       |
| `list`                         | List profiles                          |
| `delete <profile>`             | Delete a profile after confirmation    |
| `doctor`                       | Check Bash, Codex, and profile storage |
| `help` / `--help` / `-h`       | Show help                              |
| `version` / `--version` / `-v` | Show version number                    |
| `<profile> [codex args...]`    | Launch Codex with the selected profile |

## Storage

Profile storage:

- `$HOME/.multi-codex`

Profiles are direct children of the storage root. Reserved names:

- `bin`
- `.templates`

## Updates

There are no background updates. To update, inspect and rerun the installer.

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/opendaniil/multi-codex/main/uninstall.sh)"
```

The uninstaller removes the installed launcher and asks before deleting profile data.

## Trust Model

- The launcher is a tiny Bash script.
- The install script downloads one file and places it on your PATH.
- Install and uninstall scripts do not edit shell startup files.
- Inspect scripts before running remote commands.
- The launcher does not make hidden network calls.
- There are no background updates.
- Profiles may contain Codex config, sessions, and auth data.

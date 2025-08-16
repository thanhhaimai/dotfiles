# The zsh setup

## Mac / Ubuntu compatiblity

### Mac `/etc/zprofile` will mess with the `PATH` variable

The RC load order:

1. `.zshenv`
2. Login mode:
    i. `/etc/zprofile`. On Mac, this will call `path_helper` and mess with the `PATH` variable.
    ii. `.zprofile`
3. Interactive mode:
    i. `/etc/zshrc`
    ii. `.zshrc`
4. Login mode:
    i. `/etc/zlogin`
    ii. `.zlogin`

If we set the `PATH` in step 1, Mac will mess up the `PATH`, while Ubuntu will leave the `PATH` intact.

### Login shell

- On Mac, all new terminal sessions are Login shell (will call step 2 and 4 above)
- On Ubuntu, `ssh` session is a Login shell. Normal terminal session are *not* Login shell
  (like when you run `kitty` directly).

That means we need to be careful about where to put the config, or it might not be loaded.

### Agent Terminal

When running LLM Agent with Terminal access, we also don't need

### Recommendation

Use cases:

- Normal shell
- SSH
- LLM Agent

Recommendation for compatibility:

- Only use `.zshrc` (step 3 above), which will be loaded by all above use cases on both Mac / ubuntu
- The file can optionally be split into `.basic.zshrc` and `.full.zshrc`
- `.basic.zshrc` should set up a fully functional shell meant for Agent and other non-interactive use cases.
  It should setup `brew`, `PATH`, and other common settings to make sure the systems work well.
- `.full.zshrc` is loaded if it's not a shell initiated by `cursor`.
  It includes all the settings meant to make the interactive sessions more pleasant to use.
  For example, p10k shell prompt, aliases, and UX settings.

Example gate in `.full.zshrc`

```
if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "cursor" ]]; then
  return
fi
```

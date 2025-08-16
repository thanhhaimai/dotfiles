# The zsh setup

## Mac / Ubuntu compatibility

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
   ii. `.login`

If we set the `PATH` in step 1, Mac will mess up the `PATH`, while Ubuntu will leave the `PATH` intact.

### Login shell behavior

- **On Mac**: All new terminal sessions are Login shells (will call step 2 and 4 above)
- **On Ubuntu**: `ssh` sessions are Login shells. Normal terminal sessions are *not* Login shells
  (like when you run `kitty` directly).

This means we need to be careful about where to put the config, or it might not be loaded in certain scenarios.

### Agent Terminal considerations

When running LLM Agent with Terminal access, we also need to consider:

- Non-interactive shell behavior
- Minimal PATH and environment setup
- Avoiding heavy interactive features

### Recommendation

**Use cases to support:**

- Normal interactive shell
- SSH sessions
- LLM Agent with terminal access

**Recommendation for cross-platform compatibility:**

- **Primary**: Use `.zshrc` (step 3 above), which will be loaded by all above use cases on both Mac and Ubuntu
- **File organization**: The file can optionally be split into `.basic.zshrc` and `.full.zshrc`
- **`.basic.zshrc`**: Should set up a fully functional shell meant for Agent and other non-interactive use cases.
  It should setup `brew`, `PATH`, and other common settings to ensure the system works well.
- **`.full.zshrc`**: Is loaded if it's not a shell initiated by `cursor` or other development environments.
  It includes all the settings meant to make interactive sessions more pleasant to use.
  For example, p10k shell prompt, aliases, and UX settings.

**Example gate in `.full.zshrc`:**

```bash
if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "cursor" ]]; then
  return
fi
```

## Implementation notes

### PATH management

- Set critical PATH entries in `.basic.zshrc`
- Avoid setting PATH in `.zshenv` on Mac systems

### Environment detection

- Check `$TERM_PROGRAM` for development environments

### Performance considerations

- Keep `.basic.zshrc` lightweight for non-interactive use
- Lazy-load heavy features in `.full.zshrc`

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

### Don't export unnecessary config in `.full.zshrc`

`export SOME_CONFIG` will keep pollute the environments for the next shell running `.basic.zshrc`

Don't `export` unless it's okay for a basic shell to pick up.
And at that point, consider adding the config to `.basic.zshrc` directly.

### Recommendation

**Use cases to support:**

- Normal interactive shell
- SSH sessions
- LLM Agent with terminal access

**Recommendation for cross-platform compatibility:**

- **Primary**: Use `.zshrc` (step 3 above), which will be loaded by all above use cases on both Mac and Ubuntu
- **File organization**: The common config can be split into `.basic.zshrc` and `.full.zshrc`
- **`.basic.zshrc`**: Should contain the minimum setup for a functional shell meant for Agent and other non-interactive usecases.
  It should setup `brew`, `PATH`, and other common settings to ensure the system works well.
- **`.full.zshrc`**: Should contain the additional setup (like Oh My Zsh, p10k, and other UX settings).
  It includes all the settings meant to make interactive sessions more pleasant to use.
  Heavy features should be lazy-loaded to reduce start up latency.
- The main config (to be symlinked to `~/.zshrc`) is the platform specific config. For example `mac/.zshrc` and `ubuntu/.zshrc`
- It will use `source_releative_path` to load `.basic.zshrc`,
  then load platform specific config,
  then load `.full.zshrc` if `$TERM_PROGRAM` is not `cursor` or `vscode.

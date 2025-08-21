# The SSH setup

## Mac / Ubuntu compatibility

### Oh My Zsh `ssh-agent` plugin

Mac ssh agent is provided by the Oh My Zsh `ssh-agent` plugin

The main config would be:

```shell
# Make sure SSH agent doesn't output anything on startup
zstyle ':omz:plugins:ssh-agent' quiet yes

# Load SSH identities
zstyle ':omz:plugins:ssh-agent' identities id_ed25519_gmail
```

If you have more than one identities, add them to the list above.

### Ubuntu

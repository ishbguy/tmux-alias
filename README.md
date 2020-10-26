# Tmux Alias

Tmux plugin for adding alias easily!

## Installation

### Using [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add the following to your list of TPM plugins in `.tmux.conf`:

```
set -g @plugin 'ishbguy/tmux-alias'
```

Hit <kbd>prefix</kbd>+<kbd>I</kbd> to fetch and source the plugin. You should now be able to use this plugin!

### Manual

Clone the repo:

```
git clone https://github.com/ishbguy/tmux-alias .tmux/plugins/tmux-alias
```

Source in your `.tmux.conf`:

```
run-shell ~/.tmux/plugins/tmux-alias/alias.tmux
```

Reload tmux conf by running:

```
tmux source-file ~/.tmux.conf
```

## Usage

### Configure in `.tmux.conf`

```
set -g @alias zoom="resize-pane -Z"
```

### Use in tmux command prompt mode

```
alias zoom="resize-pane -Z"
```

## License

Released under the terms of [MIT](LICENSE) license.

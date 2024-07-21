# 🟠 Marsnvim Config

My first ever configuration of nvim!!

---

## ✨ Features

- Fuzzy find using Telescope
- Quick lists using Trouble
- Simple keybindings with Which Key
- & much more...

## 📦 Installation

1. Backup old nvim configurations

```bash
mv ~/.config/nvim{,.bak}
```

```bash
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

2. Get the installer
3. Run the installer and follow the steps

> [!NOTE]
> The installation can be **local** or **default**.
> The **local** installation clones the repository and removes any link to the
> remote.
> The `nvim` directory and its content can be modified in every aspect.
> The **default** installation keeps the `.git` directory and `.gitignore` file.
> Updating the repository will install the updates!

4. Run `nvim`

## 🚀 Configuration

All the user customizations to Marsnvim can be done inside the `localconfig`
directory.

> [!WARNING]
> In case of the **default** installation the `localconfig` directory is ignored
> by git. This ensures that the updates can be pulled without conflicts.
> **DO NOT** modify the file outside the `localconfig` directory.

### Plugins

To add a plugin simply create a file inside `localconfig/plugins` and add the
install snippet using Lazy.

Example:

```lua
-- localconfig/plugins/bestPluginEver.lua

return {
    'link to best plugin',
    config = function()
        -- config
    end
    ...
}
```

### Nvim configs

Inside the `localconfig` directory there is the `core` directory with the
`options.lua` file inside.

Options like `relativenumber` will go there.

To add file (eg: `keymaps.lua`) simply add the file inside the `core` directory
and add the following line to the `localconfig/core/init.lua` file:

```lua
-- localconfig/core/init.lua
...
require('marsnvim.localconfig.core.keymaps')
```

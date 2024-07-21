# 🟠 Marsnvim Config

My first ever configuration of nvim!!

> [!TIP]
> Please if you encounter any errors create an issue, i'll do my best to help
> troubleshooting and solving :)

---

## ✨ Features

- Fuzzy find using Telescope
- Quick lists using Trouble
- Simple keybindings with Which Key
- & much more...

## 📦 Installation

1. Download or build locally the most recent installer [here](https://github.com/Mitra98t/marsnvim/releases)
2. Run the installer and follow the steps
3. Run `nvim`

> [!NOTE]
> The installation can be **local** or **default**.
>
> - The **local** installation clones the repository and removes any link to the
>   remote. The `nvim` directory and its content can be modified in every
>   aspect.
> - The **default** installation keeps the `.git` directory and `.gitignore`
>   file. Updating the repository will install the updates!

### Locally building the installer

Ensure you have a rust environment ready and `cargo` installed.

1. Clone the installer source code `git clone --branch installer https://github.com/Mitra98t/marsnvim.git marsnvim-installer`
2. Enter the directory `cd marsnvim-installer`
3. Run the installer `cargo run -- --installer`

### 🚨 Troubleshooting

> TODO

## 🚀 Configuration

All the user customizations to Marsnvim can be done inside the `localconfig`
directory.

> [!WARNING]
> In case of the **default** installation the `localconfig` directory is ignored
> by git. This ensures that the updates can be pulled without conflicts.
> **DO NOT** modify the file outside the `localconfig` directory.

### 🌳 Marsnvim structure

```
nvim
├── init.lua
└── lua
    └── marsnvim
        ├── lazy.lua
        ├── core
        │   ├── init.lua
        │   ├── keymaps.lua
        │   └── options.lua
        ├── localconfig
        │   ├── core
        │   │   ├── init.lua
        │   │   └── options.lua
        │   ├── init.lua
        │   └── plugins
        │       └── user plugins
        └── plugins
            ├── lsp
            │   └── lsp configuration plugins
            └── marsnvim plugins
```

All the `localconfig` folder can be customized at will.

### 🖋️ Adding and customizing plugins

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

The customization of your installed plugins can be done as normal.

> [!NOTE]
> To customize the default configuration of the marsnvim plugins...
> TODO

### 📚 Nvim configurations

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

## ☀️ Contributions

All the contributions are more than welcome!

Simply fork the repo and make a pull request.

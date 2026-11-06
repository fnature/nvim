# kickstart.nvim

## My custom notes

### Markdown preview

Open a Markdown file and use these normal-mode shortcuts (`<leader>` is Space):

| Shortcut | Action |
| --- | --- |
| `Space m p` | Toggle the live browser preview |
| `Space m s` | Stop the preview |

The shortcuts are buffer-local to Markdown files. The commands
`:MarkdownPreview`, `:MarkdownPreviewToggle`, and `:MarkdownPreviewStop` are
also available. lazy.nvim downloads the plugin and its prebuilt preview server
on installation; no manual Node.js/Yarn build is required. After adding the
plugin, restart Neovim and let lazy.nvim finish installing it (or run
`:Lazy install`).

### Pasting images into Markdown

In a saved Markdown file, copy a screenshot or image to the system clipboard,
then press **`Space m v` in Normal mode**. `img-clip.nvim` saves it as a uniquely
named PNG in an `images/` folder beside that Markdown file and inserts a relative
image reference. The cursor enters the alt-text field: type a description and
press `Esc`. Snacks handles displaying the inserted image in Kitty.

The shortcut is Markdown-buffer-local and refuses unnamed or derived preview
buffers: save the file and use the normal source view first. Normal text paste,
existing shortcuts, and terminal drag-and-drop behavior are unchanged. Copied
local image paths are imported into the same `images/` folder; images are not
embedded as base64. Include the image files when sharing or committing Markdown.

Restart Neovim and let lazy.nvim install the plugin. On Linux, the machine
running Neovim needs `xclip` on X11 or `wl-clipboard` (`wl-paste`) on Wayland.
Run `:checkhealth img-clip` there to verify clipboard support. The plugin also
provides `:PasteImage`, `:ImgClipConfig`, and `:ImgClipDebug` for direct use and
diagnostics; `Space m v` adds the saved-source-buffer safety check.

### Wrapped Markdown tables

`markdown-table-wrap.nvim` wraps long cell contents inside aligned table borders
without rewriting the Markdown source. It loads only for Markdown. Documents
containing pipe tables automatically render them inline in the original file
buffer. This keeps Snacks images, the normal Feline status bar, and file-based
tools working together. No Reader/source switch is needed for normal use.

| Shortcut | Action |
| --- | --- |
| `Space m r` | Toggle the optional separate Reader/source view |
| `Space m i` | Toggle inline tables/source |
| `Space m f` | Open a floating preview of the table under the cursor |

Inline tables remain visible when the cursor moves elsewhere in the document.
Insert/Visual mode temporarily exposes the source for editing; normal-mode
automatic rendering returns afterwards. `Space m i` toggles between the rendered
table and raw source without replacing the file buffer. The existing
browser-preview shortcuts are unchanged.

For reliable inline replacement, the plugin temporarily disables native soft
wrapping in windows containing rendered tables; the cells still wrap within
their allocated widths. Turning inline tables off restores the previous wrap
setting, as does leaving the Markdown buffer. Ordinary files are unaffected.

Reader is still available explicitly with `Space m r`, but its separate derived
buffer is not the combined image/table editing view. In Reader, `q` returns to
source and pauses automatic reopening; use `Space m i` to restore inline tables.
In a float, `q` or `Esc` returns to the previous view.

`Alt+w` opens Neo-tree and reveals the backing Markdown file even from Reader
or Float, rather than treating the virtual preview name as a filesystem path.
For an unnamed source buffer it opens the tree without attempting a reveal.

The table renderer in `render-markdown.nvim` is disabled only for the `markdown`
filetype to avoid duplicate rendering. Its other Markdown styling and Avante
table rendering remain enabled. The normal source buffer now supports images
and inline tables together; browser preview remains an alternative full-document
view.

Restart Neovim and let lazy.nvim install the new plugin (or run `:Lazy install`).
Neovim 0.10+ is required; no external binaries are needed. Use
`:MarkdownTableStatus`, `:MarkdownTableHelp`, or `:checkhealth markdown-table-wrap`
for diagnostics. To disable automatic rendering for a buffer, run
`:MarkdownTableDisableAutoPreview`; the shortcuts still work on demand.

### Inline Markdown images in Kitty

The existing `render-markdown.nvim` plugin styles Markdown; `snacks.nvim` adds
inline images. Only Snacks' image component is enabled: it does not replace the
file picker, notifications, terminal, or other existing tools.

1. Open Kitty and launch Neovim as you normally do. This uses the same Neovim
   configuration; no terminal migration or default-terminal change is needed.
2. Let lazy.nvim install Snacks (or run `:Lazy install` and restart Neovim).
3. Open `doc/markdown-images-demo.md` from this configuration directory. The
   linked PNG should appear inline, not in your browser.

Kitty and ImageMagick must be installed on the machine running Neovim. The
`markdown` and `markdown_inline` Tree-sitter parsers are already in the install
list. If necessary, run `:TSInstall markdown markdown_inline`.

For troubleshooting, use `:checkhealth snacks` and check the image section.
Try Kitty directly, without tmux first; tmux may need `allow-passthrough on`.
Inline images are not supported in Terminator, but browser preview remains
available there using `Space m p`. ImageMagick is needed for conversion of
formats other than PNG; PDF, math, and diagram rendering can need additional
tools and are not prerequisites for this local PNG demo.

Requirements:

#install
sudo apt install unzip gcc fontconfig

#install npm - I don't remember why

curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - && sudo apt-get install -y nodejs

this is not clear.. but maybe it was to get npm..

#install nerdfonts

cd  /usr/local/share/fonts
sudo curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip --output JetBrainsMono.zip
sudo unzip JetBrainsMono.zip
sudo rm -f JetBrainsMono.zip
sudo fc-cache -fv

The rest is copy from kickstart

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If want to write Typescript, you need `npm`
  - If want to write Golang, you will need `go`
  - etc.

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> **NOTE**
> Your fork's url will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

#### Clone kickstart.nvim
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git %userprofile%\AppData\Local\nvim\
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git $env:USERPROFILE\AppData\Local\nvim\
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the 
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>


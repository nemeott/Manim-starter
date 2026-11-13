# Fully working [Manim setup ⮺](https://docs.manim.community/en/stable/installation/uv.html)

**Note** that ManimCE is CPU based, and that's what is configured here,
Binding with system GPU is provided but not useful here.

- [nix](https://yduf.github.io/package-nix/) provides standard tools Python + uv
- [uv](https://docs.astral.sh/uv/) manage Python packages
- thanks to [NixGLHost](https://github.com/numtide/nix-gl-host?tab=readme-ov-file#nixglhost---nix-openglcuda-wrapper) we can bridge [system driver](https://yduf.github.io/pc-hardware-gpu-rtx-5070Ti/#linux-setup) to Nix setup

<pre>
.
├── pyproject.toml
└── shell.nix
</pre>

## Setup

As a prerequesite, you need to have

- [nix](https://yduf.github.io/package-nix/) package manager installed.

```bash
# This is the regular call to have a working environment
# use nix-shell rather than flake.nix to avoid full copy of the folder
nix-shell
uv sync

# This can take some times as it will download pytorch > 1GB of package

# then (optionally) check (and generate a sample video)
uv run manim checkhealth

# and you are done
```

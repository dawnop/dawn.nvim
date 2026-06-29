# CUDA intellisense on macOS (no GPU / no toolkit)

macOS has no official CUDA toolkit (`nvcc`) and no NVIDIA GPU, so you **cannot
compile or run** CUDA here. But you *can* get full clangd-powered editing for
`.cu` / `.cuh` files: syntax highlighting, semantic completion on the CUDA
runtime API, `<<<>>>` kernel launches, error checking — all driven by clang's
own CUDA front end against a header-only fake toolkit.

These files live **outside this repo** (machine-level). This doc records what
they are so the setup can be reproduced.

## Pieces

| Path | What |
| --- | --- |
| `~/.local/cuda/include/` | ~105 CUDA headers (`cuda_runtime.h`, `device_launch_parameters.h`, `curand_*`, …) pulled from the `nvidia-*-cu12` pip wheels |
| `~/.local/cuda/nvvm/libdevice/libdevice.10.bc` | libdevice bitcode — `--cuda-path` requires it to exist |
| `~/.local/cuda/bin/ptxas` | placeholder so `--cuda-path` validates |
| `~/.local/cuda/version.txt` / `version.json` | `CUDA Version 12.3.0` so clang stops complaining about a missing version file |
| `~/.local/cuda/clangd_cuda_shim.h` | intellisense-only shim declaring the legacy launch API (see below) |
| `~/Library/Preferences/clangd/config.yaml` | the global clangd config that wires it all up — **note: macOS uses `~/Library/Preferences/clangd/`, NOT `~/.config/clangd/`** |

### The clangd config

Scoped via `PathMatch` to `.cu`/`.cuh` only, so normal C/C++ is untouched:

```yaml
If:
  PathMatch: [.*\.cu, .*\.cuh]
CompileFlags:
  Add:
    - -xcuda
    - --cuda-path=/Users/dawn/.local/cuda
    - --cuda-gpu-arch=sm_86          # adjust to your GPU (sm_75/86/89/90…)
    - -std=c++17
    - -D__CLANGD__                   # enables the legacy-launch shim
    - -include
    - /Users/dawn/.local/cuda/clangd_cuda_shim.h
    - -Wno-unknown-cuda-version
```

### The shim

clang's `<<<>>>` lowering can reference the legacy `cudaConfigureCall` launch
API when it doesn't recognise the CUDA version. The shim declares it so kernel
launch lines resolve. Guarded by `__CLANGD__`, so it is never seen by a real
build:

```cpp
#ifdef __CLANGD__
extern "C" cudaError_t cudaConfigureCall(dim3 gridDim, dim3 blockDim,
                                         size_t sharedMem = 0, cudaStream_t stream = 0);
#endif
```

## Treesitter

`cuda` parser is in `ensure_installed` (see `nvim/lua/dawn/plugins/treesitter.lua`)
so `.cu`/`.cuh` get real tree-sitter highlighting, not regex fallback.

## Reproduce on a new machine

1. Make the fake toolkit dir and pull headers from pip wheels:
   ```sh
   mkdir -p ~/.local/cuda/{include,nvvm/libdevice,bin}
   pip download nvidia-cuda-runtime-cu12 nvidia-curand-cu12 --no-deps -d /tmp/cu
   # unzip the wheels, copy their include/*.h into ~/.local/cuda/include/
   ```
2. Create `libdevice.10.bc` (real bitcode from a libdevice wheel, or a
   placeholder), a `bin/ptxas` placeholder, and `version.txt` =
   `CUDA Version 12.3.0`.
3. Write `~/.local/cuda/clangd_cuda_shim.h` (shim above).
4. Write `~/Library/Preferences/clangd/config.yaml` (config above).
5. Open a `.cu` file and run `:LspInfo` / `:checkhealth`. clangd should report
   "0 errors" on a simple kernel.

## Actually compiling

You can't, on this Mac. Options:
- An NVIDIA Linux box / WSL with the real toolkit: `nvcc foo.cu -o foo`.
- Or clang as a CUDA compiler (still needs a real GPU + driver to *run*).
- For pure editing/learning, this intellisense setup is enough.

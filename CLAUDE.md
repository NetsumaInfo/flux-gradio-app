# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **FLUX.2-klein-4B Image Generator** - a Gradio-based web application for AI image generation using Black Forest Labs' FLUX.2-klein-4B model. It supports both text-to-image generation and image editing modes.

## Commands

### Installation (Windows)
```batch
install.bat
```
**Fully automated installation script** - checks prerequisites, installs dependencies, and guides the user.

**Pre-installation checks:**
- Verifies Python 3.10 or 3.11 is installed and in PATH
- Checks for NVIDIA GPU and drivers (nvidia-smi)
- Displays clear error messages with download links if missing

**Installation steps:**
1. Creates virtual environment
2. Upgrades pip
3. Installs PyTorch with CUDA 12.4 (GPU acceleration)
4. Installs Gradio, Transformers, Accelerate
5. Installs Diffusers from GitHub
6. Removes xformers (incompatible on Windows)
7. Verifies CUDA is available
8. Optionally pre-downloads the model (~8GB)

**User-friendly features:**
- Progress indicators with clear status messages
- Error handling with actionable solutions
- Automatic CUDA fix if GPU detected but PyTorch can't use it
- Choice to skip model download (downloads on first run instead)
- Final summary showing GPU status and expected performance

### Complete Reinstallation
```batch
reinstall.bat
```
Deletes the existing virtual environment and runs a fresh installation. Use this if you encounter installation issues.

**Note**: The installation script now automatically detects and fixes CUDA issues, so separate diagnostic scripts are no longer needed.

### Running the Application
```batch
run.bat
```
Starts the Gradio web interface. Automatically uses GPU if CUDA is available, falls back to CPU otherwise.

### Manual Commands (with venv activated)
```batch
venv\Scripts\activate.bat
python app.py
```

## Architecture

Single-file application (`app.py`) with three main components:

1. **Model Loading**: Initializes `Flux2KleinPipeline` from diffusers with automatic CUDA/CPU detection and bfloat16/float32 dtype selection.

   **GPU Optimizations (when CUDA available):**
   - PyTorch native Flash Attention (SDPA) - xformers not used on Windows
   - Attention slicing for memory efficiency
   - VAE tiling for large images
   - torch.compile for 30-50% speed boost (after warmup)
   - Generator on GPU instead of CPU

2. **Generation Function** (`generate_image`): Handles both modes:
   - Text-to-image: `image=None` parameter, uses slider dimensions
   - Image editing: Accepts PIL image, uses input image dimensions or sliders
   - **No num_inference_steps parameter** - distilled model uses fixed 4 steps

3. **Gradio Interface**: `gr.Blocks` layout with prompt input, optional input image, dimension/guidance sliders, seed control, and output display.

## Key Dependencies

- `diffusers` installed from GitHub (required for `Flux2KleinPipeline`)
- PyTorch with CUDA 12.4 support
- Gradio for the web UI

## Model

- **Model ID**: `black-forest-labs/FLUX.2-klein-4B`
- **Type**: Distilled model (fixed 4-step inference)
- **Source**: https://huggingface.co/black-forest-labs/FLUX.2-klein-4B
- **Size**: ~8GB (auto-downloaded on first run)
- **License**: Apache 2.0 (open source)
- **Capabilities**: Text-to-image, single-reference image editing, multi-reference generation

## Troubleshooting

### GPU not detected
1. Run `check_cuda.bat` to verify CUDA availability
2. If CUDA shows as unavailable:
   - Ensure you have an NVIDIA GPU
   - Update NVIDIA drivers: https://www.nvidia.com/drivers
   - Run `install_cuda.bat` to reinstall PyTorch with CUDA
3. If issues persist, run `reinstall.bat` for a fresh installation

### Model loading errors
- Run `reinstall.bat` to clean install all dependencies
- Check you have ~10GB free disk space for the model
- Verify internet connection for model download

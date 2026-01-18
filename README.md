# FLUX.2-klein-4B Image Generator

Generate AI images in seconds with FLUX.2-klein-4B! This is a free, open-source image generator that runs on your own computer.

## Features

- **Text-to-Image**: Create images from text descriptions
- **Image Editing**: Modify existing images with text prompts
- **Fast Generation**: 4-step distilled model for quick results
- **GPU Accelerated**: Uses NVIDIA GPU for maximum speed (CPU fallback available)
- **Easy to Use**: Simple web interface, no coding required

## System Requirements

### Minimum (CPU Mode)
- Windows 10/11
- 16GB RAM
- 20GB free disk space
- Internet connection (for initial download)

### Recommended (GPU Mode)
- Windows 10/11
- NVIDIA GPU with 8GB+ VRAM (RTX 3060 or better)
- 16GB RAM
- 20GB free disk space
- Latest NVIDIA drivers

## Quick Start

### 1. Install Python

Download and install **Python 3.10 or 3.11** from:
https://www.python.org/downloads/

**IMPORTANT**: Check "Add Python to PATH" during installation!

### 2. Install Git (Required)

Download and install Git from:
https://git-scm.com/downloads

Use default settings during installation.

### 3. Install NVIDIA Drivers (Optional but Recommended)

If you have an NVIDIA GPU, install the latest drivers:
https://www.nvidia.com/drivers

This enables GPU acceleration (10x faster than CPU).

### 4. Run Installation Script

Double-click: `install.bat`

The script will:
- Check your system
- Install all dependencies (10-20 minutes)
- Download the AI model (~8GB)
- Verify GPU support

### 5. Start the App

Double-click: `run.bat`

Your browser will open with the app interface at:
http://127.0.0.1:7860

## How to Use

### Text-to-Image Mode
1. Type your prompt (e.g., "a cat wearing sunglasses")
2. Adjust width/height if needed (default: 1024x1024)
3. Adjust guidance scale (3.5 is recommended)
4. Click "Generate / Edit"
5. Wait ~5-30 seconds depending on GPU/CPU

### Image Editing Mode
1. Upload an image
2. Type what you want to change (e.g., "make it sunset")
3. Check "Preserve original image dimensions" if desired
4. Click "Generate / Edit"

## Tips for Best Results

- **Prompts**: Be descriptive and specific
  - Good: "a red sports car on a mountain road at sunset, photorealistic"
  - Bad: "car"

- **Guidance Scale**:
  - 3.5 = Balanced (recommended)
  - 1.0-2.0 = More creative/random
  - 5.0-10.0 = Follows prompt more strictly

- **Dimensions**:
  - Square (1024x1024) = Best quality
  - Landscape (1280x768) = Wide images
  - Portrait (768x1280) = Tall images

## Troubleshooting

### "Python is not installed"
- Install Python 3.10 or 3.11
- Make sure "Add to PATH" was checked
- Restart your computer after installation

### "Git is not installed"
- Install Git from https://git-scm.com/downloads
- Restart your computer after installation

### "GPU not detected" or slow generation
- Install NVIDIA drivers: https://www.nvidia.com/drivers
- Restart your computer
- Run `install.bat` again (it will automatically fix CUDA)
- If no NVIDIA GPU: app will use CPU (slower but works)

### Model download fails
- Check internet connection
- Disable VPN/firewall temporarily
- Try again - the download will resume where it left off

### Out of memory errors
- Reduce image dimensions (try 768x768 or 512x512)
- Close other applications
- GPU with less than 8GB VRAM may struggle with large images

## Scripts Reference

- `install.bat` - Complete installation with automatic CUDA detection and fixing
- `run.bat` - Start the application
- `reinstall.bat` - Complete clean reinstall if issues occur

## Advanced Options

### Seed
- Use `-1` for random images each time
- Use a specific number (e.g., `12345`) to get reproducible results

### Guidance Scale
- Controls how closely the AI follows your prompt
- Lower = more creative freedom
- Higher = stricter adherence to prompt

## License

This project uses:
- FLUX.2-klein-4B model (Apache 2.0 - Open Source)
- PyTorch, Gradio, Diffusers (Open Source libraries)

You can use this for personal or commercial projects!

## Credits

- Model: Black Forest Labs (https://blackforestlabs.ai/)
- Interface: Gradio (https://gradio.app/)
- Framework: Hugging Face Diffusers (https://huggingface.co/docs/diffusers)

## FAQ

**Q: Is this free?**
A: Yes! The model and all software are open source and free.

**Q: Do I need internet after installation?**
A: No, once installed, it runs completely offline.

**Q: How long does generation take?**
A: With GPU: 5-10 seconds | With CPU: 1-3 minutes

**Q: Can I run this on Mac/Linux?**
A: This script is for Windows. Mac/Linux users can run the Python script directly.

**Q: Is my data sent anywhere?**
A: No, everything runs locally on your computer.

**Q: Can I generate inappropriate content?**
A: The model has built-in safety filters.

## Support

For issues, check:
1. This README troubleshooting section
2. CLAUDE.md for technical details
3. Hugging Face model page: https://huggingface.co/black-forest-labs/FLUX.2-klein-4B

Enjoy creating amazing AI images! 🎨

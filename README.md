# 🎨 FLUX.2-klein-4B Image Generator

Generate stunning AI images in seconds with FLUX.2-klein-4B! A free, open-source image generator that runs entirely on your computer.

![GitHub](https://img.shields.io/badge/license-Apache%202.0-blue)
![Python](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue)
![PyTorch](https://img.shields.io/badge/PyTorch-2.0%2B-orange)

## ✨ Features

- **🖼️ Text-to-Image**: Create images from text descriptions
- **✏️ Image Editing**: Modify existing images with text prompts
- **⚡ Ultra Fast**: 4-step distilled model for lightning-fast generation
- **🚀 GPU Accelerated**: NVIDIA GPU support with CUDA (10x faster than CPU)
- **💻 Easy to Use**: Simple web interface powered by Gradio
- **🔒 Privacy First**: Runs completely offline after installation
- **🆓 100% Free**: Open-source model and software

## 🎯 Quick Start

### Prerequisites

- **Windows 10/11**
- **Python 3.10 or 3.11** ([Download here](https://www.python.org/downloads/))
- **Git** ([Download here](https://git-scm.com/downloads))
- **16GB RAM** minimum
- **20GB free disk space**
- **NVIDIA GPU** with 8GB+ VRAM (optional but highly recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/NetsumaInfo/flux-gradio-app.git
   cd flux-gradio-app
   ```

2. **Run the installer**
   ```bash
   install.bat
   ```
   
   The installer will:
   - ✓ Check your system requirements
   - ✓ Create a Python virtual environment
   - ✓ Install PyTorch with CUDA support (if GPU available)
   - ✓ Download all dependencies
   - ✓ Download the FLUX.2-klein-4B model (~8GB)
   - ✓ Verify installation

   *Installation takes 10-30 minutes depending on your internet speed.*

3. **Launch the application**
   ```bash
   run.bat
   ```
   
   Your browser will automatically open at `http://127.0.0.1:7860`

## 🎨 Usage

### Text-to-Image Generation

1. Enter your prompt (e.g., *"a cat wearing sunglasses, photorealistic, 4k"*)
2. Adjust image dimensions (default: 1024x1024)
3. Set guidance scale (3.5 recommended)
4. Click **"🚀 Generate / Edit"**
5. Wait 5-30 seconds for your image

### Image Editing

1. Upload an image
2. Enter your edit prompt (e.g., *"make it sunset"*)
3. Check **"Preserve original image dimensions"** if desired
4. Click **"🚀 Generate / Edit"**

## ⚙️ Parameters Guide

| Parameter | Description | Recommended |
|-----------|-------------|-------------|
| **Prompt** | Text description of desired image | Be specific and descriptive |
| **Width/Height** | Output dimensions (pixels) | 1024x1024 for best quality |
| **Guidance Scale** | How closely AI follows prompt | 3.5 (1.0=creative, 10.0=strict) |
| **Seed** | Reproducibility number | -1 for random |
| **torch.compile** | Advanced optimization | Enable for 30-50% speed boost |

## 💡 Tips for Better Results

### Writing Good Prompts

❌ **Bad**: "car"

✅ **Good**: "a red sports car on a mountain road at sunset, photorealistic, 4k, detailed"

**Useful Keywords:**
- **Style**: photorealistic, artistic, cartoon, digital art, oil painting
- **Quality**: 4k, 8k, high quality, detailed, professional
- **Lighting**: sunset, golden hour, studio lighting, natural light

### Dimension Recommendations

- **1024x1024** - Square, best quality
- **1280x768** - Landscape (wide)
- **768x1280** - Portrait (tall)
- **512x512** - Faster generation, lower quality

## ⚡ Performance Benchmarks

| Hardware | Generation Time |
|----------|----------------|
| RTX 4090 | ~5 seconds |
| RTX 3060 | ~10 seconds |
| GTX 1660 | ~20 seconds |
| Modern CPU | 1-3 minutes |

### Memory Requirements

| Resolution | GPU VRAM | System RAM |
|-----------|----------|------------|
| 512x512 | ~4GB | ~8GB |
| 768x768 | ~6GB | ~10GB |
| 1024x1024 | ~8GB | ~12GB |
| 1280x1280 | ~10GB | ~16GB |

## 🛠️ Troubleshooting

### Python/Git Not Found

- Install Python 3.10 or 3.11 and **check "Add Python to PATH"**
- Install Git and restart your computer
- Run `install.bat` again

### GPU Not Detected

- Verify you have an NVIDIA GPU
- Install latest drivers: https://www.nvidia.com/drivers
- Restart computer
- Run `install.bat` again (auto-detects and fixes CUDA)

### Out of Memory

- Reduce image dimensions (try 768x768 or 512x512)
- Close other applications
- GPUs with <8GB VRAM need smaller dimensions

### Model Download Fails

- Check internet connection
- Temporarily disable VPN/firewall
- Restart `install.bat` (downloads resume automatically)

## 📁 Project Structure

```
flux-gradio-app/
├── app.py                 # Main Gradio application
├── requirements.txt       # Python dependencies
├── install.bat           # Automated installation script
├── run.bat              # Launch script
├── README.md            # This file
└── venv/                # Virtual environment (created during install)
```

## 🔧 Advanced Options

### Enable torch.compile (Experimental)

Check **"Enable torch.compile"** in the UI for 30-50% faster generation.

⚠️ **Warning**: First generation takes 10-15 minutes for compilation warmup.

### Custom Model Path

Edit `app.py` line 7 to use a different model:
```python
MODEL_ID = "your-custom-model-id"
```

## 📜 License

This project uses:
- **FLUX.2-klein-4B model** - Apache 2.0 License ([Black Forest Labs](https://blackforestlabs.ai/))
- **PyTorch** - BSD License
- **Diffusers** - Apache 2.0 License
- **Gradio** - Apache 2.0 License

✅ **Commercial use allowed**  
✅ **Modification allowed**  
✅ **Distribution allowed**

## 🙏 Credits

- **Model**: [Black Forest Labs](https://blackforestlabs.ai/)
- **Framework**: [Hugging Face Diffusers](https://huggingface.co/docs/diffusers)
- **Interface**: [Gradio](https://gradio.app/)
- **Model Page**: [FLUX.2-klein-4B on Hugging Face](https://huggingface.co/black-forest-labs/FLUX.2-klein-4B)

## ❓ FAQ

**Q: Is this free?**  
A: Yes! The model and all software are open-source and free.

**Q: Do I need internet after installation?**  
A: No, it runs completely offline once installed.

**Q: How long does generation take?**  
A: GPU: 5-10 seconds | CPU: 1-3 minutes

**Q: Can I run this on Mac/Linux?**  
A: This installer is for Windows. Mac/Linux users can run `app.py` directly with Python.

**Q: Is my data sent anywhere?**  
A: No, everything runs locally on your computer. Zero telemetry.

**Q: Can I use generated images commercially?**  
A: Yes! Apache 2.0 license allows commercial use.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## 📞 Support

- 📖 Read this README and troubleshooting section
- 🐛 Open an issue on GitHub
- 💬 Check the [Hugging Face community](https://huggingface.co/black-forest-labs/FLUX.2-klein-4B/discussions)

---

**Enjoy creating amazing AI images!** 🎨✨

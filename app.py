import gradio as gr
import torch
from diffusers import Flux2KleinPipeline
from PIL import Image

# Configuration
MODEL_ID = "black-forest-labs/FLUX.2-klein-4B"
DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
DTYPE = torch.bfloat16 if torch.cuda.is_available() else torch.float32

print(f"Device: {DEVICE}")
print(f"Loading model {MODEL_ID}...")

# Load Model
pipe = None
try:
    pipe = Flux2KleinPipeline.from_pretrained(
        MODEL_ID,
        torch_dtype=DTYPE
    )
    # GPU optimizations
    if DEVICE == "cuda":
        pipe = pipe.to(DEVICE)

        # Enable PyTorch's native scaled dot product attention (Flash Attention)
        # xformers is not used on Windows due to DLL compatibility issues
        print("✓ Using PyTorch native Flash Attention (SDPA)")

        # Enable attention slicing for memory efficiency
        try:
            pipe.enable_attention_slicing(1)
            print("✓ Attention slicing enabled")
        except:
            print("⚠ Attention slicing not available")

        # Enable VAE tiling for large images
        try:
            pipe.vae.enable_tiling()
            print("✓ VAE tiling enabled")
        except:
            print("⚠ VAE tiling not available")

        # torch.compile will be applied on-demand based on user choice
        print("✓ torch.compile available (can be enabled in UI)")
    else:
        # CPU mode - just keep model on CPU without offloading
        print("⚠ Running on CPU - this will be slow. Install CUDA for GPU acceleration.")
        pipe = pipe.to("cpu")

    print("Model loaded successfully!")
except Exception as e:
    print(f"Error loading model: {e}")

def generate_image(prompt, input_image, preserve_dimensions, width, height, guidance_scale, seed, use_torch_compile):
    if pipe is None:
        return None, "❌ Error: Model not loaded."

    # Apply torch.compile if requested and not already compiled
    global compiled_transformer
    if use_torch_compile and DEVICE == "cuda":
        if not hasattr(pipe.transformer, '_orig_mod'):  # Check if not already compiled
            try:
                print("⏳ Compiling model with torch.compile (first time takes 10-15 min)...")
                pipe.transformer = torch.compile(pipe.transformer, mode="reduce-overhead", fullgraph=True)
                print("✓ Model compiled successfully")
            except Exception as e:
                print(f"⚠ torch.compile failed: {e}")

    # Use GPU for generator if available
    generator_device = DEVICE if DEVICE == "cuda" else "cpu"
    if seed == -1:
        generator = torch.Generator(device=generator_device).manual_seed(torch.seed())
    else:
        generator = torch.Generator(device=generator_device).manual_seed(int(seed))

    print(f"Generating: {prompt}")

    try:
        # Check if we have an input image (editing mode)
        if input_image is not None:
            # Convert to PIL if needed
            if not isinstance(input_image, Image.Image):
                input_image = Image.fromarray(input_image)

            # Choose dimensions based on preserve_dimensions checkbox
            if preserve_dimensions:
                w, h = input_image.size
            else:
                w, h = int(width), int(height)

            image = pipe(
                image=input_image,
                prompt=prompt,
                width=w,
                height=h,
                guidance_scale=float(guidance_scale),
                num_inference_steps=4,
                generator=generator
            ).images[0]
        else:
            # Text-to-image mode (image=None)
            image = pipe(
                image=None,
                prompt=prompt,
                width=int(width),
                height=int(height),
                guidance_scale=float(guidance_scale),
                num_inference_steps=4,
                generator=generator
            ).images[0]

        return image, "✅ Done!"
    except Exception as e:
        return None, f"❌ Error: {e}"

# Gradio Interface
with gr.Blocks(title="FLUX.2-klein-4B Generator") as app:
    gr.Markdown("# 🎨 FLUX.2-klein-4B Image Generator & Editor")
    gr.Markdown("**Text-to-Image**: Leave input image empty | **Edit Mode**: Upload an image")
    
    with gr.Row():
        with gr.Column():
            prompt_input = gr.Textbox(
                label="Prompt", 
                placeholder="Describe the image you want or the edit to apply...", 
                lines=3
            )
            
            input_image = gr.Image(
                label="Input Image (optional - for editing)",
                type="pil"
            )

            preserve_dims_checkbox = gr.Checkbox(
                label="Preserve original image dimensions",
                value=True,
                info="When editing an image, use its original size instead of slider values"
            )

            with gr.Row():
                width_slider = gr.Slider(
                    minimum=256, maximum=2048, step=64, value=1024, label="Width"
                )
                height_slider = gr.Slider(
                    minimum=256, maximum=2048, step=64, value=1024, label="Height"
                )

            guidance_slider = gr.Slider(
                minimum=1.0, maximum=20.0, step=0.5, value=3.5, label="Guidance Scale"
            )

            gr.Markdown("💡 **Note**: Distilled model uses fixed 4-step inference for optimal speed")

            seed_input = gr.Number(value=-1, label="Seed (-1 for random)", precision=0)

            torch_compile_checkbox = gr.Checkbox(
                label="Enable torch.compile (30-50% faster)",
                value=False,
                info="⚠️ First generation takes 10-15 min for warmup, then much faster"
            )

            generate_btn = gr.Button("🚀 Generate / Edit", variant="primary")
            
        with gr.Column():
            output_image = gr.Image(label="Generated Image", type="pil")
            status_text = gr.Markdown("Ready")

    generate_btn.click(
        fn=generate_image,
        inputs=[prompt_input, input_image, preserve_dims_checkbox, width_slider, height_slider, guidance_slider, seed_input, torch_compile_checkbox],
        outputs=[output_image, status_text]
    )

if __name__ == "__main__":
    app.launch(share=False)

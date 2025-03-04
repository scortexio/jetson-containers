# mlc

> [`CONTAINERS`](#user-content-containers) [`IMAGES`](#user-content-images) [`RUN`](#user-content-run) [`BUILD`](#user-content-build)


Container for [MLC LLM](https://github.com/mlc-ai/mlc-llm) project using Apache TVM Unity with CUDA, cuDNN, CUTLASS, FasterTransformer, and FlashAttention-2 kernels.

### Model Quantization

First, download the original HF Transformers version of the model that you want to quantize with MLC, and symbolically link it under `/data/models/mlc/dist/models` so that MLC can find it properly:

```bash
./run.sh --env HUGGINGFACE_TOKEN=<YOUR-ACCESS-TOKEN> $(./autotag mlc) /bin/bash -c '\
  ln -s $(huggingface-downloader meta-llama/Llama-2-7b-chat-hf) /data/models/mlc/dist/models/Llama-2-7b-chat-hf'
```

> [!NOTE]  
> If you're quantizing Llava, you need to change `"model_type": "llava"` to `"model_type": "llama"` in the original model's [`config.json`](https://huggingface.co/liuhaotian/llava-v1.5-7b/blob/main/config.json) version of the model (you can patch this locally after it's been downloaded under `/data/models/huggingface`)

Then perform W4A16 quantization on the model:

```bash
./run.sh $(./autotag mlc) \
  python3 -m mlc_llm.build \
    --model Llama-2-7b-chat-hf \
    --quantization q4f16_ft \
    --artifact-path /data/models/mlc/dist \
    --max-seq-len 4096 \
    --target cuda \
    --use-cuda-graph \
    --use-flash-attn-mqa
```

In this example, the quantized model and its runtime will be saved under `/data/models/mlc/dist/Llama-2-7b-chat-hf-q4f16_ft`

### Benchmarks

To benchmark the quantized model, run the [`benchmark.py`](benchmark.py) script:

```bash
./run.sh $(./autotag mlc) \
  python3 /opt/mlc-llm/benchmark.py \
    --model /data/models/mlc/dist/Llama-2-7b-chat-hf-q4f16_ft/params \
    --prompt /data/prompts/completion_16.json \
    --max-new-tokens 128
```

The `--prompt` file used controls the number of input tokens (context length) - there are generated prompt sequences under `/data/prompts` for up to 4096 tokens.  The `--max-new-tokens` argument specifies how many output tokens the model generates for each prompt.

```
AVERAGE OVER 10 RUNS:
/data/models/mlc/dist/Llama-2-7b-chat-hf-q4f16_ft/params:  prefill_time 0.027 sec, prefill_rate 582.8 tokens/sec, decode_time 2.986 sec, decode_rate 42.9 tokens/sec
```

The prefill time is how long the model takes to process the input context before it can start generating output tokens.  The decode rate is the speed at which it generates output tokens.  These results are averaged over the number of prompts, minus the first prompt as a warm-up.
<details open>
<summary><b><a id="containers">CONTAINERS</a></b></summary>
<br>

| **`mlc:dev`** | |
| :-- | :-- |
| &nbsp;&nbsp;&nbsp;Builds | [![`mlc-dev_jp51`](https://img.shields.io/github/actions/workflow/status/dusty-nv/jetson-containers/mlc-dev_jp51.yml?label=mlc-dev:jp51)](https://github.com/dusty-nv/jetson-containers/actions/workflows/mlc-dev_jp51.yml) |
| &nbsp;&nbsp;&nbsp;Requires | `L4T >=34.1.0` |
| &nbsp;&nbsp;&nbsp;Dependencies | [`build-essential`](/packages/build-essential) [`cuda`](/packages/cuda/cuda) [`cudnn`](/packages/cuda/cudnn) [`python`](/packages/python) [`tensorrt`](/packages/tensorrt) [`numpy`](/packages/numpy) [`cmake`](/packages/cmake/cmake_pip) [`onnx`](/packages/onnx) [`pytorch`](/packages/pytorch) [`torchvision`](/packages/pytorch/torchvision) [`huggingface_hub`](/packages/llm/huggingface_hub) [`rust`](/packages/rust) [`transformers`](/packages/llm/transformers) |
| &nbsp;&nbsp;&nbsp;Dockerfile | [`Dockerfile`](Dockerfile) |
| &nbsp;&nbsp;&nbsp;Images | [`dustynv/mlc:dev-r35.3.1`](https://hub.docker.com/r/dustynv/mlc/tags) `(2023-10-30, 9.0GB)` |
| &nbsp;&nbsp;&nbsp;Notes | [mlc-ai/mlc-llm](https://github.com/mlc-ai/mlc-llm/tree/11daf9a6ef514660e1c97da83057c84e629a1aa4) commit SHA [`11daf9a6ef514660e1c97da83057c84e629a1aa4`](https://github.com/mlc-ai/mlc-llm/tree/11daf9a6ef514660e1c97da83057c84e629a1aa4) |

| **`mlc:9bf5723`** | |
| :-- | :-- |
| &nbsp;&nbsp;&nbsp;Aliases | `mlc` |
| &nbsp;&nbsp;&nbsp;Builds | [![`mlc-9bf5723_jp60`](https://img.shields.io/github/actions/workflow/status/dusty-nv/jetson-containers/mlc-9bf5723_jp60.yml?label=mlc-9bf5723:jp60)](https://github.com/dusty-nv/jetson-containers/actions/workflows/mlc-9bf5723_jp60.yml) |
| &nbsp;&nbsp;&nbsp;Requires | `L4T >=34.1.0` |
| &nbsp;&nbsp;&nbsp;Dependencies | [`build-essential`](/packages/build-essential) [`cuda`](/packages/cuda/cuda) [`cudnn`](/packages/cuda/cudnn) [`python`](/packages/python) [`tensorrt`](/packages/tensorrt) [`numpy`](/packages/numpy) [`cmake`](/packages/cmake/cmake_pip) [`onnx`](/packages/onnx) [`pytorch`](/packages/pytorch) [`torchvision`](/packages/pytorch/torchvision) [`huggingface_hub`](/packages/llm/huggingface_hub) [`rust`](/packages/rust) [`transformers`](/packages/llm/transformers) |
| &nbsp;&nbsp;&nbsp;Dependants | [`local_llm`](/packages/llm/local_llm) |
| &nbsp;&nbsp;&nbsp;Dockerfile | [`Dockerfile`](Dockerfile) |
| &nbsp;&nbsp;&nbsp;Notes | [mlc-ai/mlc-llm](https://github.com/mlc-ai/mlc-llm/tree/9bf5723) commit SHA [`9bf5723`](https://github.com/mlc-ai/mlc-llm/tree/9bf5723) |

</details>

<details open>
<summary><b><a id="images">CONTAINER IMAGES</a></b></summary>
<br>

| Repository/Tag | Date | Arch | Size |
| :-- | :--: | :--: | :--: |
| &nbsp;&nbsp;[`dustynv/mlc:dev-r35.3.1`](https://hub.docker.com/r/dustynv/mlc/tags) | `2023-10-30` | `arm64` | `9.0GB` |
| &nbsp;&nbsp;[`dustynv/mlc:r35.2.1`](https://hub.docker.com/r/dustynv/mlc/tags) | `2023-10-30` | `arm64` | `9.0GB` |
| &nbsp;&nbsp;[`dustynv/mlc:r35.3.1`](https://hub.docker.com/r/dustynv/mlc/tags) | `2023-11-05` | `arm64` | `8.9GB` |
| &nbsp;&nbsp;[`dustynv/mlc:r35.4.1`](https://hub.docker.com/r/dustynv/mlc/tags) | `2023-09-19` | `arm64` | `8.9GB` |

> <sub>Container images are compatible with other minor versions of JetPack/L4T:</sub><br>
> <sub>&nbsp;&nbsp;&nbsp;&nbsp;• L4T R32.7 containers can run on other versions of L4T R32.7 (JetPack 4.6+)</sub><br>
> <sub>&nbsp;&nbsp;&nbsp;&nbsp;• L4T R35.x containers can run on other versions of L4T R35.x (JetPack 5.1+)</sub><br>
</details>

<details open>
<summary><b><a id="run">RUN CONTAINER</a></b></summary>
<br>

To start the container, you can use the [`run.sh`](/docs/run.md)/[`autotag`](/docs/run.md#autotag) helpers or manually put together a [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) command:
```bash
# automatically pull or build a compatible container image
./run.sh $(./autotag mlc)

# or explicitly specify one of the container images above
./run.sh dustynv/mlc:r35.3.1

# or if using 'docker run' (specify image and mounts/ect)
sudo docker run --runtime nvidia -it --rm --network=host dustynv/mlc:r35.3.1
```
> <sup>[`run.sh`](/docs/run.md) forwards arguments to [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) with some defaults added (like `--runtime nvidia`, mounts a `/data` cache, and detects devices)</sup><br>
> <sup>[`autotag`](/docs/run.md#autotag) finds a container image that's compatible with your version of JetPack/L4T - either locally, pulled from a registry, or by building it.</sup>

To mount your own directories into the container, use the [`-v`](https://docs.docker.com/engine/reference/commandline/run/#volume) or [`--volume`](https://docs.docker.com/engine/reference/commandline/run/#volume) flags:
```bash
./run.sh -v /path/on/host:/path/in/container $(./autotag mlc)
```
To launch the container running a command, as opposed to an interactive shell:
```bash
./run.sh $(./autotag mlc) my_app --abc xyz
```
You can pass any options to [`run.sh`](/docs/run.md) that you would to [`docker run`](https://docs.docker.com/engine/reference/commandline/run/), and it'll print out the full command that it constructs before executing it.
</details>
<details open>
<summary><b><a id="build">BUILD CONTAINER</b></summary>
<br>

If you use [`autotag`](/docs/run.md#autotag) as shown above, it'll ask to build the container for you if needed.  To manually build it, first do the [system setup](/docs/setup.md), then run:
```bash
./build.sh mlc
```
The dependencies from above will be built into the container, and it'll be tested during.  See [`./build.sh --help`](/jetson_containers/build.py) for build options.
</details>

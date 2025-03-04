# faiss_lite

> [`CONTAINERS`](#user-content-containers) [`IMAGES`](#user-content-images) [`RUN`](#user-content-run) [`BUILD`](#user-content-build)

<details open>
<summary><b><a id="containers">CONTAINERS</a></b></summary>
<br>

| **`faiss:lite`** | |
| :-- | :-- |
| &nbsp;&nbsp;&nbsp;Builds | [![`faiss-lite_jp51`](https://img.shields.io/github/actions/workflow/status/dusty-nv/jetson-containers/faiss-lite_jp51.yml?label=faiss-lite:jp51)](https://github.com/dusty-nv/jetson-containers/actions/workflows/faiss-lite_jp51.yml) |
| &nbsp;&nbsp;&nbsp;Requires | `L4T >=32.6` |
| &nbsp;&nbsp;&nbsp;Dependencies | [`build-essential`](/packages/build-essential) [`cuda`](/packages/cuda/cuda) [`python`](/packages/python) [`numpy`](/packages/numpy) [`cmake`](/packages/cmake/cmake_pip) [`faiss:main`](/packages/vectordb/faiss) [`cuda-python`](/packages/cuda/cuda-python) [`cudnn`](/packages/cuda/cudnn) [`tensorrt`](/packages/tensorrt) [`onnx`](/packages/onnx) [`pytorch`](/packages/pytorch) |
| &nbsp;&nbsp;&nbsp;Dependants | [`nanodb`](/packages/vectordb/nanodb) |
| &nbsp;&nbsp;&nbsp;Dockerfile | [`Dockerfile`](Dockerfile) |
| &nbsp;&nbsp;&nbsp;Images | [`dustynv/faiss:lite-r35.2.1`](https://hub.docker.com/r/dustynv/faiss/tags) `(2023-12-11, 6.4GB)`<br>[`dustynv/faiss:lite-r35.3.1`](https://hub.docker.com/r/dustynv/faiss/tags) `(2023-11-05, 6.4GB)`<br>[`dustynv/faiss:lite-r35.4.1`](https://hub.docker.com/r/dustynv/faiss/tags) `(2023-12-12, 6.4GB)` |

</details>

<details open>
<summary><b><a id="run">RUN CONTAINER</a></b></summary>
<br>

To start the container, you can use the [`run.sh`](/docs/run.md)/[`autotag`](/docs/run.md#autotag) helpers or manually put together a [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) command:
```bash
# automatically pull or build a compatible container image
./run.sh $(./autotag faiss_lite)

# or if using 'docker run' (specify image and mounts/ect)
sudo docker run --runtime nvidia -it --rm --network=host faiss_lite:35.2.1

```
> <sup>[`run.sh`](/docs/run.md) forwards arguments to [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) with some defaults added (like `--runtime nvidia`, mounts a `/data` cache, and detects devices)</sup><br>
> <sup>[`autotag`](/docs/run.md#autotag) finds a container image that's compatible with your version of JetPack/L4T - either locally, pulled from a registry, or by building it.</sup>

To mount your own directories into the container, use the [`-v`](https://docs.docker.com/engine/reference/commandline/run/#volume) or [`--volume`](https://docs.docker.com/engine/reference/commandline/run/#volume) flags:
```bash
./run.sh -v /path/on/host:/path/in/container $(./autotag faiss_lite)
```
To launch the container running a command, as opposed to an interactive shell:
```bash
./run.sh $(./autotag faiss_lite) my_app --abc xyz
```
You can pass any options to [`run.sh`](/docs/run.md) that you would to [`docker run`](https://docs.docker.com/engine/reference/commandline/run/), and it'll print out the full command that it constructs before executing it.
</details>
<details open>
<summary><b><a id="build">BUILD CONTAINER</b></summary>
<br>

If you use [`autotag`](/docs/run.md#autotag) as shown above, it'll ask to build the container for you if needed.  To manually build it, first do the [system setup](/docs/setup.md), then run:
```bash
./build.sh faiss_lite
```
The dependencies from above will be built into the container, and it'll be tested during.  See [`./build.sh --help`](/jetson_containers/build.py) for build options.
</details>

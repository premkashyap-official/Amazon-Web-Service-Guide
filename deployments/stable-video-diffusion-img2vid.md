# Stable Video Diffusion Image2Video Guide

This guide outlines the steps to set up and use the Stable Video Diffusion model for creating videos from images. The instructions include pulling the necessary Docker image, using Python code to interact with the model, and making REST API requests.

## Pull the Docker Image

To start, pull the Docker image that contains the preconfigured environment for Stable Video Diffusion.

```bash
docker run -d -p 5000:5000 --gpus=all saipavan044/stable-img2video-xt:latest
```

- **`-d`**: Runs the container in detached mode.
- **`-p 5000:5000`**: Maps port 5000 of the host to port 5000 of the container.
- **`--gpus=all`**: Enables GPU acceleration for the container.

---

## Python Code to Generate Video from Image

The following Python script converts an image into a video using the Stable Video Diffusion model. The script encodes the image into a base64 string, sends it to the model via an HTTP POST request, and then decodes the base64-encoded video returned by the model.

```python
import base64
import json
import requests
import os

def save_base64_video(base64_data, output_file_path):
    """Saves base64-encoded video data to a file."""
    video_data = base64.b64decode(base64_data)
    with open(output_file_path, 'wb') as video_file:
        video_file.write(video_data)
    print(f"Video saved as {output_file_path}")

def image_to_base64(image_path):
    """Converts an image to a base64-encoded string."""
    with open(image_path, "rb") as image_file:
        base64_encoded = base64.b64encode(image_file.read()).decode('utf-8')
        return f"data:image/jpeg;base64,{base64_encoded}"

try:
    image_path = "zoo.jpg"
    base64_image = image_to_base64(image_path)

    url = "http://206.1.53.31/predictions"
    payload = json.dumps({
        "input": {
            "image": base64_image,
            "width": 576,
            "height": 1024,
            "num_frames": 25,
            "cache_interval": 3,
            "cache_branch_id": 3,
            "enable_deepcache": True,
            "decode_chunk_size": 8,
            "num_inference_steps": 50
        }
    })
    headers = {
        'Content-Type': 'application/json'
    }
    response = requests.post(url, headers=headers, data=payload)
    response_json = response.json()
    
    base64_video = response_json.get("output", [None])[0]
    if base64_video and base64_video.startswith("data:video/mp4;base64,"):
        base64_video_data = base64_video.split("data:video/mp4;base64,")[1]
        output_dir = "output_videos"
        os.makedirs(output_dir, exist_ok=True)
        output_file_path = os.path.join(output_dir, "output_video.mp4")
        save_base64_video(base64_video_data, output_file_path)
    else:
        print("No valid base64 video data found in response.")

except Exception as e:
    print(f"An error occurred: {e}")
```

### Code Explanation

- **`save_base64_video()`**: Saves the decoded video data to a file.
- **`image_to_base64()`**: Converts the input image to a base64 string to prepare it for the API request.
- **`requests.post()`**: Sends the image to the server for video generation and processes the response.

### Parameters in the Payload

- **`image`**: Base64-encoded string of the image to be converted.
- **`width`**: Width of the output video.
- **`height`**: Height of the output video.
- **`num_frames`**: Number of frames in the output video.
- **`cache_interval`**: Interval between frames for caching.
- **`cache_branch_id`**: Identifier for the caching branch.
- **`enable_deepcache`**: Boolean to enable deep caching.
- **`decode_chunk_size`**: Size of the chunk for decoding.
- **`num_inference_steps`**: Number of steps for inference.

---

## REST API Request Example

If you prefer making direct API requests, here is an example of how to structure the request body:

### Endpoint

```plaintext
POST http://206.1.53.31/predictions
```

### JSON Body

```json
{
    "input": {
        "image": "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
        "width": 576,
        "height": 1024,
        "num_frames": 25,
        "cache_interval": 3,
        "cache_branch_id": 3,
        "enable_deepcache": true,
        "decode_chunk_size": 8,
        "num_inference_steps": 50
    }
}
```

Replace the image URL with your own or use a base64-encoded string as shown in the Python example. Adjust the parameters to fit your specific needs.

### Response

The response from the server will include a base64-encoded video that can be decoded and saved using the Python script provided.

---

## cURL Command for API Request

You can use the following `curl` command to send a request to the Stable Video Diffusion model's API and receive a base64-encoded video in response:

```bash
curl -X POST http://206.1.53.31/predictions \
-H "Content-Type: application/json" \
-d '{
    "input": {
        "image": "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
        "width": 576,
        "height": 1024,
        "num_frames": 25,
        "cache_interval": 3,
        "cache_branch_id": 3,
        "enable_deepcache": true,
        "decode_chunk_size": 8,
        "num_inference_steps": 50
    }
}'
```

### Explanation of the Command:

- **`-X POST`**: Specifies that this is a POST request.
- **`http://206.1.53.31/predictions`**: The endpoint where the request is sent.
- **`-H "Content-Type: application/json"`**: Sets the `Content-Type` header to `application/json`, indicating that the request body is in JSON format.
- **`-d`**: Specifies the data to be sent in the request body.

### Response Handling

The server's response will include the base64-encoded video string. You can handle this response within a shell script or pipe the output directly to another tool for processing.

### Saving the Response to a File

If you'd like to save the response to a file for further processing:

```bash
curl -X POST http://206.1.53.31/predictions \
-H "Content-Type: application/json" \
-d '{
    "input": {
        "image": "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
        "width": 576,
        "height": 1024,
        "num_frames": 25,
        "cache_interval": 3,
        "cache_branch_id": 3,
        "enable_deepcache": true,
        "decode_chunk_size": 8,
        "num_inference_steps": 50
    }
}' -o response.json
```

This command saves the server's JSON response to `response.json`, which you can then process to extract the base64 video data.

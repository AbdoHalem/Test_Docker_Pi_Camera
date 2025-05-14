### Dockerfile for Minimal GStreamer + Python on RPi4 (aarch64)
# Based on Ubuntu 22.04
FROM ubuntu:22.04

# Install Python, GStreamer core, and all major plugins via APT
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3 python3-pip python3-gi python3-gst-1.0 gir1.2-gstreamer-1.0 \
        gstreamer1.0-tools \
        gst-plugins-base \
        gst-plugins-good \
        gst-plugins-bad \
        gst-plugins-ugly \
        gstreamer1.0-libav \
        gstreamer1.0-vaapi \
    && rm -rf /var/lib/apt/lists/*

# Optional: OpenCV and PiCamera libs in Python
RUN pip3 install --no-cache-dir opencv-python picamera2

# Create app directory
WORKDIR /app

# Default command
CMD ["bash"]

# Usage:
# docker build --platform linux/arm64 -f Dockerfile -t my-gst-py:arm64 .
# docker run --rm -it \
#    --device /dev/video0:/dev/video0 \
#    --device /dev/vchiq:/dev/vchiq \
#    --privileged \
#    my-gst-py:arm64 bash

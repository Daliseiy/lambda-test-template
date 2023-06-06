FROM ubuntu:20.04 AS builder-image

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y build-essential  python3.9 python3.9-dev python3.9-venv python3-pip python3-wheel ffmpeg git && \
	apt-get clean && rm -rf /var/lib/apt/lists/*


COPY requirements.txt .


RUN pip3 install setuptools-rust

RUN pip3 install --no-cache-dir wheel
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .


EXPOSE 5000


ENV PYTHONUNBUFFERED=1



CMD ["uvicorn", "app:app", "--host=0.0.0.0", "--port=5000"]




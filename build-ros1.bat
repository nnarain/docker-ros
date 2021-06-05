docker buildx build --platform linux/amd64,linux/arm64 -f ros1\base\Dockerfile    -t nnarain/ros-base:latest     --no-cache --output type=registry .
docker buildx build --platform linux/amd64             -f ros1\desktop\Dockerfile -t nnarain/ros-desktop:latest  --no-cache --output type=registry .
docker buildx build --platform linux/amd64             -f ros1\dev\Dockerfile     -t nnarain/ros-dev:latest      --no-cache --output type=registry .

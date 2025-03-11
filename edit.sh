FROM=$(realpath "$1")
TO=$(realpath "$2")

# Check if the provided argument is a valid directory
if [ ! -d "$FROM" ]; then
    echo "Error: '$FROM' is not a valid directory."
    exit 1
fi
if [ ! -d "$TO" ]; then
    echo "Error: '$TO' is not a valid directory."
    exit 1
fi

# Find the most recent file in the directory
FROM_PATH=$FROM/$(ls -t $FROM | head -n 1)
FROM_NAME=$(basename "$FROM_PATH")

# Check if the directory is empty
if [ -z "$FROM_PATH" ]; then
    echo "No files found in '$FROM_PATH'"
    exit 2
else
    echo "Most recent file: $FROM_NAME"
fi

FROM_INTERNAL="/app/$FROM_NAME"
TO_INTERNAL="/app/output/auto-$FROM_NAME"

docker run \
  --rm \
  -u$(id -u):$(id -g) \
  -v /etc/passwd:/etc/passwd -v /etc/group:/etc/group \
  -v $FROM_PATH:$FROM_INTERNAL \
  -v $TO:/app/output \
  auto-editor \
  --no-open --edit audio:0.02 -m 0.4s,0.4s -o $TO_INTERNAL $FROM_INTERNAL

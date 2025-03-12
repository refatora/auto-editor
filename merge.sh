FROM=$(realpath "$1")

# Check if the provided argument is a valid directory
if [ ! -d "$FROM" ]; then
    echo "Error: '$FROM' is not a valid directory."
    exit 1
fi

ls -l $FROM | grep -v 'total ' | awk '{print "file ""\047""/app/" $9 "\047"}' > /tmp/merge.txt

docker run \
  --rm \
  -u$(id -u):$(id -g) \
  -v /etc/passwd:/etc/passwd -v /etc/group:/etc/group \
  -v /tmp/merge.txt:/tmp/merge.txt \
  -v $FROM:/app \
  ffmpeg \
  -y -f concat -safe 0 -i /tmp/merge.txt -c copy /app/auto-merge.mp4

rm /tmp/merge.txt

FROM alpine:latest

# Set working directory
WORKDIR /root/

# Copy the pre-built static binary from your local build directory
# This assumes you have already run the static build locally.
COPY trace /usr/local/bin/trace

LABEL description="Minimal runtime-only Docker image for trace"

# Set the entrypoint to the tool
ENTRYPOINT ["/usr/local/bin/trace"]
CMD ["--help"]

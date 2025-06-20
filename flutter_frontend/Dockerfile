# Use official Flutter image
FROM cirrusci/flutter:stable

# Set working directory inside container
WORKDIR /app

# Copy all files into container
COPY . .

# Get dependencies
RUN flutter pub get

# Expose web port
EXPOSE 5555

# Run the app on web server
CMD ["flutter", "run", "-d", "web-server", "--web-hostname=0.0.0.0", "--web-port=5555"]

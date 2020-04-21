# Step 1:
# Build image and add a descriptive tag
docker build --tag=victorrosario/capstone-project .

# Step 2: 
# List docker images
docker image ls

# Step 3: 
# Run create-react-app
docker run -p 5000:80 victorrosario/capstone-project

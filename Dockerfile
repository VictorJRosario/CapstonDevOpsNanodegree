## Step 1
# Choose image
FROM node:8 as react-build

## Step 2
# Create working directory
WORKDIR /app

## Step 3
# Copy dependencies
COPY . ./

## Step 4
# Run yarn & build
RUN npm install -g yarn==1.22.4
RUN yarn build

### Second Process
## Step 1
# Using nginx
FROM nginx:alpine

## Step 2
# Copy dependencies
COPY --from=react-build /app/build /usr/share/nginx/html

## Step 3
# Expose port
EXPOSE 80

## Step 4
# Run commands
CMD ["nginx", "-g", "daemon off;"]
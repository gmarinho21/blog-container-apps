docker build -t blog-gabriel-app:lastest .

docker run -d -p 80:80 blog-gabriel-app:lastest

az login

# Cria o Resource Group
az group create --name containerapplab03 --location eastus

# Create container registry

az acr create --resouce-group containerapplab03 --name bloggabrielacr --sku Basic

# Login to ACR
az acr login --name bloggabrielacr

# Tag the image
docker tag blog-gabriel-app:lastest bloggabrielacr.azurecr.io/blog-gabriel-app:lastest

# Push the image
docker push bloggabrielacr.azurecr.io/blog-gabriel-app:lastest

# Create Environment Container app
az containerapp env create --name blog-gabriel-env --resource-group containerapplab03 --location eastus

# Create container app
az containerapp create --name blog-gabriel-app --resouce-group containerapplab03 --image blog-gabriel-app:lastest --environment blog-gabriel-env --ingress external --target-port 80 --registry-username "" --registry-password "" --registry-server ""
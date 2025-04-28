# Blog Containerizado - Aplicação

Este projeto é uma aplicação de blog simples que permite aos usuários criar, visualizar e comentar em postagens. A aplicação é containerizada utilizando Docker e implantada no Azure Container Apps.

## Estrutura do Projeto

├── Dockerfile 
├── scripts.ps1 
├── blog/ 
│ ├── html/ 
│ │ ├── index.html 
│ │ ├── create-post.html 
│ │ └── post.html


## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes itens instalados e configurados:

- [Docker](https://www.docker.com/)
- [Azure CLI](https://learn.microsoft.com/pt-br/cli/azure/install-azure-cli)
- Uma conta ativa no [Microsoft Azure](https://azure.microsoft.com/)

## Passos para Implantação

### 1. Construir a Imagem Docker
Construa a imagem Docker para a aplicação:
```bash
docker build -t blog-gabriel-app:lastest .

### 2. Construir a Imagem Docker
Execute o container localmente para testar:
```bash
docker run -d -p 80:80 blog-gabriel-app:lastest

### 3. Login no Azure
Faça login na sua conta Azure:
```bash
az login

### 4. Criar um Resource Group
Crie um Resource Group no Azure:
```bash
az group create --name containerapplab03 --location eastus

### 5. Criar um Registro de Container (ACR)
Crie um Azure Container Registry (ACR):
```bash
az acr create --resouce-group containerapplab03 --name bloggabrielacr --sku Basic

### 6. Login no ACR
Faça login no ACR:
```bash
az acr login --name "nome do blog"

### 7. Tag e Push da Imagem para o ACR
Adicione uma tag à imagem e envie-a para o ACR:
```bash
docker tag blog-gabriel-app:lastest bloggabrielacr.azurecr.io/blog-gabriel-app:lastest
docker push bloggabrielacr.azurecr.io/blog-gabriel-app:lastest

### 8. Criar o Ambiente do Azure Container Apps
Crie o ambiente para o Azure Container Apps:
```bash
az containerapp env create --name blog-gabriel-env --resource-group containerapplab03 --location eastus

### 9. Criar o Azure Container App
Crie o container app no Azure:
```bash
az containerapp create --name blog-gabriel-app --resouce-group containerapplab03 --image bloggabrielacr.azurecr.io/blog-gabriel-app:lastest --environment blog-gabriel-env --ingress external --target-port 80 --registry-username "<USERNAME>" --registry-password "<PASSWORD>" --registry-server bloggabrielacr.azurecr.io
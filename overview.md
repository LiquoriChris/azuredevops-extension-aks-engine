# AKS-Engine Azure DevOps Extensiom

AKS-Engine deployment tasks in build and release pipelines.

## Important Note: The azure-cli is required on the build server for the deploy, scale, and upgrade aks-engine tasks to be run.

## How it works  

* AKS-Engine Installer

Installs the lastest or specified version of AKS-Engine. The engine will be installed in the built in Agent Tools directory (Agent.ToolsDirectory)

* AKS-Engine generate  

The aks-engine generate task will create the necessary files based on the api-model json file provided in the task. The task will provide a field to store the output after the generate command has been run. The default authentication method for this task is client_secret, at which the client id and client secret will need to be provided.

* AKS-Engine deploy  

The aks-engine deploy task will deploy the given api model into an Azure subscription. The default authentication method for this task is client_secret, at which the client id and client secret will need to be provided.

* AKS-Engine scale  

The aks-engine scale task can scale a Kubernetes cluster out or down. The default authentication method for this task is client_secret, at which the client id and client secret will need to be provided.

* AKS-Engine upgrade  

The aks-engine upgrade task can upgrade the kubernetes version of a cluster. The default authentication method for this task is client_secret, at which the client id and client secret will need to be provided.
---
title: "Guia Rápido para Iniciar com MicroK8s"
date: 2025-03-08T20:22:31.000-03:00
tags: [DevOps, kubernetes]
author: Roberta
featured_image: "featured.jpg"
---
Guia simples e prático de como iniciar no mundo do Kubernetes com MicroK8s.

## **1\. O que é o MicroK8s?**

O **MicroK8s** é uma distribuição leve e otimizada do **Kubernetes** , projetada para facilitar o desenvolvimento local, testes e até mesmo ambientes de produção em dispositivos pequenos, como o Raspberry Pi.

Ele é interessante porque:

  * É **fácil de instalar** e roda como um único snap.
  * Consome **menos recursos** do que um cluster Kubernetes completo.
  * Tem suporte nativo a **add-ons** úteis como Istio, MetalLB, DNS e outros.



* * *

## **2\. Instalando o MicroK8s**

O MicroK8s é distribuído via **Snap** , então basta rodar:
    
    
    sudo snap install microk8s --classic
    

Se quiser instalar uma versão específica, por exemplo, a 1.30:
    
    
    sudo snap install microk8s --classic --channel=1.30/stable
    

Para garantir que sua conta de usuário tenha permissão de administrar o cluster:
    
    
    sudo usermod -aG microk8s $USER
    newgrp microk8s  # Aplica as mudanças sem precisar reiniciar
    

Se quiser ativar o autocompletar no Zsh:
    
    
    echo "source <(microk8s kubectl completion zsh)" >> ~/.zshrc
    source ~/.zshrc
    

* * *

## **3\. Iniciando o MicroK8s**

Após a instalação, verifique o status:
    
    
    microk8s status
    

Caso não esteja rodando, inicie o serviço:
    
    
    microk8s start
    

Para parar:
    
    
    microk8s stop
    

* * *

## **4\. Usando o MicroK8s**

O MicroK8s já vem com o **kubectl** integrado, então você pode rodar:
    
    
    microk8s kubectl get nodes
    

Se quiser facilitar, pode criar um alias:
    
    
    alias kubectl="microk8s kubectl"
    

Agora, para ver os pods:
    
    
    kubectl get pods -A
    

* * *

## **5\. Ativando Add-ons**

O MicroK8s permite ativar funcionalidades adicionais rapidamente. Alguns úteis:

**MetalLB (Load Balancer para ambientes locais)** :
    
    
    microk8s enable metallb:192.168.1.100-192.168.1.200
    

**Dashboard do Kubernetes** :
    
    
    microk8s enable dashboard
    

Para acessar:
    
    
    microk8s kubectl proxy
    

E abrir no navegador: [http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/?ref=blog.robertabrandao.com.br)

**DNS (Essencial para resolução de serviços internos)** :
    
    
    microk8s enable dns
    

* * *

## **6\. Criando um Deployment**

Crie um arquivo `deployment.yaml`:
    
    
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx:latest
            ports:
            - containerPort: 80
    

Aplicando no cluster:
    
    
    microk8s kubectl apply -f deployment.yaml
    

Verificando:
    
    
    microk8s kubectl get pods
    

* * *

## **7\. Expondo um Serviço**

Se quiser acessar o Nginx externamente, crie um serviço:
    
    
    microk8s kubectl expose deployment nginx-deployment --type=NodePort --port=80
    

Verifique a porta mapeada:
    
    
    microk8s kubectl get services
    

Acesse via `http://<IP_DO_NODE>:<PORTA_NODEPORT>`

Se ativou o **MetalLB** , pode criar um serviço LoadBalancer:
    
    
    microk8s kubectl expose deployment nginx-deployment --type=LoadBalancer --port=80
    

* * *

## **8\. Removendo e Reiniciando o MicroK8s**

Se quiser resetar tudo:
    
    
    microk8s reset
    

Para remover completamente:
    
    
    sudo snap remove microk8s
    

## 

---
title: "Redes no Kubernetes com Base no Tanenbaum"
date: 2025-03-02T20:58:24.000-03:00
tags: [Redes, kubernetes]
author: Roberta
featured_image: "featured.jpg.png"
---
Um guia bem prático de como começar a estudar Kubernetes baseado no livro de redes do Tanenbaum

### 1\. Fundamentos de Redes e Como Isso Impacta o K8s

**Tanenbaum** : Capítulos sobre **Camadas de Rede e Modelo OSI/TCP-IP  
No Kubernetes**: Entenda como **pods, nodes e serviços** interagem via redes virtuais.  
**O que estudar?**

  * Comunicação entre pods e nodes (CNI – Container Network Interface)
  * Namespace de rede e isolamento no Linux
  * Como o tráfego de rede é roteado dentro do cluster



**Mão na Massa**

  * Use `kubectl exec` e ip a para explorar namespaces de rede em pods
  * Teste conectividade com `ping` e `netcat` entre pods



* * *

### 2\. Endereçamento, NAT e Balanceamento de Carga

**Tanenbaum** : Capítulos sobre **Endereçamento IP, NAT e Sub-redes  
No Kubernetes**: Compreenda como **endereços IP são alocados e como NAT impacta serviços**.  
**O que estudar?**

  * Como o K8s gerencia IPs para pods (CIDR, Subnets)
  * O papel do kube-proxy na comunicação entre serviços
  * Load Balancers, NodePort e ClusterIP



**Mão na Massa**

  * Liste os IPs do cluster: `kubectl get pods -o wide`
  * Analise regras iptables/ipvs: `iptables -L -t nat`
  * Exponha um serviço como **NodePort** e teste acessibilidade



* * *

### 3\. Protocolos de Transporte: TCP, UDP e Performance

**Tanenbaum** : Capítulos sobre **Camada de Transporte e Controle de Congestionamento  
No K8S**: Escolha **TCP vs UDP** corretamente para suas aplicações.  
**O que estudar?**

  * Comunicação HTTP/gRPC em microserviços
  * Como os **Ingress Controllers** gerenciam tráfego TCP
  * O impacto de **latência e retransmissão** em redes internas do cluster



**Mão na Massa**

  * Crie um deployment e dois serviços, com UDP e outro TCP e veja as diferenças: No Yaml abaixo, temos um POD com netcat, expondo **UDP** na porta 30000 e **TCP** 30001


    
    
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: udp-tcp-server
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: udp-tcp-server
      template:
        metadata:
          labels:
            app: udp-tcp-server
        spec:
          containers:
          - name: udp-tcp-container
            image: busybox
            command: ["sh", "-c", "nc -lk -p 30000 -u & nc -lk -p 30001"]
            ports:
            - containerPort: 30000
              protocol: UDP
            - containerPort: 30001
              protocol: TCP
    
    
    
    apiVersion: v1
    kind: Service
    metadata:
      name: udp-service
    spec:
      selector:
        app: udp-tcp-server
      ports:
        - protocol: UDP
          port: 30000
          targetPort: 30000
      type: NodePort
    
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: tcp-service
    spec:
      selector:
        app: udp-tcp-server
      ports:
        - protocol: TCP
          port: 30001
          targetPort: 30001
      type: NodePort
    

Após aplicar os manifests no cluster com `kubectl apply -f arquivo.yaml`, você pode testar os serviços:
    
    
     echo "Teste UDP" | nc -u <NODE_IP> 30000
    
     echo "Teste TCP" | nc <NODE_IP> 30001

  * Simule perda de pacotes com tc e observe impacto na aplicação:
    * Modifique o deployment para usar o TC:


    
    
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: udp-tcp-server
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: udp-tcp-server
      template:
        metadata:
          labels:
            app: udp-tcp-server
        spec:
          containers:
          - name: udp-tcp-container
            image: busybox
            command: ["/bin/sh", "-c"]
            args:
              - |
                ip link set dev eth0 up;
                tc qdisc add dev eth0 root netem loss 30%;
                nc -lk -p 30000 -u & nc -lk -p 30001
            securityContext:
              capabilities:
                add: ["NET_ADMIN"]
            ports:
            - containerPort: 30000
              protocol: UDP
            - containerPort: 30001
              protocol: TCP
    

  * `tc qdisc add dev eth0 root netem loss 30%` → Simula **30% de perda de pacotes** na interface `eth0`.
  * O `securityContext.capabilities.add: ["NET_ADMIN"]` permite modificar a rede dentro do container
  * Teste UDP com perda de pacote.


    
    
    for i in {1..10}; do echo "Teste UDP $i" | nc -u <NODE_IP> 30000; sleep 1; done
    

A saída terá algumas mensagens que não serão recebidas por conta da perda simulada.

#### **Remover a perda de pacotes**

Se quiser remover a simulação, basta executar dentro do pod:
    
    
    kubectl exec -it <POD_NAME> -- sh -c "tc qdisc del dev eth0 root netem"
    

* * *

### 4\. Segurança: Firewall, Network Policies e TLS

**Tanenbaum** : Capítulos sobre **Segurança em Redes e Firewall  
No Kube**: Controle tráfego entre pods e proteja comunicação.  
**O que estudar?**

  * Como criar e aplicar **NetworkPolicies**
  * TLS Termination em Ingress Controllers
  * O impacto de **DNS Spoofing e ataques MITM** no cluster



**Mão na Massa**

  * Bloqueie o tráfego entre namespaces com NetworkPolicies
  * Configure um Ingress com **cert-manager** para TLS automático



* * *

### 5\. Monitoramento e Debug de Redes

**Tanenbaum** : Capítulos sobre **Gerenciamento de Redes  
No Kubernetes**: Ferramentas para entender **latência, logs e erros de rede**.  
**O que estudar?**

  * Logging e tracing com **ELK, Prometheus e Jaeger**
  * Inspeção de tráfego com **tcpdump, Wireshark e eBPF**



**Mão na Massa**

  * Capture tráfego de um pod: kubectl debug + tcpdump
  * Analise conexões abertas: netstat -tulnp dentro do pod



### 6\. Load Balancing no Kubernetes

**Tanenbaum** : Capítulos sobre **Balanceamento de Carga, Algoritmos de Escalonamento e Qualidade de Serviço (QoS)  
No Kubernetes**: Como **balanceadores de carga (Ingress, kube-proxy e External Load Balancers)** impactam escalabilidade e desempenho.

### 6.1. Algoritmos de Balanceamento de Carga

**O que estudar?**

  * Round-Robin, Least Connections, IP Hash, Consistent Hashing
  * Load Balancing na camada **L4 (TCP/UDP)** vs **L7 (HTTP/gRPC)**



**Mão na Massa**

  * Teste diferentes algoritmos configurando um **NGINX Ingress Controller**



### 6.2 Load Balancer no Kubernetes: Interno vs Externo

**O que estudar?**

  * Como **kube-proxy** usa iptables/ipvs para distribuir tráfego
  * Load Balancers de provedores (AWS ELB, GCP LB, MetalLB para Bare Metal)



**Mão na Massa**

  * Analise regras iptables: iptables -L -t nat
  * Configure um **MetalLB** para Kubernetes Bare Metal



### 6.3 Performance e Debugging de Load Balancers

**O que estudar?**

  * Impacto de latência, tráfego sticky sessions e TLS offloading
  * Debugging com tcpdump, nginx -T, kubectl proxy



**Mão na Massa**

  * Use **`tcpdump`** para capturar tráfego entre o balanceador e os pods
  * Habilite logs detalhados no **kube-proxy** e no Ingress Controller



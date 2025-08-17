---
title: "Problemas de recursos em PODs no Kubernetes"
date: 2025-03-02T21:16:36.000-03:00
tags: [DevOps, Redes, kubernetes]
author: Roberta
featured_image: "featured.jpg"
---
Me perguntaram bastante sobre como exemplificar a configuração incorreta de requests e limits de CPU e memória, resultando falhas em pods sendo OOMKilled ou throttled sem explicação aparente. Vamos para algumas definições bem práticas sem enrolação:

\- **OOMKilled (Out of Memory Killed)** : Ocorre quando um pod consome mais memória do que o limite definido. O Kubernetes força a finalização do container para liberar memória, podendo gerar downtime e impactar a aplicação.
    
    
    piVersion: v1
          kind: Pod
          metadata:
            name: memory-hog
          spec:
            containers:
            - name: memory-hog
              image: polinux/stress
              args: ["--vm", "1", "--vm-bytes", "500M", "--vm-hang", "1"]
              resources:
                limits:
                  memory: "200Mi"

Neste exemplo acima, o POD será finalizado rapidamente pois tentará consumir 500Mi de memória enquanto o limite está definido como 200Mi. Recomendo explorar esta falha como uma proposta de consumo de recursos com a equipe de desenvolvimento.

\- **Throttling de CPU** : Ocorre quando um pod tenta consumir mais CPU do que o limite definido, resultando em degradação do desempenho sem mensagens claras no log. O container continua rodando, mas com performance reduzida.
    
    
    apiVersion: v1
          kind: Pod
          metadata:
            name: cpu-throttled
          spec:
            containers:
            - name: cpu-throttled
              image: busybox
              command: ["sh", "-c", "while true; do echo 'Consuming CPU'; done"]
              resources:
                limits:
                  cpu: "100m" 

No exemplo acima, o POD será fortemente limitado pois está tentando consumir CPU sem restrições na camada da aplicação, mas está limitado a 100 milicores (0.1 vCPU) na infra. Recomendo testar o comportamento do healthcheck com o contexto de throttled CPU, para identificar a saúde da aplicação de maneira mais eficaz.

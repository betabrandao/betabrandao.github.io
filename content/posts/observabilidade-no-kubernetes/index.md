---
title: "Observabilidade no Kubernetes"
date: 2025-03-20T17:44:32.000-03:00
tags: [DevOps, kubernetes]
author: Roberta
featured_image: "featured.jpg"
---
Como instrumentar uma infraestrutura em MicroK8s para coleta de métricas e traces de aplicações com Grafana

O Kubernetes tornou-se uma plataforma essencial para orquestração de contêineres, e o MicroK8s é uma solução leve e fácil de usar para quem deseja rodar Kubernetes localmente ou em ambientes de desenvolvimento. No entanto, à medida que suas aplicações crescem em complexidade, a necessidade de monitoramento e observabilidade torna-se crítica. 

Vale ressaltar que Kubernetes e a observabilidade são componentes essenciais para a gestão de aplicações modernas em ambientes de nuvem, mas sua implementação pode levar a um aumento significativo nos custos se não forem gerenciados de forma eficiente. Por exemplo, o Kubernetes pode escalar automaticamente os recursos com base na demanda, o que é ótimo para garantir a disponibilidade da aplicação, mas também pode resultar em custos imprevistos. Um cluster Kubernetes que escala horizontalmente (HPA - Horizontal Pod Autoscaler) pode criar múltiplas réplicas de pods durante picos de tráfego, consumindo mais recursos de CPU, memória e armazenamento. Se esses recursos não forem otimizados ou se o dimensionamento automático for configurado de forma agressiva, a infraestrutura pode acabar utilizando mais instâncias de nuvem do que o necessário, elevando a fatura mensal.

Neste artigo, vamos explorar como instrumentar uma infraestrutura em MicroK8s para coletar métricas e traces de aplicações, utilizando o Grafana para visualização.

## Pré-requisitos

Antes de começarmos, certifique-se de que você tem o seguinte configurado:

  1. **MicroK8s instalado e configurado** : Se ainda não o fez, tenho uma publicação sobre [como começar com K8S](https://blog.robertabrandao.com.br/guia-rapido-microk8s/), ou; dê uma olhada na [documentação oficial](https://microk8s.io/?ref=blog.robertabrandao.com.br) para instalar o MicroK8s.
  2. **kubectl** : Ferramenta de linha de comando para interagir com o cluster Kubernetes, que já existe no microk8s.
  3. **Helm** : Gerenciador de pacotes para Kubernetes. Instale-o seguindo as instruções [aqui](https://helm.sh/docs/intro/install/?ref=blog.robertabrandao.com.br).



## Habilitar Add-ons no MicroK8s

O MicroK8s vem com vários add-ons que podem ser habilitados facilmente. Para nossa configuração, vamos habilitar o `metrics-server` e o `prometheus`.
    
    
    microk8s enable metrics-server
    microk8s enable prometheus
    

O `metrics-server` coleta métricas de recursos como CPU e memória, enquanto o `prometheus` é uma ferramenta de monitoramento e alerta que vai nos ajudar a coletar métricas mais detalhadas.

## Instalar o Prometheus e Grafana com Helm

Vamos usar o Helm para instalar o Prometheus e o Grafana em nosso cluster.

**Verificar a instalação:**
    
    
    kubectl get pods
    

Você deve ver pods relacionados ao Prometheus, Grafana e outros componentes em execução.

**Instalar o Prometheus:**
    
    
    helm install prometheus prometheus-community/kube-prometheus-stack
    

Este comando instala o Prometheus junto com o Grafana e outros componentes necessários.

**Adicionar o repositório Helm do Prometheus:**
    
    
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    

## Configurar o Prometheus para Coletar Métricas

O Prometheus já vem configurado para coletar métricas básicas do Kubernetes. No entanto, se você quiser coletar métricas específicas de suas aplicações, você precisará configurar o Prometheus para fazer scraping dessas métricas.

  1. **Verificar se o Prometheus está coletando métricas:** Acesse a interface do Prometheus (normalmente disponível em `http://localhost:9090` se você estiver usando port-forward) e verifique se as métricas da sua aplicação estão sendo coletadas.



**Criar um`ServiceMonitor`:**O `ServiceMonitor` é um recurso customizado que o Prometheus usa para descobrir serviços e coletar métricas. Aqui está um exemplo de como criar um `ServiceMonitor` para uma aplicação:
    
    
    apiVersion: monitoring.coreos.com/v1
    kind: ServiceMonitor
    metadata:
      name: my-app-monitor
      namespace: default
    spec:
      selector:
        matchLabels:
          app: my-app
      endpoints:
      - port: web
        interval: 30s
    

Salve este arquivo como `my-app-monitor.yaml` e aplique-o com:
    
    
    kubectl apply -f my-app-monitor.yaml
    

## Configurar o Grafana para Visualizar Métricas

O Grafana já foi instalado junto com o Prometheus. Agora, vamos configurá-lo para visualizar as métricas coletadas.

  1. **Adicionar o Prometheus como Fonte de Dados:**
     * No Grafana, vá para `Configuration` > `Data Sources`.
     * Clique em `Add data source` e selecione `Prometheus`.
     * No campo `URL`, insira `http://prometheus-operated:9090`.
     * Clique em `Save & Test`.
  2. **Criar Dashboards:** Agora que o Prometheus está configurado como fonte de dados, você pode criar dashboards para visualizar as métricas. Aqui está um exemplo de como criar um gráfico simples:
     * Vá para `Create` > `Dashboard` > `Add new panel`.
     * No campo `Metrics`, insira uma métrica do Prometheus, como `http_requests_total`.
     * Ajuste o gráfico conforme necessário e salve o dashboard.



[Acesse a documentação completa do Grafana](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/create-dashboard/?ref=blog.robertabrandao.com.br)

**Acessar o Grafana:** Para acessar o Grafana, você pode usar o port-forward:
    
    
    kubectl port-forward svc/prometheus-grafana 3000:80
    

Agora, acesse `http://localhost:3000` no seu navegador. O usuário padrão é `admin` e a senha pode ser obtida com:
    
    
    kubectl get secret prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
    

## Coletar Traces com Jaeger

Além de métricas, traces são essenciais para entender o comportamento de suas aplicações em um ambiente distribuído. Vamos usar o Jaeger para coletar traces.

  1. **Visualizar Traces no Jaeger:** Acesse a interface do Jaeger (normalmente disponível em `http://localhost:16686` se você estiver usando port-forward) e visualize os traces coletados.



**Configurar sua Aplicação para Enviar Traces:** Dependendo da linguagem e framework que você está usando, a configuração para enviar traces para o Jaeger pode variar. Aqui está um exemplo básico para uma aplicação em Node.js usando o `jaeger-client`:
    
    
    const jaeger = require('jaeger-client');
    const opentracing = require('opentracing');
    
    const config = {
      serviceName: 'my-app',
      reporter: {
        agentHost: 'jaeger-agent',
        agentPort: 6832,
      },
      sampler: {
        type: 'const',
        param: 1,
      },
    };
    
    const tracer = jaeger.initTracer(config);
    opentracing.initGlobalTracer(tracer);
    

**Instalar o Jaeger com Helm:**
    
    
    helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
    helm repo update
    helm install jaeger jaegertracing/jaeger
    

## Atente-se com os custos!

A observabilidade, que inclui a coleta de métricas, logs e traces, também pode contribuir para o aumento dos custos. Ferramentas como Prometheus, Grafana e Jaeger geram **grandes volumes de dados** , especialmente em ambientes com muitas aplicações e microsserviços. Por exemplo, armazenar métricas detalhadas de todos os pods em um cluster Kubernetes ou coletar traces de cada requisição em um sistema distribuído pode exigir um armazenamento robusto e caro. Além disso, o processamento e a análise desses dados podem consumir recursos computacionais adicionais, especialmente se forem utilizados serviços gerenciados de nuvem, como o Amazon CloudWatch, Google Cloud Operations Suite ou Azure Monitor, que cobram com base no volume de dados processados e armazenados. Sem uma política clara de retenção de dados ou filtragem de métricas menos relevantes, os custos podem sair do controle rapidamente.  
  
Referências:   
\- [https://microk8s.io](https://microk8s.io/?ref=blog.robertabrandao.com.br)  
\- [https://www.gov.br/governodig](https://www.gov.br/governodigital/pt-br/privacidade-e-seguranca/ppsi/guia_processo_gestao_dados.pdf?ref=blog.robertabrandao.com.br)[ital/pt-br/privacidade-e-seguranca/ppsi/guia_processo_gestao_dados.pdf](https://www.gov.br/governodigital/pt-br/privacidade-e-seguranca/ppsi/guia_processo_gestao_dados.pdf?ref=blog.robertabrandao.com.br)  
\- [The Observability Book](https://www.amazon.com.br/O11Y-Explained-Observability-Daniel-Salt/dp/B0CL59N64P?ref=blog.robertabrandao.com.br)  
\- [https://www.finops.org/assets/why-finance-processes-need-to-catch-up-to-finops/](https://www.finops.org/assets/why-finance-processes-need-to-catch-up-to-finops/?ref=blog.robertabrandao.com.br)

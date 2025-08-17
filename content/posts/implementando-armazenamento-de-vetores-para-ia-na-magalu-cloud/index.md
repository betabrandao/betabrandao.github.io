---
title: "Implementando Armazenamento de Vetores para IA na Magalu Cloud"
date: 2025-07-27T21:43:51.000-03:00
tags: [Data, DevOps]
author: Roberta
featured_image: "featured.jpg"
---
Este relatório foi desenvolvido em uma prova de conceito e o projeto foi inspirado no produto de S3 Vectors da AWS¹. Caso encontre algum erro técnico, gramatical ou de concordância, me avise. 

## **Introdução: A Importância do Armazenamento de Vetores para IA Moderna**

A inteligência artificial (IA) generativa está transformando a maneira como as empresas interagem com dados e clientes. No cerne dessa transformação, encontram-se os vetores e os modelos de embedding, que permitem que sistemas de IA compreendam e processem informações não estruturadas de maneira semântica. Vetores são representações numéricas densas de dados como texto, imagens, áudio e vídeo, criadas por modelos de embedding que capturam o significado e a estrutura subjacente.1 A busca vetorial, uma técnica emergente, utiliza essas representações para encontrar pontos de dados semanticamente semelhantes, comparando suas distâncias ou similaridades.1 Essa capacidade é fundamental para diversas aplicações de IA.

Entre as aplicações mais impactantes da busca vetorial, destacam-se a Geração Aumentada por Recuperação (RAG), que aprimora a precisão de Large Language Models (LLMs) ao fornecer contexto relevante.2 Além disso, a busca semântica permite encontrar conteúdo (documentos, imagens, vídeos) com base em seu significado conceitual, superando as limitações da busca por palavras-chave.2 Sistemas de recomendação também se beneficiam, oferecendo sugestões personalizadas ao identificar a similaridade semântica entre interesses de usuários e itens.2 Por fim, a busca vetorial é crucial para a memória de agentes de IA, permitindo que armazenem e recuperem contexto e histórico, melhorando sua interação e raciocínio.1

Recentemente, a Amazon Web Services (AWS) introduziu o Amazon S3 Vectors, uma inovação que oferece suporte nativo a vetores em escala dentro de seu serviço de Object Storage.1 Esta solução de armazenamento de vetores durável e de baixo custo visa simplificar o armazenamento, gerenciamento e consulta de embeddigns. A principal vantagem reside nna significativa redução de custos, especialmente para grandes volumes de dados vetoriais que não necessitam de acesso em tempo real constante.1 Essa abordagem representa uma mudança de paradigma, tornando a IA generativa mais acessível e economicamente viável. Ao ancorar o custo no armazenamento passivo, em vez de exigir bancos de dados vetoriais caros para todo o ciclo de vida do vetor, a AWS está efetivamente democratizando a capacidade de construir e escalar aplicações de IA baseadas em vastas bases de conhecimento.8 Para a Magalu Cloud, isso significa que uma solução comparável deve não apenas replicar a funcionalidade técnica, mas também oferecer uma proposição de valor de custo-benefício para ser competitiva e atraente no mercado.

## **Análise do Amazon S3 Vectors: Funcionalidades e Benefícios**

O Amazon S3 Vectors foi projetado para otimizar o ciclo de vida do dado vetorial, desde o armazenamento até a consulta, com foco na simplicidade e na economia. O serviço introduz "_vector buckets_ ", um tipo de armazenamento dedicado que elimina a necessidade de os usuários provisionarem ou gerenciarem infraestrutura subjacente, como servidores ou clusters de banco de dados.1 Essa abstração de infraestrutura simplifica drasticamente a operação para desenvolvedores.

Dentro de cada "_vector bucket_ ", os dados vetoriais são organizados eficientemente em "vector indexes". Cada bucket pode suportar até 10.000 índices, e cada índice é capaz de armazenar dezenas de milhões de vetores, permitindo o gerenciamento de datasets massivos.1 Uma funcionalidade crucial é a capacidade de anexar metadados como pares chave/valor ao inserir vetores. Esses metadados permitem filtrar consultas futuras com base em condições específicas, como datas, categorias ou preferências do usuário, otimizando o tempo de seleção e varredura dos vetores.1 Adicionalmente, o S3 Vectors otimiza automaticamente os dados armazenados ao longo do tempo, garantindo o melhor preço/performance à medida que os datasets escalam e evoluem.1 O serviço suporta métricas de distância Cosine e Euclidean, oferecendo flexibilidade para alinhar com as recomendações de diferentes modelos de embedding.1 A inserção, listagem e consulta de vetores são facilitadas através de interfaces familiares como `AWS CLI`, `AWS SDKs` ou a `Amazon S3 REST API`.1 O **S3 Vectors embed CLI** simplifica ainda mais o pipeline de dados, permitindo a geração e o armazenamento de embeddings com comandos únicos.1

A integração profunda com o ecossistema AWS é um pilar central do S3 Vectors. Ele pode ser configurado como um _vector store_ de baixo custo para aplicações RAG no **Amazon Bedrock** , simplificando a criação e o gerenciamento de bases de conhecimento para LLMs.1 Desenvolvedores também podem construir e gerenciar bases de conhecimento com S3 Vectors diretamente do **Amazon SageMaker Unified Studio** , acelerando a criação de aplicações de IA generativa.1 Essa integração nativa é um diferencial significativo, pois reduz a complexidade operacional e a necessidade de "_glue code_ " para conectar diferentes serviços, proporcionando uma experiência de desenvolvedor mais fluida. A capacidade de configurar uma base de conhecimento RAG com poucos cliques é um grande facilitador, permitindo que as equipes se concentrem mais na lógica de negócios e menos na infraestrutura subjacente.

Além disso, o S3 Vectors facilita uma estratégia de armazenamento em camadas com o _OpenSearch Service_. Vetores acessados com menor frequência podem ser armazenados de forma econômica no S3 Vectors, e quando a demanda aumenta, podem ser rapidamente movidos para o OpenSearch Service para operações de busca em tempo real e de baixa latência.3 Essa abordagem otimiza custos, permitindo que as organizações paguem por recursos de computação de banco de dados apenas quando são ativamente necessários.8 Este modelo de armazenamento em camadas é um padrão arquitetural crucial para dados vetoriais em escala. Bancos de dados vetoriais dedicados são otimizados para alta performance e baixa latência, mas geralmente implicam em custos de computação e armazenamento mais elevados.5 O S3 Vectors, nesse contexto, atua como uma camada de "_data lake_ " ou "_armazenamento frio/quente_ " para vetores, enquanto um banco de dados vetorial dedicado serve como uma camada de "_índice quente_ " ou "_cache_ " para consultas ativas. Essa distinção permite que as organizações otimizem custos sem comprometer a performance para os dados mais críticos. Por fim, modelos de embedding robustos, como o _Amazon Titan Text Embeddings V2_ ³¹, oferecidos pelo Amazon Bedrock, podem ser utilizados para gerar os vetores a serem armazenados no S3 Vectors, completando o ciclo de vida dos dados.1

## **Magalu Cloud: Capacidades de Storage e Compatibilidade S3**

A Magalu Cloud se estabeleceu como a primeira infraestrutura de nuvem em escala global do Brasil, uma iniciativa desenvolvida em colaboração com a Luiza Labs. Seu objetivo principal é fornecer uma alternativa de nuvem mais acessível para pequenas e médias empresas, com planos ambiciosos de expansão global.10 A plataforma oferece um conjunto abrangente de serviços de infraestrutura como serviço (IaaS), que incluem Compute (Máquinas Virtuais, Kubernetes, Container Registry), Storage (Block Storage, Object Storage), Database (DBaaS) e Network (VPC, NAT-Gateway).11 A empresa-mãe, Magazine Luiza, possui uma forte cultura "Data-Driven", utilizando o armazenamento de dados de todos os seus canais para aprimorar a experiência de compra dos clientes.12

Embora o site principal da Magalu Cloud possa não destacar explicitamente a compatibilidade S3 em sua página de produtos, há evidências substanciais nos repositórios oficiais do GitHub da MagaluCloud que confirmam essa interoperabilidade. Os repositórios `MagaluCloud/s3-tester` e `MagaluCloud/s3-specs` são dedicados a testes de compatibilidade com provedores de object storage que são compatíveis com a API AWS S3.13 Esses testes abrangem funcionalidades essenciais como gerenciamento de bucket, versionamento de objetos e upload de arquivos grandes.13 A inclusão de ferramentas como `aws-s3api`, `aws-s3`, `rclone` e `mgc` (Magalu Cloud CLI) nos scripts de teste `./bin/test.sh --profiles br-ne1 --clients aws --categories BucketSharing,ColdStorage` 13) indica que o Object Storage da Magalu Cloud pode ser acessado e gerenciado usando APIs e ferramentas S3 padrão. A compatibilidade S3 é um fator crucial, pois permite que desenvolvedores e empresas reutilizem seu conhecimento existente, ferramentas (SDKs, CLI) e bibliotecas projetadas para o ecossistema S3, minimizando a necessidade de reescrever aplicações ou aprender novas APIs específicas da Magalu Cloud.15 Essa compatibilidade atua como um habilitador fundamental para soluções híbridas e de código aberto na Magalu Cloud. Muitos bancos de dados vetoriais open-source são projetados para usar object storage compatível com S3 para persistência de dados, aproveitando sua durabilidade e baixo custo.18 A compatibilidade S3 da Magalu Cloud, portanto, serve como uma ponte tecnológica, conectando a infraestrutura existente da Magalu Cloud às necessidades emergentes de IA e transformando seu Object Storage em uma base viável para um "_data lake de vetores_ " auto-hospedado.

Uma análise aprofundada dos materiais de pesquisa, incluindo o site oficial da Magalu Cloud e seus repositórios GitHub, não revela a existência de serviços nativos de Inteligência Artificial ou Machine Learning, especificamente aqueles voltados para embeddings vetoriais ou bancos de dados vetoriais gerenciados.11 Os serviços listados pela Magalu Cloud se concentram em oferecer infraestrutura básica de nuvem.11 É importante notar que a Magazine Luiza, a empresa-mãe da Magalu Cloud, já utiliza produtos Google Cloud (GCP) para suas necessidades de escalabilidade e inovação, incluindo Firebase e Kubernetes para uma estratégia multi-cloud, implantando cargas de trabalho no GCP na região do Brasil.21 O Google Cloud, por sua vez, oferece uma vasta gama de serviços de IA/ML, incluindo o Vertex AI com modelos de embedding e um serviço de Vector Search.7 A ausência de serviços de IA/ML nativos e integrados na Magalu Cloud implica a necessidade de uma estratégia híbrida para capacidades de IA/ML. Para replicar a experiência funcional da AWS, os usuários da Magalu Cloud precisarão, por necessidade, adotar uma abordagem que combine a Magalu Cloud para sua infraestrutura principal (computação e armazenamento) com provedores de IA de terceiros (como Google Cloud Vertex AI) para a geração de embeddings e, possivelmente, para serviços de banco de dados vetoriais gerenciados. Embora essa abordagem seja prática, ela introduz complexidade adicional em termos de gerenciamento de múltiplos provedores de nuvem, segurança (gerenciamento de credenciais entre nuvens) e potencial latência de rede entre os serviços.

## **Estratégias para Construir uma Solução de Vetores na Magalu Cloud**

Dada a ausência de um serviço nativo de vetores na Magalu Cloud, a abordagem mais viável para replicar a funcionalidade do Amazon S3 Vectors é construir uma solução utilizando seus serviços de infraestrutura existentes (Object Storage e Compute) em conjunto com tecnologias open-source ou serviços de terceiros. Duas abordagens principais podem ser consideradas: a implantação de um banco de dados vetorial autogerenciado ou a integração com serviços de banco de dados vetoriais gerenciados de terceiros.

### **Abordagem 1: Implantação de Banco de Dados Vetorial Autogerenciado**

Esta abordagem envolve a implantação de um banco de dados vetorial open-source em instâncias de Máquinas Virtuais (VMs) ou clusters Kubernetes na Magalu Cloud, utilizando o Object Storage da Magalu Cloud para persistência de dados.

  * **Arquitetura Proposta:**
  * **Magalu Cloud Object Storage (Compatível com S3):** Esta camada é fundamental, atuando como o armazenamento de baixo custo para os dados brutos originais (documentos, imagens, áudios, etc.) e, crucialmente, para a persistência dos dados e backups do banco de dados vetorial.13 Seu papel é análogo ao do S3 no ecossistema AWS, servindo como um "data lake" para dados de IA.8
  * **Magalu Cloud Compute (Máquinas Virtuais ou Kubernetes):** Esta camada hospedará as instâncias do banco de dados vetorial e os serviços de geração de embeddings.11
  * **Máquinas Virtuais (VMs):** Oferecem uma rota mais simples para prototipagem ou cargas de trabalho menores, onde um banco de dados vetorial de nó único (ex: Milvus Standalone 24, Qdrant Single Node 25) pode ser suficiente.
  * **Kubernetes (Magalu Cloud Kubernetes):** É a escolha preferencial para escalabilidade, alta disponibilidade e gerenciamento de cargas de trabalho complexas em produção, permitindo a implantação de clusters distribuídos de bancos de dados vetoriais (ex: Milvus Distributed 18, Qdrant Cluster 25).19
  * **Banco de Dados Vetorial Open-Source:** A escolha do banco de dados dependerá dos requisitos específicos de escala, performance, complexidade de gerenciamento e familiaridade da equipe. As opções primárias incluem:
  * **Milvus:** Um banco de dados vetorial open-source de alta performance e escalabilidade, construído para aplicações de GenAI.9 Suporta implantação leve (Milvus Lite para prototipagem), standalone (para produção em máquina única) e distribuída (para grandes datasets e alta disponibilidade em Kubernetes).18 O Milvus Distributed pode ser implantado em clusters Kubernetes e é projetado para usar object storage compatível com S3 para persistência.18
  * **Qdrant:** Outro banco de dados vetorial open-source, focado em alta performance e escalabilidade para aplicações de IA.5 Oferece opções de implantação em nó único ou cluster distribuído, com foco em resiliência e otimização de custos.25
  * **Pgvector:** Uma extensão para PostgreSQL que permite armazenar vetores em tabelas de banco de dados e realizar buscas de similaridade usando consultas SQL padrão.26 É uma opção mais simples para quem já utiliza PostgreSQL e para datasets menores, embora possa ser escalado em Kubernetes.26 Suporta diversas métricas de distância e tipos de índice (HNSW, IVFFlat) para otimizar a busca.27
  * Geração de Embeddings: Opções de Modelos:Para converter os dados não estruturados em vetores numéricos que serão armazenados e consultados, existem duas abordagens principais:
  * **Modelos de Embedding Open-Source Auto-Hospedados:** É possível implantar e executar modelos de embedding open-source (como Voyage-3-large ou Stella para texto 28, ou modelos baseados em transformadores como CLIP para imagens 29) diretamente em instâncias de computação da Magalu Cloud. Isso pode exigir VMs com GPUs (se disponíveis na Magalu Cloud) ou clusters Kubernetes com nós de GPU para inferência eficiente. Esta opção oferece controle total sobre o processo, mas impõe a sobrecarga de gerenciamento da infraestrutura de inferência.2
  * **APIs de Embedding de Terceiros (ex: Google Cloud Vertex AI):** Uma abordagem mais prática e que abstrai a complexidade do gerenciamento de modelos é utilizar serviços de embedding gerenciados de outros provedores de nuvem. Dada a relação existente da Magazine Luiza com o Google Cloud 21, o Vertex AI é uma opção particularmente relevante. Modelos comogemini-embedding-001 (que gera vetores de 3072 dimensões) ou text-embedding-005 (768 dimensões) podem ser usados para gerar embeddings de texto de alta qualidade.23 O Vertex AI também oferece capacidades para processamento de imagens e outros tipos de dados, permitindo a criação de embeddings multimodais.7 Embora esta abordagem simplifique o gerenciamento do modelo de embedding, ela implica em custos adicionais por uso da API e pode introduzir latência de rede entre a Magalu Cloud (onde os dados brutos e o BD vetorial residem) e o Google Cloud (onde a inferência de embedding ocorre).



**Passos para Geração de Embeddings (Exemplo Conceitual com Vertex AI):**

  1. Assegurar que um projeto Google Cloud esteja configurado e que a API Vertex AI esteja habilitada.23
  2. Utilizar o SDK do Vertex AI para Python ou a API REST para invocar o modelo de embedding desejado (ex: gemini-embedding-001) passando o texto ou dado não estruturado como entrada.23
  3. Capturar o vetor de embedding retornado pela API para uso posterior.


  * **Fluxo de Trabalho Detalhado: Ingestão, Indexação e Consulta de Vetores:**


  1. **Armazenamento de Dados Brutos:** Os dados não estruturados originais (documentos, imagens, vídeos, etc.) devem ser armazenados no Object Storage da Magalu Cloud. Este é o ponto de partida para o pipeline de IA.


    
    
    # Exemplo de upload de um documento PDF para o Object Storage da Magalu Cloud
    mgccli s3 cp my_document.pdf s3://my-magalu-cloud-bucket/documents/

Ou, se o `awscli` estiver configurado com o endpoint da Magalu Cloud, aproveitando a compatibilidade S3:
    
    
    aws s3 cp my_document.pdf s3://my-magalu-cloud-bucket/documents/ --endpoint-url https://s3.br-ne1.magalu.cloud

  2. **Geração de Embeddings:**


  * Um serviço de processamento de dados (executado em VMs ou Kubernetes na Magalu Cloud) lê os dados brutos do Object Storage.
  * Este serviço invoca um modelo de embedding (seja auto-hospedado na Magalu Cloud ou via API de terceiros como Vertex AI) para gerar os vetores numéricos correspondentes.
  * **Exemplo (Pseudocódigo Python com Vertex AI):**


    
    
    from vertexai.language_models import TextEmbeddingModel
    
    def generate_embedding(text: str) -> list:
        model = TextEmbeddingModel.from_pretrained("text-embedding-004")
        embeddings = model.get_embeddings([text])
        return embeddings.values
    
    # Exemplo de uso:
    document_text = "Este é um exemplo de texto para gerar um embedding."
    embedding_vector = generate_embedding(document_text)
    print(f"Vetor de Embedding: {embedding_vector}")

  * Os vetores gerados, juntamente com metadados relevantes (ex: ID do documento original, data, categoria), são inseridos no banco de dados vetorial (Milvus, Qdrant, Pgvector) implantado na Magalu Cloud.
  * O banco de dados vetorial gerencia a indexação para buscas eficientes de similaridade.
  * **Exemplo (Pseudocódigo Python com Milvus):**


    
    
    from pymilvus import MilvusClient
    
    # Conectar ao Milvus (assumindo Milvus Standalone ou Distributed na Magalu Cloud)
    client = MilvusClient(uri="http://<IP_OU_HOSTNAME_MILVUS>:19530")
    
    collection_name = "document_embeddings"
    if not client.has_collection(collection_name):
        client.create_collection(
            collection_name=collection_name,
            dimension=len(embedding_vector), # Dimensão do vetor gerado
            primary_field_name="id",
            vector_field_name="embedding",
            metric_type="COSINE", # Ou "L2"
            auto_id=True
        )
    
    # Inserir o vetor e metadados
    data = [
        {"embedding": embedding_vector, "document_id": "doc_123", "category": "finance"}
    ]
    client.insert(collection_name=collection_name, data=data)
    print(f"Vetor inserido na coleção '{collection_name}'.")

  4. **Consulta de Similaridade:**


  * Para uma consulta (ex: uma pergunta de usuário em um chatbot), a consulta é primeiro convertida em um vetor de embedding usando o mesmo modelo.
  * Este vetor de consulta é então usado para buscar vetores semanticamente semelhantes no banco de dados vetorial.
  * **Exemplo (Pseudocódigo Python com Milvus):**


    
    
    query_text = "Quais documentos falam sobre investimentos?"
    query_embedding = generate_embedding(query_text) # Reutiliza a função de geração de embedding
    
    # Buscar os 5 vetores mais similares
    results = client.search(
        collection_name=collection_name,
        data=[query_embedding],
        limit=5,
        output_fields=["document_id", "category"] # Campos de metadados a retornar
    )
    
    print("Resultados da busca de similaridade:")
    for hit in results:
        print(f"  ID do Documento: {hit['document_id']}, Categoria: {hit['category']}, Distância: {hit['distance']}")

  5. **Recuperação e Uso (Ex: RAG):**


  * Com base nos `document_ids` recuperados, os documentos originais correspondentes são buscados no _Object Storage_ da Magalu Cloud.
  * O conteúdo desses documentos é então usado como contexto para um LLM (hospedado na Magalu Cloud ou via API de terceiros) para gerar uma resposta mais informada e precisa.



### **Abordagem 2: Integração com Serviços de Banco de Dados Vetoriais Gerenciados de Terceiros**

Esta abordagem delega o gerenciamento do banco de dados vetorial a um provedor de nuvem especializado, simplificando a operação em troca de uma potencial dependência de múltiplos provedores.

  * **Arquitetura Proposta:**
  * **Magalu Cloud Object Storage (Compatível com S3):** Continua sendo a camada principal para armazenamento de dados brutos e, possivelmente, para backups de dados vetoriais, se o serviço gerenciado de terceiros permitir exportações.13
  * **Magalu Cloud Compute (Máquinas Virtuais ou Kubernetes):** Utilizada para hospedar a lógica de aplicação, os serviços de geração de embeddings (se auto-hospedados) e a orquestração que interage com o banco de dados vetorial gerenciado.
  * **Serviço de Banco de Dados Vetorial Gerenciado de Terceiros:**
  * **Pinecone:** Um banco de dados vetorial totalmente gerenciado e serverless, otimizado para escalabilidade e alta performance.6 Oferece configuração rápida, escalabilidade automática e recursos avançados de recuperação, incluindo filtros de metadados e indexação em tempo real.6
  * **Qdrant Cloud:** A versão gerenciada do Qdrant open-source, que oferece escalabilidade vertical e horizontal, além de atualizações sem tempo de inatividade.5 Proporciona conveniência e escalabilidade, embora os dados residam fora do controle direto da infraestrutura da Magalu Cloud.30
  * **Zilliz Cloud (Milvus Gerenciado):** Uma oferta totalmente gerenciada do Milvus, prometendo ser mais rápida e sem complicações.9 Disponível em opções serverless e de cluster dedicado, com foco em diferentes requisitos de segurança e conformidade.9
  * **Geração de Embeddings:** As opções de geração de embeddings (modelos open-source auto-hospedados ou APIs de terceiros como Google Cloud Vertex AI) permanecem as mesmas da Abordagem 1.
  * **Considerações para a Abordagem 2:**
  * **Vantagens:** Reduz a complexidade operacional e a sobrecarga de gerenciamento de um banco de dados vetorial em larga escala. Permite que as equipes se concentrem mais no desenvolvimento de aplicações de IA.
  * **Desvantagens:** Introduz dependência de um provedor de nuvem adicional, o que pode aumentar a complexidade de gerenciamento de custos, segurança e conformidade entre nuvens. Pode haver latência de rede entre os serviços da Magalu Cloud e o banco de dados vetorial gerenciado de terceiros.



## **Recomendações**

A introdução do Amazon S3 Vectors pela AWS destaca uma tendência crítica no cenário da IA: a necessidade de armazenamento de vetores de baixo custo e alta escala para impulsionar aplicações generativas. Embora a Magalu Cloud não ofereça um serviço nativo equivalente ao S3 Vectors, sua robusta oferta de Object Storage compatível com S3, combinada com seus serviços de computação (Máquinas Virtuais e Kubernetes), posiciona-a como uma plataforma viável para construir soluções de armazenamento de vetores.

A ausência de serviços de IA/ML gerenciados na Magalu Cloud significa que as organizações que buscam replicar a funcionalidade do S3 Vectors precisarão adotar uma estratégia de arquitetura híbrida. Esta estratégia envolve a orquestração de componentes de código aberto ou serviços de terceiros para a geração de embeddings e o gerenciamento de bancos de dados vetoriais, enquanto aproveitam a infraestrutura de armazenamento e computação da Magalu Cloud. A compatibilidade S3 do Object Storage da Magalu Cloud é um diferencial crucial, pois permite a integração com uma ampla gama de ferramentas e bibliotecas existentes no ecossistema S3, simplificando o desenvolvimento e a implantação.

Para implementar uma solução de armazenamento de vetores na Magalu Cloud, inspirada no modelo do Amazon S3 Vectors, as seguintes recomendações são apresentadas:

  1. **Aproveitar o Object Storage da Magalu Cloud como Camada de Dados para Vetores:** Utilizar o Object Storage da Magalu Cloud como o repositório principal de baixo custo para dados brutos e, para implantações autogerenciadas, para a persistência e backups dos bancos de dados vetoriais. A compatibilidade S3 garante que ferramentas e SDKs existentes possam ser utilizados para interação.
  2. **Escolher uma Abordagem de Banco de Dados Vetorial:**


  * **Para Controle e Otimização de Custos a Longo Prazo (Abordagem 1 - Autogerenciada):** Implantar um banco de dados vetorial open-source como Milvus, Qdrant ou Pgvector em clusters Kubernetes (preferencialmente para escalabilidade e resiliência) ou Máquinas Virtuais da Magalu Cloud. Esta opção oferece maior controle sobre a infraestrutura e os custos, mas exige expertise em gerenciamento de banco de dados.
  * **Para Simplicidade e Redução de Carga Operacional (Abordagem 2 - Gerenciada por Terceiros):** Integrar com um banco de dados vetorial gerenciado de terceiros, como Pinecone, Qdrant Cloud ou Zilliz Cloud. Esta opção simplifica a operação e o dimensionamento, mas introduz uma dependência externa e potenciais custos adicionais de transferência de dados.


  3. **Estabelecer um Pipeline de Geração de Embeddings:**


  * **Para Modelos de Embedding:** Avaliar a viabilidade de hospedar modelos de embedding open-source em VMs com GPU ou clusters Kubernetes na Magalu Cloud para inferência controlada. Alternativamente, e de forma mais imediata, integrar com APIs de embedding de terceiros, como o Google Cloud Vertex AI, que oferece modelos de alta qualidade e escalabilidade para geração de vetores. A escolha dependerá dos requisitos de latência, custo e complexidade de gerenciamento.
  * **Para Orquestração:** Desenvolver um serviço de processamento de dados (executado em Magalu Cloud Compute) que orquestre a leitura de dados brutos do Object Storage, a chamada aos modelos de embedding e a inserção dos vetores resultantes no banco de dados vetorial escolhido.


  4. **Implementar uma Estratégia de Armazenamento em Camadas (Tiered Storage):** Inspirado no modelo da AWS, considerar uma arquitetura onde o Object Storage da Magalu Cloud armazena vetores de acesso menos frequente ou dados brutos, enquanto o banco de dados vetorial (autogerenciado ou de terceiros) serve como uma camada de "índice quente" para consultas de baixa latência. Isso otimiza custos e performance.
  5. **Priorizar a Experiência do Desenvolvedor:** Embora a Magalu Cloud não ofereça integrações nativas de IA/ML como a AWS, é crucial simplificar o processo de desenvolvimento criando módulos reutilizáveis, scripts de automação (utilizando mgccli ou Terraform para Magalu Cloud 14) e documentação clara para o pipeline de dados vetoriais.



#### **Referências**

  1. Introducing Amazon S3 Vectors: [_https://aws.amazon.com/blogs/aws/introducing-amazon-s3-vectors-first-cloud-storage-with-native-vector-support-at-scale/_](https://aws.amazon.com/blogs/aws/introducing-amazon-s3-vectors-first-cloud-storage-with-native-vector-support-at-scale/?ref=blog.robertabrandao.com.br)
  2. A Guide to Open-Source Embedding Models: [_https://www.bentoml.com/blog/a-guide-to-open-source-embedding-models_](https://www.bentoml.com/blog/a-guide-to-open-source-embedding-models?ref=blog.robertabrandao.com.br)
  3. Build Cheap and Scalable AI with AWS S3 Vector Storage: [_https://medium.com/@tahirbalarabe2/build-scalable-ai-with-aws-s3-vector-storage-ab9febb78794_](https://medium.com/@tahirbalarabe2/build-scalable-ai-with-aws-s3-vector-storage-ab9febb78794?ref=blog.robertabrandao.com.br)
  4. Announcing Amazon S3 Vectors Preview: [_https://www.reddit.com/r/aws/comments/1m12r14/announcing_amazon_s3_vectors_previewfirst_cloud/_](https://www.reddit.com/r/aws/comments/1m12r14/announcing_amazon_s3_vectors_previewfirst_cloud/?ref=blog.robertabrandao.com.br)
  5. Qdrant - Vector Database: [_https://qdrant.tech/_](https://qdrant.tech/?ref=blog.robertabrandao.com.br)
  6. Pinecone: The vector database to build knowledgeable AI: [_https://www.pinecone.io/_](https://www.pinecone.io/?ref=blog.robertabrandao.com.br)
  7. AI and Machine Learning Products and Services: [_https://cloud.google.com/products/ai_](https://cloud.google.com/products/ai?ref=blog.robertabrandao.com.br)
  8. AWS adds vector buckets to S3 to cut RAG storage costs: [_https://blocksandfiles.com/2025/07/17/aws-vector-buckets-s3/_](https://blocksandfiles.com/2025/07/17/aws-vector-buckets-s3/?ref=blog.robertabrandao.com.br)
  9. Milvus | High-Performance Vector Database Built for Scale: [_https://milvus.io/_](https://milvus.io/?ref=blog.robertabrandao.com.br)
  10. A primeira Cloud de escala global do Brasil: [_https://enredo.com.br/en/cases_post/magalu-cloud/_](https://enredo.com.br/en/cases_post/magalu-cloud/?ref=blog.robertabrandao.com.br)
  11. Magalu Cloud: [_https://magalu.cloud/_](https://magalu.cloud/?ref=blog.robertabrandao.com.br)
  12. Our Ecosystem - Magazine Luiza: [_https://ri.magazineluiza.com.br/show.aspx?idCanal=Z7pywmj5YSW3wFVsMAhgAw== &linguagem=en_](https://ri.magazineluiza.com.br/show.aspx?idCanal=Z7pywmj5YSW3wFVsMAhgAw%3D%3D&linguagem=en&ref=blog.robertabrandao.com.br)
  13. MagaluCloud/s3-tester: [_https://github.com/MagaluCloud/s3-tester_](https://github.com/MagaluCloud/s3-tester?ref=blog.robertabrandao.com.br)
  14. Magalu Cloud Repo: [_https://github.com/MagaluCloud_](https://github.com/MagaluCloud?ref=blog.robertabrandao.com.br)
  15. Object storage: [_https://docs.gitlab.com/administration/object_storage/_](https://docs.gitlab.com/administration/object_storage/?ref=blog.robertabrandao.com.br)
  16. Interoperability with other storage provider: [_https://cloud.google.com/storage/docs/interoperability_](https://cloud.google.com/storage/docs/interoperability?ref=blog.robertabrandao.com.br)
  17. Object Storage Amazon S3 Compatibility API: [_https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/s3compatibleapi.htm_](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/s3compatibleapi.htm?ref=blog.robertabrandao.com.br)
  18. How to Deploy the Open-Source Milvus Vector Database on Amazon EKS: [_https://milvus.io/blog/how-to-deploy-open-source-milvus-vector-database-on-amazon-eks.md_](https://milvus.io/blog/how-to-deploy-open-source-milvus-vector-database-on-amazon-eks.md?ref=blog.robertabrandao.com.br)
  19. IaC Magalu Cloud Modules and Tools: [_https://github.com/terraform-magalu-cloud_](https://github.com/terraform-magalu-cloud?ref=blog.robertabrandao.com.br)
  20. Magalu Cloud APIs: [_https://www.postman.com/magalu-cloud-apis/magalu-cloud-apis/overview_](https://www.postman.com/magalu-cloud-apis/magalu-cloud-apis/overview?ref=blog.robertabrandao.com.br)
  21. Magazine Luiza Case Study: [_https://cloud.google.com/customers/magazine-luiza_](https://cloud.google.com/customers/magazine-luiza?ref=blog.robertabrandao.com.br)
  22. Real-world gen AI use cases from the world's leading organizations: [_https://cloud.google.com/transform/101-real-world-generative-ai-use-cases-from-industry-leaders_](https://cloud.google.com/transform/101-real-world-generative-ai-use-cases-from-industry-leaders?ref=blog.robertabrandao.com.br)
  23. Get text embeddings: [_https://cloud.google.com/vertex-ai/generative-ai/docs/embeddings/get-text-embeddings_](https://cloud.google.com/vertex-ai/generative-ai/docs/embeddings/get-text-embeddings?ref=blog.robertabrandao.com.br)
  24. Overview of Milvus Deployment Options: [_https://milvus.io/docs/install-overview.md_](https://milvus.io/docs/install-overview.md?ref=blog.robertabrandao.com.br)
  25. Distributed Deployment - Qdrant:__[_https://qdrant.tech/documentation/guides/distributed_deployment/_](https://qdrant.tech/documentation/guides/distributed_deployment/?ref=blog.robertabrandao.com.br)
  26. Deploy a PostgreSQL vector database on GKE: [_https://cloud.google.com/kubernetes-engine/docs/tutorials/deploy-pgvector_](https://cloud.google.com/kubernetes-engine/docs/tutorials/deploy-pgvector?ref=blog.robertabrandao.com.br)
  27. pgvector/pgvector: [_https://github.com/pgvector/pgvector_](https://github.com/pgvector/pgvector?ref=blog.robertabrandao.com.br)
  28. The Best Embedding Models for Information Retrieval in 2025: [_https://www.datastax.com/blog/best-embedding-models-information-retrieval-2025_](https://www.datastax.com/blog/best-embedding-models-information-retrieval-2025?ref=blog.robertabrandao.com.br)
  29. How Image Embeddings Transform Computer Vision Capabilities: [_https://voxel51.com/learn/how-image-embeddings-transform-computer-vision-capabilities_](https://voxel51.com/learn/how-image-embeddings-transform-computer-vision-capabilities?ref=blog.robertabrandao.com.br)
  30. Qdrant Vector Database: [_https://medium.com/@turjachaudhuri/qdrant-vector-database-deployment-options-in-an-enterprise-context-1d206b30f69f_](https://medium.com/@turjachaudhuri/qdrant-vector-database-deployment-options-in-an-enterprise-context-1d206b30f69f?ref=blog.robertabrandao.com.br)
  31. Amazon Titan Text Embeddings: [https://docs.aws.amazon.com/bedrock/latest/userguide/titan-embedding-models.html](https://docs.aws.amazon.com/bedrock/latest/userguide/titan-embedding-models.html?ref=blog.robertabrandao.com.br)



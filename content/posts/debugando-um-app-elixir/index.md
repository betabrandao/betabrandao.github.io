---
title: "Debugando um app Elixir"
date: 2025-08-04T11:35:21.000-03:00
tags: [Dicas e Truques]
author: Roberta
featured_image: "featured.jpg"
---
O IEx é um verdadeiro "canivete suíço" para debugar aplicações Elixir. Com ele, você tem acesso direto ao estado da aplicação, pode inspecionar conexões, analisar consumo de memória e acompanhar a troca de mensagens entre processos. Em sistemas distribuídos e altamente concorrentes, essas ferramentas são essenciais para garantir observabididade e rapidez na resolução de problemas.

Neste artigo, vamos explorar como usar o IEx para:

  1. Checar conexões com o banco de dados.
  2. Fazer consultas de uso de memória.
  3. Acompanhar mensagens e processos internos do Elixir (mensageria).
  4. Usar o IEx remoto com checklist.



## Iniciando o IEx com sua Aplicação (IEx -S Mix)

Para debugar uma aplicação Elixir, você deve rodar sua aplicação no modo interativo:
    
    
    iex -S mix
    

Isso compila e inicia a aplicação, mantendo o console aberto para interação. Agora você pode executar qualquer função, acessar processos e inspecionar o estado do sistema em tempo real.

## Checando Conexões com o Banco de Dados (Ecto)

Se sua aplicação usa o **Ecto** (a principal biblioteca de ORM para Elixir), você pode inspecionar e testar as conexões facilmente.

### Testando uma Consulta Manualmente:
    
    
    alias MyApp.Repo
    alias MyApp.User
    
    # Buscar um usuário pelo ID
    Repo.get(User, 1)
    

### Verificando o Status da Conexão:
    
    
    Repo.checkout(fn -> Repo.query!("SELECT 1") end)
    

Se houver problema de conexão, você receberá um erro imediatamente, como `DBConnection.ConnectionError`.

### Checando o Pool de Conexões (DBConnection):
    
    
    :sys.get_state(Repo.Pool)
    

Ou, se estiver usando o **Ecto.Adapters.SQL.Sandbox** :
    
    
    Ecto.Adapters.SQL.Sandbox.mode(Repo, :manual)
    

## Consultando Uso de Memória

O Elixir/Erlang tem ferramentas nativas para monitoramento de memória e processos.

### Ver Uso Total de Memória:
    
    
    :erlang.memory()
    

### Inspecionar Memória de um Processo Específico:
    
    
    pid = self() # ou qualquer PID de processo
    :erlang.process_info(pid, :memory)
    

### Listar os Processos que Mais Consomem Memória:
    
    
    Process.list()
    |> Enum.map(fn pid -> {pid, :erlang.process_info(pid, :memory)} end)
    |> Enum.sort_by(fn {_pid, {:memory, mem}} -> -mem end)
    |> Enum.take(10)
    

## Monitorando Mensageria e Processos Internos

Uma das grandes forças do Elixir é seu modelo de **mensageria entre processos (actors)**. Aqui estão algumas técnicas para inspecionar isso:

### Checar a Caixa de Mensagens de um Processo:
    
    
    Process.info(self(), :messages)
    

### Ver Processos Registrados:
    
    
    Process.registered()
    

### Inspecionar Detalhes de um Processo:
    
    
    pid = whereis(:my_named_process)
    Process.info(pid)
    

### Utilizando `:observer.start/0` (Interface Gráfica):

Se você quiser uma visão mais visual do sistema, execute:
    
    
    :observer.start()
    

Isso abrirá uma interface gráfica mostrando processos, árvores de supervisão, estatísticas de memória e mais.

> **Dica** : Se estiver em um ambiente que não suporta GUI (ex: servidores remotos), use o `:observer_cli` para ter uma visão similar direto no terminal:
    
    
    {:ok, _} = :observer_cli.start()
    

### Espiar Mensagens com `:sys.trace/2`:

Se você quiser ver as mensagens que um processo está recebendo:
    
    
    :sys.trace(pid, true)
    

Agora, todas as mensagens enviadas ao processo serão exibidas no console.

### Checagem de processos

**Truques com`Process.flag/2`**:  
Para receber mensagens de saída de processos:
    
    
    Process.flag(:trap_exit, true)
    

### **Logger Level Temporário** :
    
    
    Logger.configure(level: :debug)
    

### **Pausa Interativa**

**IEx.pry** : Use esse comando dentro do código para "pausar" a execução e abrir um shell interativo naquele ponto.
    
    
    require IEx; IEx.pry
    

Quando o fluxo do código atingir essa linha, a execução pausará e você poderá inspecionar variáveis.

7\. Encerrar Processos com Leaks ou Bugs

Se você encontrar um processo zumbi ou consumindo memória demais:
    
    
    Process.exit(pid, :kill)
    

## IEx Remoto com checklist

Pré-requisito: IEx Remoto com Cookie de autenticação configurado.

Antes de qualquer passo, conecte-se à aplicação em produção:
    
    
    NODE_NAME="my_app@IP_DO_SERVIDOR"
    iex --name debug@127.0.0.1 --cookie SECRET_COOKIE --remsh $NODE_NAME
    

### Observer

Se possível, use-o:

**Observer CLI (Ambiente sem GUI):**  
Adicione ao `mix.exs`:
    
    
    {:observer_cli, "~> 1.7"}
    

E rode:
    
    
    :observer_cli.start()
    

**Observer GUI:**
    
    
    :observer.start()
    

😸

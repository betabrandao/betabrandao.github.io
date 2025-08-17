---
title: "Como comparei duas linguagens concorrentes para um projeto?"
date: 2025-08-07T17:07:30.000-03:00
tags: [Desenvolvimento, Arquitetura]
author: Roberta
featured_image: "featured.jpg"
---
No último projeto pessoal, simulei o core de um sistema de pagamento. Pra isso, comecei a estudar qual linguagem seria importante para tratar o volume de transação e ainda garantir alguns guardrails para o ambiente. Entre as demais linguagens, meu benchmark decidi entre **Golang** e **Elixir,** por gosto pessoal e no fim escolhi o **Elixir**.

Go é poderoso, mas não fornece isolamento forte por **design**. Ele opta por eficiência e simplicidade, mas exige que o programador gerencie a concorrência de forma cuidadosa.Já **Elixir** /**Erlang** garante isso por construção: **processos isolados** e **comunicação via mensagem** tornam concorrência mais segura e previsível.

Comecei me baseando cenários de curto, médio e longo prazo, especialmente nos contextos sobre concorrência massiva, resiliência, distribuição e manutenção do código:

  * **Concorrência** : Elixir E Golang são excelente. O Actor model do Elixir lida com processos leves e isolamento completo. Já Golang , tem os goroutines e channels, mas sem isolamento forte, pois todas as goroutines compartilham o mesmo heap de memória, necessitando de devs experientes suficientes para tratar isso na arquitetura.
  * **Resiliência** : No Elixir, é altíssima, pois usa o modelo de supervisão e tolerância a falhas nativo do Erlang). No Golang, depende do desenvolvedor implementar retries, fallback, etc.
  * **Latência e tempo real** : O Elixir mostra-se ótimo para sistemas com baixa latência e alto volume de eventos concorrentes. No Golang pode ser menos previsível sob carga muito alta.
  * **Hot code reload** : Pela construção da máquina virtual BEAM , no Elixir é possível realizar hot reaload em sistemas críticos 24x7, já que no Golang, necessita de restart.
  * **Distribuição nativa** : O Elixir herda nativamente do Erlang a comunicação transparente entre nodes, e o Golang necessita de ferramentas externas como gRPC, NATS, etc



### Coisas que pesou na escolha do Golang:

  * Quando o foco for máximo desempenho em computação intensiva, como criptografia em larga escala ou compressão.
  * Se sua equipe já for especializada em Go e precisar de binários únicos e leves.
  * Se o sistema é essencialmente REST-based ou gRPC, com pouca lógica interna concorrente e muito I/O.



### Coisas que pesou na escolha do Elixir:

  * Lida naturalmente com milhares de conexões simultâneas.
  * É resiliente e seguro contra falhas.
  * Permite atualizações sem parada.
  * É altamente observável e introspectivo.



### Os pontos de atenção do Golang

  * **Goroutines** compartilham o mesmo heap de memória. Isso significa que duas **goroutines** podem acessar e modificar os mesmos dados simultaneamente e; você precisa proteger acesso concorrente com **mutexes** , **locks** ou **channels** cuidadosamente sincronizados:

```golang
    var x int
    
    go func() { x = 1 }()
    go func() { x = 2 }()
    // condição de corrida: quem escreverá último?
```

  * Channels ajudam na comunicação entre **goroutines** , mas não impedem que elas compartilhem referências a objetos mutáveis. Mesmo com o uso de canal, o acesso à função não é isolado. Dois processos podem alterar o mesmo objeto ao mesmo tempo.
    
    
```golang
    type Conta struct { saldo int }
    
    conta := &Conta{saldo: 100}
    
    // Canal com referências compartilhadas
    ch := make(chan *Conta)
    
    go func() {
        conta.saldo += 50
        ch <- conta
    }()
    
    go func() {
        c := <-ch
        c.saldo -= 30
    }()
    
```

  * Go depende de disciplina, e isso é crítico demais a longo prazo. Como falei antes, a memória é compartilhada por padrão e cabe ao desenvolvedor garantir segurança de concorrência com mutexes, RWLocks, atomic. Elevar esta responsabilidade para o humano seria um risco.
  * **Race Conditions** detecta, mas não previne.



## Testes

Vamos supor que queremos debitar valores de uma conta **simultaneamente**. Suponha que o cliente tem **saldo R$100** e duas transações tentam debitar R$70 e R$50 **ao mesmo tempo**.

### Em Go: Risco de condição de corrida
    
    
```golang
    package main
    
    import (
        "fmt"
        "time"
    )
    
    type Conta struct {
        Saldo int
    }
    
    func (c *Conta) Debitar(valor int) {
        if c.Saldo >= valor {
            time.Sleep(100 * time.Millisecond) // simula latência
            c.Saldo -= valor
            fmt.Printf("Debitado R$%d, saldo atual: R$%d\n", valor, c.Saldo)
        } else {
            fmt.Printf("Saldo insuficiente para R$%d, saldo atual: R$%d\n", valor, c.Saldo)
        }
    }
    
    func main() {
        conta := &Conta{Saldo: 100}
    
        go conta.Debitar(70)
        go conta.Debitar(50)
    
        time.Sleep(500 * time.Millisecond)
    }
    
```

### Resultado possível:
    
    
```pre
    Debitado R$70, saldo atual: R$30
    Debitado R$50, saldo atual: R$-20  ← ERRO!
```

Ambas as goroutines **verificaram o saldo antes de debitar** , mas **modificaram a mesma memória** — isso causa uma **race condition** , pois o acesso à `conta.Saldo` não é sincronizado.

### Em Elixir: Concorrência segura com processos isolados
    
    
```elixir
    defmodule Conta do
      def start_link(saldo_inicial) do
        spawn_link(fn -> loop(saldo_inicial) end)
      end
    
      defp loop(saldo) do
        receive do
          {:debitar, valor, from} ->
            if saldo >= valor do
              new_saldo = saldo - valor
              send(from, {:ok, new_saldo})
              loop(new_saldo)
            else
              send(from, {:erro, :saldo_insuficiente})
              loop(saldo)
            end
        end
      end
    end
    
    # Simulando concorrência
    pid = Conta.start_link(100)
    
    # Lançando 2 transações simultâneas
    spawn(fn ->
      send(pid, {:debitar, 70, self()})
      receive do r -> IO.inspect(r, label: "Transação 1") end
    end)
    
    spawn(fn ->
      send(pid, {:debitar, 50, self()})
      receive do r -> IO.inspect(r, label: "Transação 2") end
    end)
```

### 🧾 Resultado (coerente):
    
    
```pre
    Transação 1: {:ok, 30}
    Transação 2: {:erro, :saldo_insuficiente}
    
```

#### Por quê funciona?

  * Cada `Conta` é um processo **isolado** , com seu próprio estado interno (`saldo`).
  * A concorrência é resolvida **por fila de mensagens** , onde cada mensagem é processada **sequencialmente**.
  * **Sem race conditions** , sem mutex, sem locks.



**Elixir evita erros de concorrência por design** , enquanto **Go exige muito cuidado e ferramentas extras** para manter consistência.

# Próximos Passos: 

  * Arquitetura;
  * Infra;
  * Prova de Conceito;



😸

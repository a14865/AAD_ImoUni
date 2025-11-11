# 🏠 ImoUni — Sistema de Gestão Imobiliária  
**Projeto Prático — Análise e Acesso a Dados (2025/2026 – 1.º semestre)**  

---

## 🎯 Objetivo do Projeto
O projeto **ImoUni** tem como objetivo desenvolver uma **base de dados relacional** em **Microsoft SQL Server** para apoiar a gestão de uma empresa de mediação imobiliária.  

O sistema deve permitir:
- Gerir **imóveis**, **clientes**, **agentes**, **contratos**, **propostas**, **pagamentos** e **comissões**;  
- Centralizar e automatizar os processos internos da empresa;  
- Gerar **consultas SQL** e **relatórios de desempenho** que auxiliem a gestão.

---

## 🗂️ Estrutura Simplificada do Repositório

imouni-db/
│
├── README.md ← Descrição completa do projeto.
│
├── sql/ ← Scripts SQL do projeto.
│ ├── 01_modelo.sql ← Criação das tabelas e relações (DDL).
│ ├── 02_dados.sql ← Inserção de dados simulados (DML).
│ ├── 03_consultas.sql ← Consultas e relatórios de gestão.
│ └── 04_testes.sql ← Testes e validação da base de dados.
│
├── doc/ ← Documentação e relatórios.
│ ├── der.png ← Diagrama Entidade-Relacionamento.
│ ├── modelo_relacional.png← Modelo lógico (relacional).
│ └── relatorio_final.pdf ← Relatório final (3–5 páginas).
│
└── data/ ← (Opcional) Dados de exemplo em CSV.

---

## ⚙️ Etapa 0 — Preparação do Repositório

**Objetivo:** Criar o repositório e preparar o ambiente de trabalho.

### Tarefas
- Criar o repositório no GitHub (`imouni-db`);
- Adicionar este `README.md`;
- Criar as pastas: `sql/`, `doc/`, `data/`;
- Instalar e configurar o **Microsoft SQL Server** (ou usar Docker);
- Testar a ligação ao servidor e criar uma base de dados vazia.

### Exemplo com Docker
```bash
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Strong!Pass123' \
  -p 1433:1433 -d --name imouni-sql \
  mcr.microsoft.com/mssql/server:2019-latest

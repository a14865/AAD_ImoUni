# 🏠 ImoUni — Sistema de Gestão Imobiliária  
### Projeto Prático — Análise e Acesso a Dados (2025/2026 – 1.º semestre)

---

## 🎯 Objetivo do Projeto

O projeto **ImoUni** tem como objetivo desenvolver uma base de dados relacional em **Microsoft SQL Server** para apoiar a gestão de uma empresa de mediação imobiliária.

O sistema deverá:

- Gerir imóveis, clientes, agentes, contratos, propostas, pagamentos e comissões;
- Centralizar e automatizar os processos internos da imobiliária;
- Permitir consultas e relatórios SQL para apoiar decisões de gestão.

---

## 🗂️ Estrutura do Repositório
imouni-db/
│
├── README.md
├── sql/
│ ├── 01_modelo.sql
│ ├── 02_dados.sql
│ ├── 03_consultas.sql
│ ├── 04_regras.sql
│ └── 05_testes.sql
├── doc/
│ ├── der.png
│ ├── modelo_relacional.png
│ └── relatorio_final.pdf
└── data/


---

## ⚙️ Etapa 0 — Preparação do Repositório

**Objetivo:** Configurar o ambiente e a estrutura inicial do projeto.

### ✅ Checklist

- [x] Repositório criado  
- [x] Estrutura inicial definida  
- [x] SQL Server configurado  
- [x] Teste básico executado (`CREATE DATABASE ImoUni;`)

---

## 🧩 Etapa 1 — Modelação Conceptual (DER)

**Objetivo:** Criar o Diagrama Entidade-Relacionamento (DER) que representa o domínio do sistema.

### 🧱 Entidades Principais

- **Imóvel** — propriedades geridas pela imobiliária  
- **Cliente** — pode ser proprietário e/ou comprador/arrendatário  
- **Agente** — funcionário responsável por imóveis e contratos  
- **Contrato** — formaliza vendas ou arrendamentos  
- **Pagamento** — regista rendas e comissões  
- **Proposta** — ofertas realizadas por clientes interessados  

### 🔧 Tarefas

- Identificar entidades e atributos (PKs e FKs)
- Definir relacionamentos e cardinalidades
- Representar graficamente no [Draw.io](https://draw.io) ou [dbdiagram.io](https://dbdiagram.io)

### ✅ Boas Práticas

- Usar nomes no singular (Cliente, Imovel)
- Atributos claros (`preco_venda`, `data_inicio`, `estado_imovel`)

**📎 Entregável:** `🖼️ der.png` (e ficheiro `.drawio` se aplicável)

---

## 🧱 Etapa 2 — Modelo Lógico (Modelo Relacional)

**Objetivo:** Converter o DER num modelo relacional completo.

### 🔧 Tarefas

- Criar tabelas correspondentes às entidades  
- Definir tipos de dados (`INT`, `VARCHAR`, `DATE`, `DECIMAL(12,2)`, `BIT`)  
- Definir PKs, FKs e restrições (`NOT NULL`, `CHECK`, `UNIQUE`)  
- Garantir normalização até à 3ª forma normal  

### ✅ Boas Práticas

- Colunas claras e consistentes (`id_cliente`, `id_agente`)  
- `DECIMAL(12,2)` para valores monetários  
- `BIT` para booleanos (0 = Não, 1 = Sim)

**📎 Entregável:** `📄 01_modelo.sql`

---

## 💾 Etapa 3 — Implementação SQL (DDL)

**Objetivo:** Criar fisicamente a base de dados no SQL Server.

### 🔧 Tarefas

- Executar `01_modelo.sql`  
- Criar todas as tabelas e relações com integridade referencial  
- Verificar estrutura com `sp_help` e `sp_fkeys`  

### ✅ Boas Práticas

- Tornar scripts idempotentes:

```sql
IF OBJECT_ID('Imovel', 'U') IS NOT NULL DROP TABLE Imovel;

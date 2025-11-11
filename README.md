# 📘 Projeto Prático — Análise e Acesso a Dados  
**Ano Letivo:** 2025/2026 – 1.º semestre  

## 🏢 Sistema de Gestão Imobiliária ImoUni  

### 1. Introdução  
A **ImoUni** é uma empresa de mediação imobiliária que pretende informatizar os seus processos internos relacionados com:

- Gestão de imóveis  
- Clientes  
- Agentes imobiliários  
- Contratos  

O objetivo do projeto é desenvolver uma **base de dados relacional** em **Microsoft SQL Server**.

---

### 2. Objetivos  

#### Gerais  
Criar uma base de dados que:

- Centralize informações sobre imóveis, clientes e agentes  
- Facilite o registo e acompanhamento de contratos  
- Aumente a eficiência no controlo de comissões e pagamentos  
- Permita gerar relatórios de desempenho comercial  

#### Objetivos Específicos de Negócio  

##### 🏠 Gestão de Imóveis  
Para cada imóvel:

- ID único  
- Tipo (apartamento, moradia, terreno, loja, etc.)  
- Localização (morada, cidade, distrito, código postal)  
- Características (quartos, área, casas de banho, garagem, piscina, etc.)  
- Estado (disponível, reservado, vendido, arrendado, manutenção)  
- Preço de venda ou renda mensal  
- Data de entrada  
- Associado a um agente e a um proprietário

---

##### 👤 Gestão de Clientes  
Tipos:

- **Proprietários**  
- **Compradores/Arrendatários**  

Registos necessários:

- Nome, NIF, contacto telefónico, e-mail, morada  
- Tipo de cliente  
- Histórico de transações  
- Preferências de compra (opcional)  

**Nota:** Um cliente pode ser proprietário e comprador simultaneamente.

---

##### 🧑‍💼 Gestão de Agentes Imobiliários  

- Nome, NIF, contacto  
- Percentagem de comissão  
- Data de início de atividade  
- Histórico de contratos  
- Total de comissões geradas  

---

##### 📄 Gestão de Contratos  

- Tipo (venda ou arrendamento)  
- Data de celebração  
- Valor total ou renda mensal  
- Duração (para arrendamento)  
- Imóvel transacionado  
- Cliente comprador e proprietário  
- Agente responsável  

---

##### 💰 Gestão de Pagamentos e Comissões  

- Registo de pagamentos (data, valor, método)  
- Ligação ao contrato  
- Cálculo da comissão  
- Análise de receitas mensais/anuais  

---

##### 📊 Consultas e Relatórios  

Exemplos:

- Imóveis disponíveis por cidade/faixa de preço  
- Contratos ativos com rendas mensais  
- Vendas e comissões por agente/mês  
- Clientes mais ativos  
- Valor total de imóveis por cidade  

---

### 3. 🔁 Fluxo de Negócio da ImoUni  

#### Etapa 1 — Angariação do Imóvel  

- Agente regista dados do imóvel e do proprietário  
- Dados registados incluem: ID, tipo, localização, características, preço, data, estado, agente, proprietário  

#### Etapa 2 — Promoção e Gestão de Carteira  

- Atualização de informações dos imóveis  
- Consultas por tipo, cidade, preço, área, etc.  

#### Etapa 3 — Atendimento de Clientes Interessados  

- Registo de dados pessoais e preferências de compra  
- Associação com agente  

#### Etapa 4 — Propostas e Negociação  

- Registo de propostas: valor, data, cliente, imóvel, agente  
- Aceitação leva à criação de contrato  

#### Etapa 5 — Celebração do Contrato  

- Criação do contrato com tipo, datas, valores, estado  
- Atualização do estado do imóvel  

#### Etapa 6 — Pagamentos e Comissões  

- Registo de pagamentos: data, valor, tipo, forma, contrato  
- Cálculo da comissão:  
  `Comissão = Valor_Transação × Percentagem_Comissão_Agente`  
- Múltiplos pagamentos por contrato (rendas)  

#### Etapa 7 — Relatórios de Gestão  

Exemplos:

- Total de imóveis por cidade e tipo  
- Transações e comissões por agente  
- Vendas/rendas num período  
- Clientes mais ativos  
- Tempo médio que um imóvel fica disponível  

---

### 4. 🛠️ Requisitos Técnicos e Entregáveis  

- Modelação conceptual (DER) e lógica (modelo relacional)  
- Implementação no SQL Server (DDL, integridade referencial, dados simulados)  
- Pelo menos 10 consultas SQL representativas  
- Relatório final (3–5 páginas) com diagramas, consultas e conclusões  

---

### 5. 📏 Critérios de Avaliação  

| Critério                                 | Peso  |
|------------------------------------------|-------|
| Modelação conceptual e lógica            | 30%   |
| Implementação SQL                        | 30%   |
| Consultas SQL (relevância e correção)    | 20%   |
| Clareza e estrutura do relatório         | 20%   |

---

## 📎 Identificação da Unidade Curricular e Projeto

- **Unidade Curricular:** Análise e Acesso a Dados  
- **Ano Letivo:** 2025/2026 — 1.º Semestre  
- **Curso:** Licenciatura em Engenharia Informática  
- **Instituição:** IPCA - Instituto Politécnico do Cávado e do Ave

---

## 👥 Identificação dos Intervenientes

- **Docente Responsável:** Hélder Quintela
- **Grupo de Trabalho:**  
  - Ricardo Pinto — 14865  
  - Daniel Batista — 20472  
  - Marina Silva — 31029
  - Nuno Oliveira — 31550

- **Título do Projeto:** Sistema de Gestão Imobiliária — *ImoUni*

---


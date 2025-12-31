-- =============================================================
-- 1. DADOS DE CONFIGURAÇÃO (LOOKUPS)
-- =============================================================

-- Distritos
INSERT INTO Distrito (distrito) VALUES 
('Braga'), 
('Porto'), 
('Lisboa'), 
('Viana do Castelo'),
('Faro');

-- Concelhos
INSERT INTO Concelho (concelho, id_distrito) VALUES 
('Barcelos', 1),       -- ID 1
('Braga', 1),          -- ID 2
('Guimarães', 1),      -- ID 3
('Esposende', 1),      -- ID 4
('Vila Nova de Gaia', 2), -- ID 5
('Porto', 2),          -- ID 6
('Matosinhos', 2),     -- ID 7
('Lisboa', 3),         -- ID 8
('Cascais', 3);        -- ID 9

-- Códigos Postais
INSERT INTO CodigoPostal (codigopostal, id_concelho) VALUES 
('4750-100', 1), -- Barcelos Centro
('4750-200', 1), -- Barcelos Periferia
('4710-001', 2), -- Braga Sé
('4715-000', 2), -- Braga Lamaçães
('4800-010', 3), -- Guimarães Centro
('4810-000', 3), -- Guimarães Azurém
('4400-001', 5), -- Gaia
('4100-001', 6), -- Porto Boavista
('4740-001', 4); -- Esposende

-- Estados do Imóvel
INSERT INTO Estado (descricaoestado) VALUES 
('Disponível'),   -- ID 1
('Reservado'),    -- ID 2
('Vendido'),      -- ID 3
('Arrendado'),    -- ID 4
('Retirado');     -- ID 5

-- Tipos de Imóvel
INSERT INTO TipoImovel (descricaotipo) VALUES 
('Apartamento'), 
('Moradia'), 
('Terreno'), 
('Loja'),
('Armazém');

-- Modalidades
INSERT INTO Modalidade (descricaomodalidade) VALUES 
('Venda'), 
('Arrendamento');

-- Tipos de Transação
INSERT INTO TipoTransacao (tipotransacao) VALUES 
('Compra e Venda'), 
('Contrato Arrendamento');

-- Tipos de Documento
INSERT INTO TipoDocumento (tipodocumento) VALUES 
('Escritura Pública'), 
('Contrato Promessa (CPCV)'), 
('Contrato Arrendamento'), 
('Certidão Predial'),
('Recibo de Comissão');

-- Métodos de Pagamento
INSERT INTO MetodoPagamento (metodopagamento) VALUES 
('Transferência Bancária'), 
('Cheque Visado'), 
('Numerário');

-- Estados da Proposta
INSERT INTO EstadoProposta (descricaoestado) VALUES ('Pendente'), ('Aceite'), ('Recusada'), ('Contra-proposta');


-- =============================================================
-- 2. PESSOAS (AGENTES E CLIENTES)
-- =============================================================

-- Agentes (Equipa Comercial)
INSERT INTO Agente (nomeagente, telefone, nifagente, percentagemcomissao) VALUES 
('Rui Mendes', '910000111', '210000111', 0.05), -- O "Craque" (5%)
('Sofia Matos', '920000222', '210000222', 0.05), -- A Especialista em Luxo (5%)
('Pedro Nogueira', '930000333', '210000333', 0.04), -- O Júnior (4%)
('Ana Lima', '960000444', '210000444', 0.06); -- A Chefe de Equipa (6%)

-- Clientes (Mistura de Proprietários e Compradores)
INSERT INTO Cliente (nomecliente, moradacliente, id_codigopostal, nifcliente, telefone, email) VALUES 
-- Proprietários (Vendedores)
('António Silva', 'Rua Direita, 5', 1, '220000001', '911111111', 'antonio@gmail.com'),
('Maria Fernandes', 'Av. Liberdade, 20', 3, '220000002', '922222222', 'maria@hotmail.com'),
('João Santos', 'Rua do Souto, 50', 2, '220000003', '933333333', 'joao.santos@sapo.pt'),
('Empresa ImobNorte Lda', 'Zona Industrial, 10', 4, '500000001', '253000000', 'geral@imobnorte.pt'),
-- Compradores / Arrendatários
('Carlos Sousa', 'Travessa do Sol, 2', 5, '230000001', '915555555', 'carlos.sousa@gmail.com'),
('Beatriz Costa', 'Rua das Flores, 8', 6, '230000002', '966666666', 'bia.costa@outlook.com'),
('Investimentos Globais SA', 'Lisboa Parque, 1', 8, '505050505', '210000000', 'admin@investglobal.com'),
('Tiago Oliveira', 'Rua 25 de Abril, 9', 1, '230000003', '917777777', 'tiago@email.com');

-- =============================================================
-- 3. CATÁLOGO DE IMÓVEIS (O Produto)
-- =============================================================

INSERT INTO CatalogoImovel 
(id_tipoimovel, morada, id_codigopostal, nquartos, area, nwc, garagem, piscina, id_estado, id_modalidade, matriz, valor, datacarteira, id_agente, id_proprietario, latitude, longitude, Ativo) 
VALUES 
-- 1. Apartamento T3 Barcelos (Vendido)
(1, 'Rua D. António Barroso, 40', 1, 3, 120, 2, 1, 0, 3, 1, 'U-1001', 185000.00, '2024-11-01', 1, 1, 41.53, -8.62, 0),

-- 2. Moradia Luxo Braga (Disponível) - A "Jóia da Coroa"
(2, 'Bom Jesus do Monte, Lote 5', 4, 5, 450, 4, 1, 1, 1, 1, 'U-2005', 850000.00, '2025-01-05', 2, 2, 41.55, -8.38, 1),

-- 3. Loja Centro Guimarães (Arrendada)
(4, 'Largo da Oliveira, 10', 5, 0, 60, 1, 0, 0, 4, 2, 'C-3099', 850.00, '2024-12-10', 3, 3, 41.44, -8.29, 1),

-- 4. Terreno Industrial Gaia (Disponível)
(3, 'Zona Industrial Canelas', 7, 0, 2000, 0, 0, 0, 1, 1, 'R-5000', 250000.00, '2025-01-20', 4, 4, 41.10, -8.60, 1),

-- 5. Apartamento T2 Porto Boavista (Vendido)
(1, 'Av. da Boavista, 1500', 8, 2, 95, 2, 1, 0, 3, 1, 'U-6000', 320000.00, '2024-10-15', 2, 4, 41.16, -8.64, 0),

-- 6. Moradia T3 Barcelos Periferia (Disponível)
(2, 'Arcozelo, Rua do Rio', 2, 3, 180, 2, 1, 0, 1, 1, 'U-1050', 230000.00, '2025-02-01', 1, 1, 41.54, -8.63, 1),

-- 7. Apartamento T1 Braga Univ (Arrendado)
(1, 'Gualtar, perto da UM', 4, 1, 50, 1, 0, 0, 4, 2, 'U-2100', 650.00, '2025-01-10', 3, 3, 41.56, -8.39, 1),

-- 8. Ruína / Terreno Esposende (Reservado)
(3, 'Apúlia, Frente Mar', 9, 0, 500, 0, 0, 0, 2, 1, 'R-9000', 150000.00, '2025-02-10', 4, 2, 41.48, -8.77, 1);

-- =============================================================
-- 4. PROPOSTAS (A Negociação)
-- =============================================================

INSERT INTO Proposta (valorproposta, dataproposta, observacoes, id_cliente, id_imovel, id_agente, id_estadoproposta) VALUES 
-- 1. Proposta baixa pelo T3 Barcelos (Recusada)
(160000.00, '2024-11-10', 'Cliente acha que precisa de obras', 5, 1, 1, 3),

-- 2. Proposta boa pelo T3 Barcelos (Aceite) -> Gerou Venda
(180000.00, '2024-11-15', 'Aceite com recheio incluído', 5, 1, 1, 2),

-- 3. Proposta pela Moradia de Luxo (Pendente)
(800000.00, '2025-02-12', 'Sujeito a aprovação bancária', 7, 2, 2, 1),

-- 4. Proposta pela Loja Guimarães (Aceite) -> Gerou Arrendamento
(800.00, '2024-12-15', 'Contrato de 5 anos', 8, 3, 3, 2),

-- 5. Proposta T1 Braga (Recusada)
(500.00, '2025-01-12', 'Estudante', 6, 7, 3, 3),

-- 6. Contra-proposta T1 Braga (Aceite) -> Gerou Arrendamento
(600.00, '2025-01-14', 'Fiadores incluídos', 6, 7, 3, 2),

-- 7. Proposta T2 Porto (Aceite) -> Gerou Venda
(315000.00, '2024-10-20', 'Pronto pagamento', 7, 5, 2, 2);

-- =============================================================
-- 5. TRANSAÇÕES (CONTRATOS FECHADOS)
-- =============================================================

INSERT INTO Transacao 
(id_imovel, id_ativo, id_passivo, id_agente, id_tipotransacao, valorcomissao, duracao, valor, datatransacao, datacontrato, id_proposta) 
VALUES 
-- 1. Venda T3 Barcelos (Veio da Proposta 2)
-- Valor: 180k, Agente Rui (5%) = 9.000€
(1, 5, 1, 1, 1, 9000.00, 0, 180000.00, '2024-12-01', '2024-12-01', 2),

-- 2. Arrendamento Loja Guimarães (Veio da Proposta 4)
-- Valor: 800€, Agente Pedro (4%) = 32€ (sobre 1 renda)
(3, 8, 3, 3, 2, 32.00, 60, 800.00, '2025-01-01', '2025-01-01', 4),

-- 3. Venda T2 Porto (Veio da Proposta 7)
-- Valor: 315k, Agente Sofia (5%) = 15.750€
(5, 7, 4, 2, 1, 15750.00, 0, 315000.00, '2024-11-01', '2024-11-01', 7),

-- 4. Arrendamento T1 Braga (Veio da Proposta 6)
-- Valor: 600€, Agente Pedro (4%) = 24€
(7, 6, 3, 3, 2, 24.00, 12, 600.00, '2025-01-20', '2025-01-20', 6);

-- =============================================================
-- 6. PAGAMENTOS E DOCUMENTOS
-- =============================================================

INSERT INTO PagamentoComissao (datapagamentocomissao, valor, id_metodopagamento, id_transacao) VALUES 
('2024-12-02', 9000.00, 1, 1),   -- Comissão Rui
('2025-01-02', 32.00, 1, 2),     -- Comissão Pedro (Loja)
('2024-11-05', 15750.00, 2, 3),  -- Comissão Sofia
('2025-01-21', 24.00, 3, 4);     -- Comissão Pedro (T1)

INSERT INTO Documentos (id_transacao, id_documento, datarececao, validade) VALUES 
(1, 1, '2024-12-01', '2034-12-01'), -- Escritura Barcelos
(2, 3, '2025-01-01', '2030-01-01'), -- Contrato Loja
(3, 1, '2024-11-01', '2034-11-01'), -- Escritura Porto
(4, 3, '2025-01-20', '2026-01-20'); -- Contrato T1 Braga

-- =============================================================
-- 7. PREFERÊNCIAS (Para queries de prospeção)
-- =============================================================

INSERT INTO Preferencias (id_cliente, id_agente, nquartos, nwc, area, garagem, piscina, id_modalidade, valor, id_concelho) VALUES
(5, 1, 3, 2, 150, 1, 0, 1, 250000.00, 1), -- Carlos ainda procura outra casa em Barcelos
(6, 3, 2, 1, 80, 0, 0, 2, 700.00, 2),     -- Beatriz procura T2 em Braga para arrendar
(7, 2, 0, 0, 1000, 0, 0, 1, 500000.00, 6); -- Empresa Invest quer terrenos no Porto
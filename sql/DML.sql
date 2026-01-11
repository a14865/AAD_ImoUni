-- =============================================================
-- CONSULTA 1
-- Ranking de agentes por desempenho comercial
-- =============================================================
select a.nomeagente Nome, (SUM(DISTINCT t.valor) + SUM(pc.valor)) ValorTotal
from Agente a
inner join Transacao t on t.id_agente = a.id_agente
inner join PagamentoComissao pc on pc.id_transacao = t.id_transacao
where t.data_inicio BETWEEN '2023-06-01' and '2023-06-11'
group by a.nomeagente
order by ValorTotal DESC


-- =============================================================
-- CONSULTA 2
-- Comissão teórica vs comissão efetivamente recebida
-- =============================================================
SELECT 
    a.nomeagente AS Agente,
    ROUND(SUM(t.valor * a.percentagemcomissao), 2) AS ComissaoTeorica,
    ROUND(ISNULL(SUM(pc.valor), 0), 2) AS ComissaoEfetiva,
    ROUND(SUM(t.valor * a.percentagemcomissao) - ISNULL(SUM(pc.valor), 0), 2) AS DiferencaEuros,
    ROUND(
        CASE 
            WHEN SUM(t.valor * a.percentagemcomissao) = 0 THEN 0
            ELSE ((SUM(t.valor * a.percentagemcomissao) - ISNULL(SUM(pc.valor), 0)) / SUM(t.valor * a.percentagemcomissao)) * 100
        END, 2) AS DiferencaPercentual
FROM Agente a
JOIN Transacao t ON a.id_agente = t.id_agente
LEFT JOIN PagamentoComissao pc ON t.id_transacao = pc.id_transacao
GROUP BY a.id_agente, a.nomeagente;

-- =============================================================
-- CONSULTA 3
-- Tempo médio de venda por tipo de imóvel.
-- Dias entre entrada em carteira e data da transação (imóveis efetivamente transacionados).
-- =============================================================
SELECT 
    TI.descricaotipo AS TipoImovel,
    AVG(DATEDIFF(DAY, CI.datacarteira, T.datatransacao)) AS TempoMedioVenda_Dias
FROM Transacao T
INNER JOIN CatalogoImovel CI ON T.id_imovel = CI.id_imovel
INNER JOIN TipoImovel TI ON CI.id_tipoimovel = TI.id_tipoimovel
WHERE T.datatransacao IS NOT NULL
GROUP BY TI.descricaotipo
ORDER BY TempoMedioVenda_Dias;

-- =============================================================
-- CONSULTA 4
-- Imóveis ativos, há mais de X dias em carteira e sem qualquer proposta (consulta atual 15 dias).
-- Estes imóveis precisam de revisão de preço, marketing ou estratégia comercial.
-- =============================================================
DECLARE @Dias INT = 15;
SELECT 
    CI.id_imovel,
    CI.morada,
	CI.id_tipoimovel,
    CI.datacarteira,
    DATEDIFF(DAY, CI.datacarteira, GETDATE()) AS DiasEmCarteira
FROM CatalogoImovel CI
WHERE 
    CI.ativo = 1
    AND DATEDIFF(DAY, CI.datacarteira, GETDATE()) >= @Dias
    AND NOT EXISTS (
        SELECT 1
        FROM Proposta P
        WHERE P.id_imovel = CI.id_imovel
    )
ORDER BY DiasEmCarteira DESC;

-- =============================================================
-- CONSULTA 5
-- Taxa de conversão de propostas em contratos
-- =============================================================
select count(p.id_proposta) Propostas, count(t.id_transacao) Transacoes, (count(t.id_transacao) * 1.0 / count(p.id_proposta)) TaxaConversao
from Transacao t
right join Proposta p on p.id_proposta = t.id_proposta


-- =============================================================
-- CONSULTA 6
-- Eficiência dos agentes na negociação
-- =============================================================
select a.nomeagente Nome, AVG(t.valor) ValorMedioVenda, AVG(p.valorproposta) PropostaMedia, AVG(t.valor - p.valorproposta) DiferencaMedia, (((AVG(t.valor) - AVG(p.valorproposta)) / AVG(p.valorproposta)) * 100) Percentagem
from Agente a
inner join Transacao t on t.id_agente = a.id_agente
inner join Proposta p on p.id_proposta = t.id_proposta
group by a.nomeagente
order by DiferencaMedia ASC


-- =============================================================
-- CONSULTA 7
-- Clientes investidores (recorrentes)
-- =============================================================
SELECT 
    c.nomecliente AS Cliente,  
    COUNT(DISTINCT t.id_imovel) AS NumeroCompras  
FROM Cliente c  
    INNER JOIN Transacao t  
        ON t.id_comprador_arrendatario = c.id_cliente  
    INNER JOIN TipoTransacao tt  
        ON tt.id_tipotransacao = t.id_tipotransacao  
WHERE tt.tipotransacao = 'Compra'  
GROUP BY c.id_cliente, c.nomecliente  
HAVING COUNT(DISTINCT t.id_imovel) > 1; 

-- =============================================================
-- CONSULTA 8
-- Clientes que acumulam papéis no sistema
-- =============================================================
SELECT 
    c.id_cliente, 
    c.nomecliente, 
    c.nifcliente, 
    COUNT(DISTINCT ci.id_imovel) AS total_imoveis_como_proprietario, 
    COUNT(DISTINCT t.id_transacao) AS total_transacoes_como_comprador 
FROM Cliente c 
    INNER JOIN CatalogoImovel ci 
        ON ci.id_proprietario = c.id_cliente 
    INNER JOIN Transacao t 
        ON t.id_comprador_arrendatario = c.id_cliente 
 -- Se restringir “comprador” apenas a compras (e não arrendamentos) 
 -- INNER JOIN TipoTransacao tt 
--ON tt.id_tipotransacao = t.id_tipotransacao 
--WHERE tt.tipotransacao = 'Compra' 
GROUP BY 
    c.id_cliente, 
    c.nomecliente, 
    c.nifcliente 
HAVING 
    COUNT(DISTINCT ci.id_imovel) > 0 
    AND COUNT(DISTINCT t.id_transacao) > 0 
ORDER BY 
    total_imoveis_como_proprietario DESC, 
    total_transacoes_como_comprador DESC; 

-- =============================================================
-- CONSULTA 9
-- Volume mensal de negócio por tipo de transação
-- =============================================================
SELECT 
    YEAR(t.datatransacao) AS Ano,
    MONTH(t.datatransacao) AS Mes,
    tt.tipotransacao AS TipoDeNegocio, 
    ROUND(SUM(t.valor), 2) AS VolumeNegocioTotal
FROM Transacao t
JOIN TipoTransacao tt ON t.id_tipotransacao = tt.id_tipotransacao
GROUP BY 
    YEAR(t.datatransacao), 
    MONTH(t.datatransacao), 
    tt.tipotransacao
ORDER BY 
    Ano DESC, 
    Mes DESC, 
    TipoDeNegocio;

-- =============================================================
-- CONSULTA 10
-- Valor total de imóveis sob gestão por concelho
-- =============================================================
SELECT 
    C.concelho,
    SUM(CI.valor) AS ValorTotalImoveis
FROM CatalogoImovel CI
INNER JOIN CodigoPostal CP ON CI.id_codigopostal = CP.id_codigopostal
INNER JOIN Concelho C ON CP.id_concelho = C.id_concelho
WHERE 
    CI.ativo = 1
    AND NOT EXISTS (
        SELECT 1
        FROM Transacao T
        WHERE T.id_imovel = CI.id_imovel
    )
GROUP BY C.concelho
ORDER BY ValorTotalImoveis DESC;

-- =============================================================
-- CONSULTA 11
--  “Matching” de preferências de clientes vs imóveis disponíveis (recomendação)
-- =============================================================
WITH matches AS ( 
    SELECT 
        c.id_cliente, c.nomecliente, p.id_preferencia, 
        ci.id_imovel, ci.valor, 
        ABS(p.valor_maximo - ci.valor) AS diferenca_ao_valor_maximo, 
        ROW_NUMBER() OVER ( 
            PARTITION BY c.id_cliente, p.id_preferencia 
            ORDER BY ABS(p.valor_maximo - ci.valor) ASC, ci.valor ASC 
        ) AS rn 
    FROM Preferencias p 
        INNER JOIN Cliente c ON c.id_cliente = p.id_cliente 
        INNER JOIN CatalogoImovel ci ON ci.Ativo = 1 
        INNER JOIN CodigoPostal cp ON cp.id_codigopostal = ci.id_codigopostal 
        INNER JOIN Concelho conc ON conc.id_concelho = cp.id_concelho 
    WHERE 
        (p.id_concelho IS NULL OR conc.id_concelho = p.id_concelho) 
        AND (p.id_modalidade IS NULL OR ci.id_modalidade = p.id_modalidade) 
        AND (p.nquartos IS NULL OR ci.nquartos >= p.nquartos) 
        AND (p.nwc IS NULL OR ci.nwc >= p.nwc) 
        AND (p.area IS NULL OR ci.area >= p.area) 
        AND (p.garagem IS NULL OR ci.garagem = p.garagem) 
        AND (p.piscina IS NULL OR ci.piscina = p.piscina) 
        AND (p.valor_minimo IS NULL OR ci.valor >= p.valor_minimo) 
        AND (p.valor_maximo IS NULL OR ci.valor <= p.valor_maximo) 
) 
SELECT * 
FROM matches 
WHERE rn <= 5 
ORDER BY id_cliente, id_preferencia, rn; 

-- =============================================================
-- CONSULTA 12
-- 
-- =============================================================
SELECT 
    t.id_transacao AS ID_Transacao,
    a.nomeagente AS Agente,
    t.datacontrato AS DataContrato,
    ROUND(t.valor * a.percentagemcomissao, 2) AS ComissaoTeorica,
    ROUND(ISNULL(SUM(pc.valor), 0), 2) AS TotalPago,
    ROUND((t.valor * a.percentagemcomissao) - ISNULL(SUM(pc.valor), 0), 2) AS DiferencaEmFalta,
    DATEDIFF(DAY, t.datacontrato, GETDATE()) AS DiasDesdeContrato
FROM Transacao t
JOIN Agente a ON t.id_agente = a.id_agente
LEFT JOIN PagamentoComissao pc ON t.id_transacao = pc.id_transacao
GROUP BY 
    t.id_transacao, 
    a.nomeagente, 
    t.datacontrato, 
    t.valor, 
    a.percentagemcomissao
HAVING (t.valor * a.percentagemcomissao) > ISNULL(SUM(pc.valor), 0)
ORDER BY DiasDesdeContrato DESC;

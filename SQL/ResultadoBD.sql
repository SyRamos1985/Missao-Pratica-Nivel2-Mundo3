
SELECT p.*,pj.cnpj
FROM Pessoa p 
INNER JOIN PessoaJuridica pj ON p.idPessoa = pj.idPessoaJuridica;

SELECT p.*,pf.cpf
FROM Pessoa p 
INNER JOIN PessoaFisica pf ON p.idPessoa = pf.idPessoaFisica;



SELECT
    mv.idMovimentoVenda,
    pr.nome AS Produto,
    p.nome AS Comprador,
    mv.quantidade,
    mv.precoUnitario,
    (mv.quantidade * mv.precoUnitario) AS valorTotal
FROM
    MovimentoVenda mv 
INNER JOIN
    Produto pr ON mv.idProduto = pr.idProduto
INNER JOIN
    PessoaFisica pf ON mv.idComprador = pf.idPessoaFisica
INNER JOIN
    Pessoa p ON pf.idPessoaFisica = p.idPessoa;    


SELECT
    mv.idMovimentoCompra,
    pr.nome AS NomeProduto,
    p.nome AS NomeFornecedor,
    mc.quantidade,
    mc.precoUnitario,
    (mc.quantidade * mc.precoUnitario) AS valorTotal
FROM         
    MovimentoCompra mc
INNER JOIN
    Produto pr ON mc.idProduto = pr.idProduto
INNER JOIN
    PessoaJuridica pj ON mc.idFornecedor = pj.idPessoaJuridica
INNER JOIN
    Pessoa p ON pj.idPessoaJuridica = p.idPessoa;    


SELECT pr.nome AS Produto, SUM(mv.quantidade* mv.precoUnitario) AS ValorTotalSaídas
FROM MovimentoVenda mv
INNER JOIN Produto pr ON mv.idProduto = pr.idProduto
GROUP BY pr.nome;

SELECT pr.nome AS Produto, SUM(mc.quantidade* mc.precoUnitario) AS ValorTotalEntradas
FROM MovimentoCompra mc
INNER JOIN Produto pr ON mc.idProduto = pr.idProduto
GROUP BY pr.nome;

SELECT u.*
FROM Usuario u 
LEFT JOIN MovimentoCompra mc ON u.idOperador = mc.idOperador
WHERE mc.idMovimentoCompra IS NULL;

SELECT u.nome AS Operador, SUM(mc.quantidade*mc.precounitario) AS ValorTotalSaida
FROM MovimentoVenda mv 
INNER JOIN Usuario u ON mv.idOperador = u.idOperador
GROUP BY u.nome;

SELECT u.nome AS Operador, SUM(mc.quantidade*mc.precounitario) AS ValorTotalEntrada
FROM MovimentoCompra mc 
INNER JOIN Usuario u ON mc.idOperador = u.idOperador
GROUP BY u.nome;


SELECT pr.nome AS Produto, SUM(mv.quantidade*mv.precounitario) AS PrecoMedioM
FROM MovimentoVenda mv 
INNER JOIN Produto pr ON mv.idProduto = pr.idProduto
GROUP BY pr.nome;
--consulta para cada linha dentro de outra consulta sem usar join, 

SELECT 
	(SELECT COUNT(ca.AddressID) FROM CustomerAddress AS ca WHERE ca.CustomerID = c.CustomerID) AS QUANTIDADE_ENDERECO,
* FROM Customer AS c
WHERE 
--(SELECT COUNT(ca.AddressID) FROM CustomerAddress AS ca WHERE ca.CustomerID = c.CustomerID) > 1
	NOT EXISTS (SELECT * FROM CustomerAddress AS ca WHERE ca.CustomerID = c.CustomerID)
--EXISTS (SELECT * FROM CustomerAddress AS ca WHERE ca.CustomerID = c.CustomerID)

 



--SELECT * FROM CustomerAddress AS ca

--SELECT * FROM Address AS a 
	
--Clausula WHERE (Suponha que você queira encontrar todos os clientes que fizeram pelo menos um pedido.)

SELECT c.FirstName 
FROM Customer c 
WHERE c.CustomerID IN (SELECT c.CustomerID FROM SalesOrderHeader as soh);

--Aqui, a subconsulta (SELECT c.CustomerID FROM SalesOrderHeader as soh) retorna uma lista de IDs de clientes que fizeram pedidos, e a consulta externa usa essa lista para filtrar os clientes.


--Subconsultas na cláusula SELECT são usadas para retornar um valor calculado ou agregado como parte do resultado da consulta principal.
--Exemplo:
--Suponha que você queira retornar o nome de cada cliente junto com o número total de pedidos que ele fez.

SELECT c.FirstName , 
       (SELECT COUNT(*) 
        FROM SalesOrderHeader soh  
        WHERE soh.CustomerID  = c.CustomerID) AS total_pedidos
FROM Customer c ;


--Subconsulta na cláusula FROM
--São usadas para criar uma tabela temporária que pode ser usada na cunsulta principal 

SELECT AVG(total_pedidos) AS media_pedidos
FROM (SELECT soh.CustomerID, COUNT(*) AS total_pedidos
      FROM SalesOrderHeader soh 
      GROUP BY soh.CustomerID) AS subquery;

--Aqui, a subconsulta ((SELECT soh.CustomerID, COUNT(*) AS total_pedidos FROM SalesOrderHeader soh GROUP BY soh.CustomerID) 
--cria uma tabela temporária com o número total de pedidos por cliente, e a consulta externa calcula a média desses valores.

-- subconsula na cláusula HAVING
--são usadas para filtrar resultados de agregações com base no resultado da consulta interna.
SELECT soh.CustomerID, COUNT(*) AS total_pedidos
FROM SalesOrderHeader soh 
GROUP BY soh.CustomerID
HAVING COUNT(*) > (SELECT AVG(total_pedidos)
                   FROM (SELECT COUNT(*) AS total_pedidos
                         FROM SalesOrderHeader soh 
                         GROUP BY soh.CustomerID) AS subquery);

--Aqui, a subconsulta interna calcula a média de pedidos por cliente, e a cláusula HAVING filtra os clientes que têm mais pedidos que essa média.

-- subconsultas correlacionadas
SELECT soh.SalesOrderID, soh.OrderDate, soh.TotalDue
FROM SalesOrderHeader soh
WHERE EXISTS (
    SELECT 1
    FROM Customer c
    INNER JOIN CustomerAddress ca ON c.CustomerID = ca.CustomerID
    INNER JOIN Address a ON ca.AddressID = a.AddressID
    WHERE c.CustomerID = soh.CustomerID
      AND a.City = 'Bothell'
);


-- subconsultas na cláusula UPDATE
UPDATE clientes
SET saldo = saldo + 100
WHERE id IN (SELECT cliente_id
             FROM pedidos
             WHERE data_pedido >= '2023-01-01');

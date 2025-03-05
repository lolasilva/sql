
--Tabela virtual que é criada a partir de uma consulta SQL.
--A view não armazena dados fisicamente, mas sim em uma consulta que é executada semque que a view for acessada

CREATE VIEW VW_CUSTOMER_ADRESS
AS
SELECT c.CustomerID, a.AddressID, c.FirstName, a.AddressLine1, a.City 
FROM Customer c 
INNER JOIN CustomerAddress ca 
ON c.CustomerID = ca.CustomerID 
inner join Address a 
on a.AddressID = ca.AddressID 

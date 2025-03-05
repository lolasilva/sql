--COALICE A função COALESCE em SQL é utilizada para retornar o primeiro valor não nulo em uma lista de expressões. Ela é bastante útil quando você deseja substituir valores nulos por um valor padrão ou por outro valor de sua escolha
--COALESCE(expressão1, expressão2, ..., expressãoN)

SELECT 
	AddressID, 
	AddressLine1, 
	AddressLine2, 
	--Isnull(AddressLine2,'Nao tem endereco 2')
	COALESCE(AddressLine2, AddressLine1, 'Nenhum telefone disponível') 
	--NULLIF (Address.AddressLine1, '8713 Yosemite''Ct8713 Yosemite Ct')
	AS endereco
FROM Address 


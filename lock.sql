--garantir que apenas uma transação possa atualizar a tabela de saldo por vez
--O lock exclusivo garante que nenhuma outra transação possa ler ou modificar a tabela saldos até que a transação atual seja concluída.
--O lock é liberado automaticamente após o COMMIT.

BEGIN TRANSACTION;

-- Aplica um lock exclusivo na tabela
LOCK TABLE saldos IN EXCLUSIVE MODE;

-- Atualiza o saldo
UPDATE saldos
SET saldo = saldo - 100
WHERE conta_id = 1;

COMMIT;

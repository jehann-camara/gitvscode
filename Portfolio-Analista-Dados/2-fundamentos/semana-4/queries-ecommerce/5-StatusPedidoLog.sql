
-- Estudos Sql na DIO // By Jehann C�mara
-- Insert StatusPedidoLog

USE ecommerce;

select * from statusPedidoItem

insert StatusPedidoLog
select idPedido, idProduto,3,getdate() as 'Data Status Pedido'
from pedidoItem

select * from StatusPedidoLog
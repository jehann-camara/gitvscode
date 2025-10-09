
-- Estudos Sql na DIO // By Jehann Câmara
-- Constraints de chaves primárias e estrageiras

USE ecommerce;

-- adicionando constraints de chaves prim�rias
ALTER TABLE Clientes ADD CONSTRAINT Pk_IdCliente PRIMARY KEY (IdCliente)

ALTER TABLE Pedidos ADD CONSTRAINT Pk_IdPedido PRIMARY KEY (IdPedido)

ALTER TABLE Produtos ADD CONSTRAINT Pk_IdProduto PRIMARY KEY (IdProduto)

ALTER TABLE PedidoItem ADD CONSTRAINT Pk_PedidoItem PRIMARY KEY (IdPedido)

-- adicionando constraints de chaves estrageiras
ALTER TABLE Pedidos ADD CONSTRAINT Fk_IdCliente FOREIGN KEY (IdCliente) REFERENCES Clientes (IdCliente)

ALTER TABLE PedidoItem ADD CONSTRAINT Fk_IdPedido FOREIGN KEY (IdProduto) REFERENCES Produtos (IdProduto)

--alter table PedidoItem add constraint Fk_IdPedidoItem foreign key (IdPedido) references Pedidos(IdPedido)
-- Selects Principais
SELECT *
FROM Clientes -- alt + F1

SELECT *
FROM Pedidos -- alt + F1

SELECT *
FROM STATUS -- alt + F1
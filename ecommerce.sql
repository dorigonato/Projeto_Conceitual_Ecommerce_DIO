-- Criação do BD E-COMMERCE
create database ecommerce;
use ecommerce;

-- tabela Cliente --
create table clients(
	idClient INT AUTO_INCREMENT,
	Fname VARCHAR(15),
	Minit VARCHAR(3),
	Lname VARCHAR(20),
	CPF CHAR(11) NOT NULL,
	Address VARCHAR(255),
	CONSTRAINT unique_cpf_client UNIQUE (CPF),
	PRIMARY KEY(idClient)
	);

alter table clients auto_increment=1;
desc clients;

-- tabela Produto --
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT,
	Pname VARCHAR(15) NOT NULL,
	Classification_kids BOOL DEFAULT FALSE,
	Category ENUM('Eletronico', 'Vestimenta', 'Brinquedos', 'Esportes', 'Alimentos','Veiculos') NOT NULL,
	Feedback FLOAT DEFAULT 0,
	Size VARCHAR(10),
	PRIMARY KEY(idProduct)
	);

alter table product auto_increment=1;
                    
-- tabela Pedido
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT,
	idOrderClient INT,
	OrderStatus ENUM('Cancelado', 'Confirmado', 'Em Processamento') DEFAULT 'Em Processamento',
	OrderDescription VARCHAR(255),
	ShippingCost FLOAT DEFAULT 10,
	CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) references clients(idClient),
	PRIMARY KEY(idOrder)   
	);
alter table orders auto_increment=1;

-- tabela Estoque
CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT,
	StorageLocation VARCHAR(255),
	Quantity INT DEFAULT 0,
	PRIMARY KEY(idProdStorage)  
	);

alter table productStorage auto_increment=1;
                    
                    
-- tabela Fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT,
	SocialName VARCHAR(255) NOT NULL,
	CNPJ CHAR(15) NOT NULL,
	Contact CHAR(11) not null,
	CONSTRAINT unique_supplier UNIQUE (CNPJ),
	PRIMARY KEY(idSupplier) 
	);

alter table supplier auto_increment=1;
desc supplier;
				
-- tabela Vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT,
	SocialName VARCHAR(255) NOT NULL,
	AbstName VARCHAR(255),
	CNPJ CHAR(15),
	CPF CHAR(9),
	Location VARCHAR(255),
	Contact CHAR(11) not null,
	CONSTRAINT unique_CNPJ_seller UNIQUE (CNPJ),
	CONSTRAINT unique_CPF_seller UNIQUE (CPF),
	PRIMARY KEY(idSeller) 
	);
                    
alter table seller auto_increment=1;

-- Tabela produto/vendedor
create table productSeller(
	idPseller INT,
	idPproduct INT,
	ProdQuantity INT DEFAULT 1,
	PRIMARY KEY (idPseller, idPproduct),
	CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
	CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product(idProduct)
	);
                            
-- Produto/Pedido
create table productOrder(
	idPOproduct INT,
	idPOorder INT,
	PoQuantity INT DEFAULT 1,
	poStatus ENUM('Disponivel',  'Sem Estoque') DEFAULT 'Disponivel',
	PRIMARY KEY (idPOproduct, idPOorder),
	CONSTRAINT fk_productOrder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
	CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
	);

-- Estoque/Produto
create table storeagelocation(
	idLproduct INT,
	idLstorage INT,
	location VARCHAR(255) NOT NULL,
	PRIMARY KEY (idLproduct, idLstorage),
	CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
	CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
	);                    
				
create table ProductSupplier(
	idPsSupplier INT,
	idPsProduct INT,
	Quantity INT NOT NULL,
	PRIMARY KEY (idPsSupplier, idPsProduct),
	CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
	CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
	);     


show tables;

show databases;
use information_schema;
show tables;
desc referential_CONSTRAINTS;
select * from referential_constraints where CONSTRAINT_SCHEMA= 'ecommerce';

INSERT INTO clients (Fname, Minit, Lname, CPF, Address)
VALUES 
('Ana', 'M.', 'Silva', '12345678901', 'Rua das Flores, 123'),
('Bruno', 'A.', 'Oliveira', '23456789012', 'Avenida Paulista, 456'),
('Carla', 'B.', 'Santos', '34567890123', 'Rua do Comércio, 789'),
('Daniel', 'C.', 'Souza', '45678901234', 'Praça Central, 321'),
('Eduardo', 'D.', 'Ferreira', '56789012345', 'Rua Primavera, 654'),
('Fernanda', 'E.', 'Lima', '67890123456', 'Alameda das Rosas, 987'),
('Gustavo', 'F.', 'Costa', '78901234567', 'Rua das Palmeiras, 111'),
('Helena', 'G.', 'Martins', '89012345678', 'Avenida Brasil, 222'),
('Isabela', 'H.', 'Almeida', '90123456789', 'Rua Azul, 333'),
('João', 'I.', 'Pereira', '01234567890', 'Rua das Acácias, 444'),
('Karina', 'J.', 'Rodrigues', '11234567890', 'Avenida Central, 555'),
('Luiz', 'K.', 'Barbosa', '12234567890', 'Rua do Sol, 666'),
('Mariana', 'L.', 'Nascimento', '13234567890', 'Travessa do Norte, 777'),
('Nathan', 'M.', 'Carvalho', '14234567890', 'Rua das Violetas, 888'),
('Olivia', 'N.', 'Ribeiro', '15234567890', 'Avenida Atlântica, 999'),
('Paulo', 'O.', 'Vieira', '16234567890', 'Rua do Campo, 101'),
('Quezia', 'P.', 'Monteiro', '17234567890', 'Alameda Verde, 202'),
('Rafael', 'Q.', 'Teixeira', '18234567890', 'Rua das Pedras, 303'),
('Sofia', 'R.', 'Batista', '19234567890', 'Avenida Sul, 404'),
('Tiago', 'S.', 'Mendes', '20234567890', 'Rua das Cerejeiras, 505');

SHOW GRANTS FOR 'root'@'localhost';	
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
USE ecommerce;

SELECT * FROM clients

INSERT INTO product (Pname, Classification_kids, Category, Feedback, Size)
VALUES 
('Smartphone', FALSE, 'Eletronico', 4.5, '15x7cm'),
('Notebook', FALSE, 'Eletronico', 4.8, '35x25cm'),
('Camiseta', FALSE, 'Vestimenta', 4.2, 'M'),
('Boneca', TRUE, 'Brinquedos', 4.6, '30cm'),
('Bicicleta', FALSE, 'Esportes', 4.7, 'M'),
('Chocolate', FALSE, 'Alimentos', 4.9, '200g'),
('Carrinho RC', TRUE, 'Brinquedos', 4.3, '25cm'),
('Tablet', FALSE, 'Eletronico', 4.4, '20x12cm'),
('Jaqueta', FALSE, 'Vestimenta', 4.1, 'G'),
('Patins', TRUE, 'Esportes', 4.5, '38'),
('Monitor', FALSE, 'Eletronico', 4.6, '24"'),
('Lancheira', TRUE, 'Brinquedos', 4.3, '30x20cm'),
('Tênis', FALSE, 'Vestimenta', 4.7, '42'),
('Console', FALSE, 'Eletronico', 4.8, '30x25cm'),
('Bola de Futebol', TRUE, 'Esportes', 4.9, 'Oficial'),
('Queijo', FALSE, 'Alimentos', 4.4, '500g'),
('Skate', TRUE, 'Esportes', 4.6, '80cm'),
('Relógio', FALSE, 'Eletronico', 4.2, 'Único'),
('Calça Jeans', FALSE, 'Vestimenta', 4.3, '42'),
('Livro Infantil', TRUE, 'Brinquedos', 4.8, '25x20cm'),
('Moto Elétrica', TRUE, 'Veiculos', 4.5, 'Infantil'),
('Roteador', FALSE, 'Eletronico', 4.7, 'Pequeno'),
('Shorts', FALSE, 'Vestimenta', 4.1, 'M'),
('Puzzle 500 peças', TRUE, 'Brinquedos', 4.6, '30x20cm'),
('Chuteira', TRUE, 'Esportes', 4.8, '39'),
('Cereal', FALSE, 'Alimentos', 4.4, '400g'),
('Hoverboard', TRUE, 'Veiculos', 4.7, 'Médio'),
('Mouse Gamer', FALSE, 'Eletronico', 4.5, 'Único'),
('Vestido', FALSE, 'Vestimenta', 4.3, 'P'),
('Ursinho de Pelúcia', TRUE, 'Brinquedos', 4.9, '50cm'),
('Bola de Basquete', TRUE, 'Esportes', 4.6, 'Oficial'),
('Iogurte', FALSE, 'Alimentos', 4.2, '500ml'),
('Bicicleta Infantil', TRUE, 'Veiculos', 4.8, 'Pequena'),
('Fone Bluetooth', FALSE, 'Eletronico', 4.7, 'Único'),
('Blusa', FALSE, 'Vestimenta', 4.5, 'G'),
('Quebra-cabeça 1000 peças', TRUE, 'Brinquedos', 4.4, 'Grande'),
('Raquete de Tênis', FALSE, 'Esportes', 4.6, 'Padrão'),
('Barra de Chocolate', FALSE, 'Alimentos', 4.3, '150g'),
('Patinete', TRUE, 'Veiculos', 4.7, 'Médio'),
('Teclado', FALSE, 'Eletronico', 4.5, 'Padrão');

ALTER TABLE product
MODIFY COLUMN Pname VARCHAR(45) NOT NULL;
SELECT * FROM product

INSERT INTO orders (idOrderClient, OrderStatus, OrderDescription, ShippingCost)
VALUES 
(1, 'Confirmado', 'Pedido de eletrônicos diversos', 15.00),
(2, 'Em Processamento', 'Pedido de roupas esportivas', 10.00),
(3, 'Cancelado', 'Pedido de brinquedos cancelado', 0.00),
(4, 'Confirmado', 'Pedido de alimentos', 12.50),
(5, 'Em Processamento', 'Pedido de acessórios automotivos', 20.00),
(6, 'Confirmado', 'Pedido de utensílios domésticos', 18.00),
(7, 'Cancelado', 'Pedido de produtos de beleza cancelado', 0.00),
(8, 'Confirmado', 'Pedido de equipamentos esportivos', 22.00),
(9, 'Em Processamento', 'Pedido de eletrônicos', 10.00),
(10, 'Confirmado', 'Pedido de roupas casuais', 15.00),
(11, 'Em Processamento', 'Pedido de produtos para casa', 11.00),
(12, 'Confirmado', 'Pedido de itens diversos', 17.50),
(13, 'Cancelado', 'Pedido de livros cancelado', 0.00),
(14, 'Confirmado', 'Pedido de acessórios eletrônicos', 13.00),
(15, 'Em Processamento', 'Pedido de artigos de escritório', 9.50);

SELECT * FROM orders

INSERT INTO productStorage (StorageLocation, Quantity)
VALUES
('Depósito Central - Setor A', 150),
('Depósito Secundário - Setor B', 200),
('Armazém Externo - Zona Norte', 75),
('Depósito Principal - Setor C', 300),
('Estoque de Vendas - Loja 1', 50);

SELECT * FROM productStorage

INSERT INTO supplier (SocialName, CNPJ, Contact)
VALUES
('Fornecedora Alfa Ltda', '12345678000199', '11987654321'),
('Comercial Beta S.A.', '22345678000188', '11976543210'),
('Distribuidora Gamma EPP', '32345678000177', '11965432109'),
('Indústria Delta ME', '42345678000166', '11954321098'),
('Importadora Epsilon', '52345678000155', '11943210987'),
('Exportadora Zeta', '62345678000144', '11932109876'),
('Logística Eta Ltda', '72345678000133', '11921098765'),
('Fornecedor Theta S.A.', '82345678000122', '11910987654'),
('Comércio Iota EIRELI', '92345678000111', '11909876543'),
('Distribuidora Kappa', '10345678000100', '11998765432'),
('Indústria Lambda ME', '11345678000188', '11987654322'),
('Empresa Mu Ltda', '12345678000177', '11976543211');

SELECT * FROM supplier

INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, Location, Contact)
VALUES
('Vendedor Alfa Ltda', 'Alfa', '12345678000199', NULL, 'São Paulo - SP', '11987654321'),
('Vendedor Beta S.A.', 'Beta', NULL, '123456789', 'Rio de Janeiro - RJ', '11976543210'),
('Comércio Gamma EPP', 'Gamma', '22345678000188', NULL, 'Belo Horizonte - MG', '11965432109'),
('Distribuidora Delta ME', 'Delta', NULL, '234567890', 'Curitiba - PR', '11954321098'),
('Fornecedor Epsilon', 'Epsilon', '32345678000177', NULL, 'Porto Alegre - RS', '11943210987'),
('Vendas Zeta Ltda', 'Zeta', NULL, '345678901', 'Brasília - DF', '11932109876'),
('Indústria Eta S.A.', 'Eta', '42345678000166', NULL, 'Salvador - BA', '11921098765'),
('Loja Theta ME', 'Theta', NULL, '456789012', 'Recife - PE', '11910987654'),
('Empresa Iota', 'Iota', '52345678000155', NULL, 'Fortaleza - CE', '11909876543'),
('Comercial Kappa Ltda', 'Kappa', NULL, '567890123', 'Manaus - AM', '11998765432');

SELECT * FROM seller

-- Recuperar todos os produtos cadastrados --
SELECT idProduct, Pname, Category, Feedback, Size
FROM product;

-- Recuperar todos os clientes cadastrados --
SELECT idClient, Fname, Minit, Lname, CPF, Address
FROM clients;

-- Produtos da categoria 'Eletrônico' --
SELECT idProduct, Pname, Category, Feedback
FROM product
WHERE Category = 'Eletronico';

-- Clientes com CPF terminado em '5' --
SELECT idClient, Fname, Lname, CPF
FROM clients
WHERE CPF LIKE '%5';

-- Calcular custo total do pedido (quantidade x frete) --
SELECT idOrder, idOrderClient, ShippingCost, ShippingCost * 1.2 AS TotalComTaxa
FROM orders;

-- Concatenar nome completo do cliente --
SELECT idClient, CONCAT(Fname, ' ', Minit, ' ', Lname) AS NomeCompleto
FROM clients;

-- Ordenar produtos por feedback (do maior para o menor) --
SELECT idProduct, Pname, Category, Feedback
FROM product
ORDER BY Feedback DESC;

-- Ordenar clientes pelo primeiro nome em ordem alfabética --
SELECT idClient, Fname, Lname, CPF
FROM clients
ORDER BY Fname ASC;

-- Exibir categorias de produtos com média de feedback superior a 4 --
SELECT Category, AVG(Feedback) AS MediaFeedback
FROM product
GROUP BY Category
HAVING AVG(Feedback) > 4;

-- Pedidos com informações dos clientes --
SELECT o.idOrder, o.OrderDescription, c.Fname, c.Lname, o.ShippingCost
FROM orders o
JOIN clients c ON o.idOrderClient = c.idClient;






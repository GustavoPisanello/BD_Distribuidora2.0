create database dbDistribuidoraLTDA;
use dbDistribuidoraLTDA;

/* pedido, produto, fornecedor, nota fiscal, compraprod*/

create table Cliente(
	idCli int primary key,
    CEP bigint(9),
    endereco int,
    foreign key (endereco) references Endereco (endereco),
	NumEndereco char(3),
    CompEnd varchar(50)
);

create table Cliente_PJ(
	CNPJ bigint(14) primary key,
    IE bigint(9),
    idCli int,
    foreign key(idCli) references Cliente (idCli)
);

create table Cliente_PF(
	CPF bigint(11) primary key,
    RG bigint(7),
    DataNasc date,
    RG_Dig char(2),
    idCli int,
    foreign key(idCli) references Cliente (idCli)
);

create table Endereco(
	endereco int primary key,
    IdUF int,
    foreign key (IDUF) references Estado(IDUF),
    idCidade int,
    foreign key (idcidade) references Cidade(Idcidade),
	CEP bigint(9),
    foreign key (CEP) references bairro(CEP)
);

create table Estado(
	UF varchar(2),
    IdUF int primary key
);

create table Cidade(
	IdCidade int primary key,
    NomeCidade varchar(50)
);
create table bairro(
	NomeBairro varchar(50),
	logradouro varchar(200),
    CEP bigint(9) primary key
);

create table ProdutoVenda(
	ValorItem decimal (6,2),
    Qtd int not null,
	codBarras bigint(14),
    foreign key (codBarras) references Produto (codBarras),
    idVenda int,
    foreign key (idVenda) references Venda(idVenda)
);

create table Venda(
	idVenda int primary key,
    dataVenda date default current_timestamp(),
    valorTot decimal(6,2),
    idCli int not null,
    foreign key(idCli) references Cliente (idCli),
    idNota int not null,
    foreign key (idNota) references NotaFiscal (idNota)
);

create table NotaFiscal(
	idNota int primary key,
	dataEmissao date not null,
    totalNota decimal(6,2) not null
);

create table Fornecedor(
	idFornec int primary key,
    CNPJ bigint(14) not null,
    nomeFornec varchar(200) not null,
    telefone bigint(11) 
);

create table Produto(
    codBarras bigint(14) primary key,
    nomeProd varchar(200) not null,
    valorProd decimal(6,2) not null,
    Qtd int 
);

create table CompraProduto(
	ValorItem decimal (6,2) not null,
    Qtd int not null,
	codBarras bigint(14) not null,
    foreign key (codBarras) references Produto (codBarras),
    notaFiscal int not null,
    foreign key (notaFiscal) references  Compra (notaFiscal)
);

create table Compra(
    idFornec int not null,
    foreign key (idFornec) references Fornecedor(idFornec),
    notaFiscal int primary key,
    dataCompra date not null,
    valorTotal decimal (6,2) not null,
    quantTotal int not null
);

insert into Fornecedor 
values (1, 1245678937123 ,"Revenda Chico Loco", 11934567897  );

insert into Fornecedor 
values (2, 1345678937123 ,"José Faz Tudo", 11934567898);

insert into Fornecedor 
values (3, 1445678937123 ,"Vadalto Entregas", 11934567899);

insert into Fornecedor 
values (4, 1545678937123,"Astrogildo das Estrelas", 11934567800  );

insert into Fornecedor 
values (5, 1645678937123,"Amoroso e Doce", 11934567801  );

insert into Fornecedor 
values (6, 1745678937123,"Marcelo Dedal", 11934567802  );

insert into Fornecedor 
values (7, 1845678937123,"Franciscano Cachaça", 11934567803);

insert into Fornecedor 
values (8, 1945678937123,"Amoroso e Doce", 11934567804);
 
select * from Fornecedor;

delete from Fornecedor where idFornec = 8;

select cnpj from Fornecedor where Nome = 'Amoroso e Doce';

DELIMITER $$
create procedure insereCid(COD int, Nome varchar(100))
begin
	if(not exists(Select idCidade from Cidade where idCidade = COD and NomeCidade = Nome)) then
		insert into Cidade values (COD, Nome);
	else
		select"Insira os Dados corretamente";
	end if;
end $$

call insereCid("1","Rio de Janeiro");
call insereCid("2","São Carlos");
call insereCid("3","Campinas");
call insereCid("4","Franco da Rocha");
call insereCid("5","Osasco");
call insereCid("6","Pirituba");
call insereCid("7","Lapa");
call insereCid("8","Ponta Grossa");

select * from Cidade;	

DELIMITER $$
create procedure insereEstado(SiglaUF char(2), COD int)
begin
	if(not exists(select idUF from Estado where idUF = COD and UF = SiglaUF)) then
		insert into Estado values(idUF, COD);
	else
		select"Insira os dados corretamente";
        end if;
end$$;

call insereEstado("SP", "1");
call insereEstado("RJ", "2");
call insereEstado("RS", "3");

select * from Estado;

DELIMITER $$
create procedure insereBairro(bairro varchar(100), logra varchar(100), IdBairro int) 
begin
	if(not exists(select CEP from Bairro where CEP = IdBairro and NomeBairro = bairro)) then
		insert into Bairro values(bairro, logra, Idbairro);
        else
        select"Insira os dados corretamente";
        end if;
end$$

call insereBairro("Aclimação","" ,"1");
call insereBairro("Capão Redondo","" ,"2");
call insereBairro("Pirituba","" ,"3");
call insereBairro("Liberdade","" ,"4");

select * from Bairro
DELIMITER $$
create procedure insereProd(COD bigint(14), Nome varchar(200), Valor decimal(6,2), Quantidade int) 
begin
	if(not exists(select codBarras from Produto where codBarras = COD and Nome = nomeProd)) then
		insert into Produto values(COD, Nome, Valor, Quantidade);
        else
        select"Insira os dados corretamente";
        end if;
end$$

call insereProd("1234568791011","Rei do Papel Mache","54.61","120");
call insereProd("1234568791012","Bolinha de Sabão","100.45","120");
call insereProd("1234568791013","Carro Bate Bate","44.00","120");
call insereProd("1234568791014","Bola Furada","10.00","120");
call insereProd("1234568791015","Maça Laranja","99.44","120");
call insereProd("1234568791016","Boneco do Hitler","124.50","200");
call insereProd("1234568791017","Farinha de Surui","50.00","200");
call insereProd("1234568791018","Zelador de cemitério","24.50","120");

select * from Produto;
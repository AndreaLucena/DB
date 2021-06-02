4ª ATIVIDADE PROJETO BANCO DE DADOS

1) Ocálculo da comissão baseado no valor do totalde vendas, foi realizado a partir   de   gatilhos   desenvolvidos em aula.
Porém,   estamos   somandomanualmente seus itens e inserindo no campon_totavenda.
Isso pode fazer com que algum erro ocorra, diferentementede quando se insere a partir de uma  aplicação
Entretanto,  podemos  fazer  comque  esse  cálculo  seja realizado automaticamente, utilizando uma trigger.Desta  vez, utilizeos  tipos after  insert(depois  de inserir)  eafter  update(depois de alterar) na tabela comivenda(itens da venda),para que, depois de  inserir  os  produtos,  o  valor  do  seu  total  seja  calculado  e  ocampo n_totavendaseja atualizado.

/*******************************/
DELIMITER %%
CREATE TRIGGER tri_vendas_ai
AFTER INSERT ON comivenda for each row

BEGIN
	SET vtotal_item = NEW.n_valoivenda * NEW.n_qtdeivenda;
    
	UPDATE comvenda SET n_totavenda = vtotal_itens - vtotal_item
	WHERE n_numevenda = new.n_numevenda;
end %%
DELIMITER;

    DECLARE vtotal_itens float(10,2) DEFAULT 0;
	DECLARE vtotal_item float(10,2) DEFAULT 0;
	DECLARE total_item float(10,2);
    DECLARE qtd_item INT DEFAULT 0;
    DECLARE fimloop INT DEFAULT 0;
    
	DECLARE busca_itens cursor for
		SELECT n_valoivenda, n_qtdeivenda
		FROM comivenda
		WHERE n_numevenda = new.n_numevenda;
    
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET fimloop = 1;
    
	OPEN busca_itens;
		itens : loop
            
			IF fimloop = 1 THEN
				LEAVE itens;
			END IF;
        
			fetch busca_itens into total_item, qtd_item;
			
			SET vtotal_item = total_item * qtd_item;
			SET vtotal_itens = vtotal_itens + vtotal_item;
            
		END loop itens;
CLOSE busca_itens;
    SET vtotal_item = NEW.n_valoivenda * NEW.n_qtdeivenda;
	UPDATE comvenda SET n_totavenda = vtotal_itens - vtotal_item
	WHERE n_numevenda = NEW.n_numevenda;
END %%
DELIMITER ;
    

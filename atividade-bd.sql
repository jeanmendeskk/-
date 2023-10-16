-- Consigo imaginar a utilização de cursores em alguns outros casos, como usar para achar um livro de algum autor específico, também é possível usar os cursores para atualizar coisas, como exemplo, uma alteração em preços de livros de um gênero específico, dá pra usar cursores como verificação de integridade de dados entre as tabelas.  

-- Para realizar isso de forma eficiente eu crio uma procedure que usa cursores para exibir as informações das tabelas, segue um código de exemplo: 

DELIMITER //
CREATE PROCEDURE sp_RelateBooksAuthorsGenres()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE v_titulo VARCHAR(255);
    DECLARE v_autor_nome VARCHAR(255);
    DECLARE v_genero_nome VARCHAR(255);

    DECLARE cursor_livros CURSOR FOR
    SELECT L.titulo, A.nome AS autor, G.nome AS genero
    FROM Livro L
    JOIN Livro_Autor LA ON L.id_livro = LA.id_livro
    JOIN Autor A ON LA.id_autor = A.id_autor
    JOIN Genero G ON L.id_genero = G.id_genero;
    OPEN cursor_livros;
    fetch_loop: LOOP
        FETCH cursor_livros INTO v_titulo, v_autor_nome, v_genero_nome;
        IF done THEN
            LEAVE fetch_loop;
        END IF;
        SELECT CONCAT('Livro: ', v_titulo, ', Autor: ', v_autor_nome, ', Gênero: ', v_genero_nome) AS BookInfo;
    END LOOP fetch_loop;
    CLOSE cursor_livros;
END;
//
DELIMITER ;

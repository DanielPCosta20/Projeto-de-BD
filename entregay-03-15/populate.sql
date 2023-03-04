INSERT INTO categoria(nome)
VALUES
    ('fruta'),
	('vegetais'),
	('leite'),
	('peixe'),
	('carne de porco'),
    
	('carne de vaca'),
	('frango'),
	('perú'),
	('fast food'),
	('sobremesa'),
    
	('bebida com álcool'),
	('bebida sem álcool'),
	('congelados'),
	('bebidas'),
	('queijo creme'),
    ('gelados'),
    ('refrigerante'),
    
	('natas'),
	('queijo'),
	('iogurte'),
	('carne');

INSERT INTO categoria_simples(nome)
VALUES
    ('fruta'),
	('vegetais'),
    ('peixe'),
	('carne de porco'),
	('carne de vaca'),
    ('gelados'),
    ('refrigerante'),
    ('bebida com álcool'),

    ('frango'),
	('perú'),
	('fast food'),
	('sobremesa'),

    ('queijo creme'),
	('natas'),
	('queijo'),
	('iogurte');

INSERT INTO super_categoria(nome)
VALUES 
    ('congelados'),
    ('bebidas'),
    ('leite'),
    ('bebida sem álcool'),
    ('carne');

INSERT INTO tem_outra(categoria, super_categoria)
VALUES 
    ('carne de porco', 'carne'),
	('carne de vaca', 'carne'),
	('frango', 'carne'),
	('perú', 'carne'),
    ('bebida com álcool', 'bebidas'),
	('bebida sem álcool', 'bebidas'),
    ('refrigerante', 'bebida sem álcool'),
    ('gelados','congelados'),
	('queijo creme', 'leite'),
	('natas', 'leite'),
	('queijo', 'leite'),
	('iogurte', 'leite');

INSERT INTO produto(ean, descr, cat)
VALUES 
    (0123456789001, 'ananás', 'fruta'),
    (0123456789002, 'banana', 'fruta'),
    (0123456789003, 'morango', 'fruta'),
    (0123456789004, 'kiwi', 'fruta'),
    (0123456789005, 'laranja', 'fruta'),

    (1234567890001, 'ice tea', 'refrigerante'),
    (1234567890003, 'água', 'bebida sem álcool'),
    (1234567890004, 'sumo', 'bebida sem álcool'),
    (1234567890002, 'cerveja', 'bebida com álcool'),
    (1234567890005, 'vodka', 'bebida com álcool'),

    (2345678900101, 'espinafre', 'vegetais' ),
    (2345678900102, 'bróculo', 'vegetais'),
    (2345678900103, 'couve', 'vegetais'),
    (2345678900104, 'cenoura', 'vegetais'),
    (2345678900105, 'alface', 'vegetais'),

    (3456789001201, 'atum', 'peixe'),
    (3456789001202, 'salmão', 'peixe'),
    (3456789001203, 'peixe-espada', 'peixe'),
    (3456789001204, 'pescada', 'peixe'),
    (3456789001205, 'bacalhau', 'peixe'),

    (4567890012301, 'leite', 'leite'),
    (4567890012302, 'iogurte', 'iogurte'),
    (1111111111111, 'iogurte magro', 'iogurte'),
    (4567890012303, 'queijo creme', 'queijo creme'),
    (2222222222222, 'queijo creme magro', 'queijo creme'),

    (4567890012304, 'queijo', 'queijo'),
    (3333333333333, 'queijo cheddar', 'queijo'),
    (4567890012305, 'natas', 'natas'),
    (4444444444444, 'natas magras', 'natas'),
    (5678900123401, 'lombo de vaca', 'carne de vaca'),

    (5678900123402, 'bife de vazia', 'carne de vaca'),
    (5678900123403, 'lombo de porco', 'carne de porco'),
    (5555555555555, 'orelha de porco', 'carne de porco'),
    (5678900123404, 'perna de frango', 'frango'),
    (6666666666666, 'peito de frango', 'frango'),

    (5678900123405, 'peito de perú', 'perú'),
    (7777777777777, 'perna de perú', 'perú'),
    (6789001234501, 'douradinhos', 'congelados'), 
    (6789001234502, 'pizza', 'fast food'),
    (6789001234505, 'filetes de peixe', 'congelados'),

    (7789001234503, 'tarte de lima', 'sobremesa'),
    (7789001234504, 'chesecake', 'sobremesa'),

    (6789001234503, 'gelado de morango', 'gelados'),
    (6789001234504, 'gelado de baunilha', 'gelados');

INSERT INTO tem_categoria(ean, nome)
VALUES 
    (0123456789001, 'fruta'),
    (0123456789002, 'fruta'),
    (0123456789003, 'fruta'),
    (0123456789004, 'fruta'),
    (0123456789005, 'fruta'),

    (1234567890001, 'refrigerante'),
    (1234567890003, 'bebida sem álcool'),
    (1234567890004, 'bebida sem álcool'),
    (1234567890002, 'bebida com álcool'),
    (1234567890005, 'bebida com álcool'),

    (2345678900101, 'vegetais' ),
    (2345678900102, 'vegetais'),
    (2345678900103, 'vegetais'),
    (2345678900104, 'vegetais'),
    (2345678900105, 'vegetais'),

    (3456789001201, 'peixe'),
    (3456789001202, 'peixe'),
    (3456789001203, 'peixe'),
    (3456789001204, 'peixe'),
    (3456789001205, 'peixe'),

    (4567890012301, 'leite'),
    (4567890012302, 'iogurte'),
    (1111111111111, 'iogurte'),
    (4567890012303, 'queijo creme'),
    (2222222222222, 'queijo creme'),

    (4567890012304, 'queijo'),
    (3333333333333, 'queijo'),
    (4567890012305, 'natas'),
    (4444444444444, 'natas'),
    (5678900123401, 'carne de vaca'),

    (5678900123402, 'carne de vaca'),
    (5678900123403, 'carne de porco'),
    (5555555555555, 'carne de porco'),
    (5678900123404, 'frango'),
    (6666666666666, 'frango'),

    (5678900123405, 'perú'),
    (7777777777777, 'perú'),
    (6789001234501, 'congelados'), 
    (6789001234502, 'fast food'),
    (6789001234505, 'congelados'),

    (7789001234503, 'sobremesa'),
    (7789001234504, 'sobremesa'),

    (6789001234503, 'gelados'),
    (6789001234504, 'gelados');

INSERT INTO IVM(num_serie, fabricante)
VALUES
    (0, 'Augusto'),
    (1, 'Augusto'),
    (2, 'Mário'),
    (3, 'Mário'),
    (4, 'Raquel'),
    (5, 'Raquel');

INSERT INTO ponto_de_retalho(nome, distrito, concelho)
VALUES
    ('Continente', 'Lisboa', 'Oeiras');

INSERT INTO instalada_em(num_serie, fabricante, local)
VALUES
    (0, 'Augusto', 'Continente'),
    (1, 'Augusto', 'Continente'),
    (2, 'Mário', 'Continente'),
    (3, 'Mário', 'Continente'),
    (4, 'Raquel', 'Continente'),
    (5, 'Raquel', 'Continente');

INSERT INTO prateleira(nro, num_serie, fabricante, altura, nome)
VALUES
    (1, 0, 'Augusto', 'baixo', 'vegetais'),
    (2, 0, 'Augusto', 'baixo', 'vegetais'),
    (4, 0, 'Augusto', 'meio', 'vegetais'),
    (7, 0, 'Augusto', 'cima', 'fruta'),
    (5, 0, 'Augusto', 'meio', 'vegetais'),
    (8, 0, 'Augusto', 'cima', 'fruta'),
    (9, 0, 'Augusto', 'cima', 'fruta'),
    (3, 0, 'Augusto', 'baixo', 'vegetais'),
    (6, 0, 'Augusto', 'meio', 'fruta'),
    (10, 0, 'Augusto', 'cima', 'fruta'),
    
    (1, 1, 'Augusto', 'baixo', 'leite'),
    (4, 1, 'Augusto', 'meio', 'natas'),
    (7, 1, 'Augusto', 'cima', 'queijo'),
    (2, 1, 'Augusto', 'baixo', 'iogurte'),
    (5, 1, 'Augusto', 'meio', 'natas'),
    (8, 1, 'Augusto', 'cima', 'queijo creme'),
    (3, 1, 'Augusto', 'baixo', 'iogurte'),
    (6, 1, 'Augusto', 'meio', 'queijo'),
    (9, 1, 'Augusto', 'cima', 'queijo creme'),
    (10, 1, 'Augusto', 'cima', 'refrigerante'),

    (1, 2, 'Mário', 'baixo', 'perú'),
    (3, 2, 'Mário', 'meio', 'frango'),
    (6, 2, 'Mário', 'cima', 'carne de vaca'),
    (2, 2, 'Mário', 'baixo', 'perú'),
    (4, 2, 'Mário', 'meio', 'frango'),
    (7, 2, 'Mário', 'cima', 'carne de porco'),
    (5, 2, 'Mário', 'meio', 'carne de vaca'),
    (8, 2, 'Mário', 'cima', 'carne de porco'),
    (9, 2, 'Mário', 'cima', 'gelados'),

    (1, 3, 'Mário', 'baixo', 'bebida com álcool'),
    (3, 3, 'Mário', 'meio', 'bebida sem álcool'),
    (5, 3, 'Mário', 'cima', 'bebida sem álcool'),
    (2, 3, 'Mário', 'baixo', 'bebida com álcool'),
    (4, 3, 'Mário', 'meio', 'bebida sem álcool'),

    (1, 4, 'Raquel', 'baixo', 'fast food'),
    (3, 4, 'Raquel', 'meio', 'sobremesa'),
    (4, 4, 'Raquel', 'cima', 'sobremesa'),
    (2, 4, 'Raquel', 'baixo', 'fast food'),

    (1, 5, 'Raquel', 'baixo', 'peixe'),
    (3, 5, 'Raquel', 'meio', 'peixe'),
    (5, 5, 'Raquel', 'cima', 'peixe'),
    (2, 5, 'Raquel', 'baixo', 'peixe'),
    (4, 5, 'Raquel', 'meio', 'peixe'),
    (6, 5, 'Raquel', 'cima', 'congelados');

INSERT INTO planograma(ean, nro, num_serie, fabricante, faces, unidades, loc)
VALUES
    (2345678900101, 1, 0, 'Augusto', 15, 30, 0),
    (2345678900102, 2, 0, 'Augusto', 15, 30, 1),
    (2345678900103, 3, 0, 'Augusto', 15, 30, 1), -- vegetais na IVM 0
    (2345678900104, 4, 0, 'Augusto', 15, 30, 0),
    (2345678900105, 5, 0, 'Augusto', 15, 30, 1),

    (0123456789001, 6, 0, 'Augusto', 15, 30, 0), 
    (0123456789002, 7, 0, 'Augusto', 15, 30, 1),
    (0123456789003, 8, 0, 'Augusto', 15, 30, 1), -- fruta na IVM 0
    (0123456789004, 9, 0, 'Augusto', 15, 30, 0),
    (0123456789005, 10, 0, 'Augusto', 15, 30, 1),

    (4567890012301, 1, 1, 'Augusto', 10, 30, 1), -- leite na IVM 1
    (4567890012302, 2, 1, 'Augusto', 10, 30, 0), -- iogurte na IVM 1
    (1111111111111, 3, 1, 'Augusto', 10, 30, 1),

    (4567890012305, 4, 1, 'Augusto', 10, 20, 0), -- natas na IVM 1
    (4444444444444, 5, 1, 'Augusto', 10, 20, 1),
    (4567890012304, 6, 1, 'Augusto', 10, 20, 0), -- queijo na IVM 1
    (3333333333333, 7, 1, 'Augusto', 10, 20, 1),
    (4567890012303, 8, 1, 'Augusto', 10, 20, 0), -- queijo creme na IVM 1
    (2222222222222, 9, 1, 'Augusto', 10, 20, 1),
	
	(5678900123405, 1, 2, 'Mário', 4, 8, 0), -- perú na IVM 2
    (7777777777777, 2, 2, 'Mário', 4, 8, 1),
    (5678900123404, 3, 2, 'Mário', 4, 8, 0), -- frango na IVM 2
    (6666666666666, 4, 2, 'Mário', 4, 8, 1),

    (5678900123401, 5, 2, 'Mário', 4, 8, 0), -- carne de vaca na IVM 2
    (5678900123402, 6, 2, 'Mário', 4, 8, 1),
    (5678900123403, 7, 2, 'Mário', 4, 8, 0), -- carne de porco na IVM 2
    (5555555555555, 8, 2, 'Mário', 4, 8, 1),
	
    (1234567890002, 1, 3, 'Mário', 6, 12, 1), -- bebida com álcool na IVM 3
    (1234567890005, 2, 3, 'Mário', 6, 12, 1),

    (1234567890001, 3, 3, 'Mário', 6, 12, 0),
    (1234567890004, 4, 3, 'Mário', 6, 12, 1), -- bebida sem álcool na IVM 3
    (1234567890003, 5, 3, 'Mário', 6, 12, 1),

    (6789001234501, 1, 4, 'Raquel', 10, 20, 0), --fast food na IVM 4
    (6789001234502, 2, 4, 'Raquel', 10, 20, 1), 

    (6789001234503, 3, 4, 'Raquel', 10, 20, 0), -- sobremesa na IVM 4
    (6789001234504, 4, 4, 'Raquel', 10, 20, 1),

	(3456789001201, 1, 5, 'Raquel', 4, 8, 1),
    (3456789001202, 2, 5, 'Raquel', 4, 8, 1), -- peixe na IVM 5
    (3456789001203, 3, 5, 'Raquel', 4, 8, 1),

    (3456789001204, 4, 5, 'Raquel', 4, 8, 1), -- peixe na IVM 5
    (3456789001205, 5, 5, 'Raquel', 4, 8, 1),
    (6789001234505, 6, 5, 'Raquel', 10, 20, 1); -- congelados na IVM 5

INSERT INTO retalhista(tin, name)
VALUES
    (234567891, 'Bernardo'),
    (345678912, 'Helena'),
    (456789123, 'Julia'),
    (567891234, 'Alice'),
    (912345678, 'Luis'),

    (654321987, 'Maria'),
    (123456789, 'Miguel'),
    (876543219, 'Tiago');

INSERT INTO responsavel_por(nome_cat, tin, num_serie, fabricante)
VALUES
    ('fruta', 912345678, 0, 'Augusto'),
	('peixe', 345678912, 5, 'Raquel'),
    ('refrigerante',234567891, 1,  'Augusto'),
    ('queijo',234567891, 3,'Mário'),
	('carne', 123456789, 2, 'Mário');


INSERT INTO evento_reposicao(ean, nro, num_serie, fabricante, instante, unidades, tin)
VALUES
    (1234567890005, 2, 3, 'Mário', '2022-06-13 10:38', 4, 456789123),-- vodka
    (3456789001205, 5, 5, 'Raquel', '2022-06-13 7:50', 7, 345678912), -- bacalhau
    (1111111111111, 3, 1, 'Augusto', '2022-06-13 8:00', 12, 567891234), -- iogurte
    (3456789001202, 2, 5, 'Raquel', '2022-06-13 7:50', 5, 345678912), -- salmão
    (1234567890003, 5, 3, 'Mário', '2022-06-13 7:30', 10, 456789123), -- água
    (0123456789005, 10, 0, 'Augusto', '2022-06-13 8:00', 10, 912345678), -- laranja
    (2345678900104, 4, 0, 'Augusto', '2022-06-13 8:30', 15, 912345678), -- cenoura
    (4567890012301, 1, 1, 'Augusto', '2022-06-13 8:00', 20, 567891234), -- leite
    (6789001234502, 2, 4, 'Raquel', '2022-06-13 7:50', 5, 654321987); -- pizza

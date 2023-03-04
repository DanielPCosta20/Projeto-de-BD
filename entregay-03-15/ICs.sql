DROP TRIGGER IF EXISTS cat_n_pode_estar_cont_em_si_propria_trigger ON tem_outra;
CREATE OR REPLACE FUNCTION cat_n_pode_estar_cont_em_si_propria()
RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS(
        SELECT super_categoria, categoria
        FROM tem_outra
        WHERE super_categoria = NEW.super_categoria and categoria = NEW.categoria and super_categoria LIKE categoria
        GROUP BY super_categoria, categoria
        )THEN
        RAISE EXCEPTION 'Uma Categoria não pode estar contida em si própria';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger cat_n_pode_estar_cont_em_si_propria_trigger
before insert on tem_outra
for each row execute procedure cat_n_pode_estar_cont_em_si_propria();


DROP TRIGGER IF EXISTS n_uni_er_n_uni_p_trigger ON evento_reposicao;
CREATE OR REPLACE FUNCTION n_uni_er_n_uni_p()
RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS(
        SELECT planograma.unidades
        FROM evento_reposicao INNER JOIN planograma on evento_reposicao.ean = planograma.ean
        WHERE  evento_reposicao.unidades > planograma.unidades
        GROUP BY evento_reposicao.unidades, planograma.unidades
        )THEN
        RAISE EXCEPTION 'O número de unidades repostas num Evento de Reposição não pode exceder o número de 
                        unidades especificado no Planograma';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger n_uni_er_n_uni_p_trigger
before insert on evento_reposicao
for each row execute procedure n_uni_er_n_uni_p();


DROP TRIGGER IF EXISTS pro_pra_cat_trigger ON evento_reposicao;
CREATE OR REPLACE FUNCTION pro_pra_cat()
RETURNS TRIGGER AS
$$
DECLARE aux_1 VARCHAR(50);
DECLARE aux_2 VARCHAR(50);
BEGIN

    SELECT p.nome INTO aux_1
    FROM prateleira p
    WHERE p.nro = NEW.nro AND p.num_serie = NEW.num_serie AND p.fabricante = NEW.fabricante;

    SELECT t.cat INTO aux_2
    FROM produto t
    WHERE t.ean = NEW.ean;

    IF aux_1 NOT LIKE aux_2 THEN
        RAISE EXCEPTION 'Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos) uma das Categorias desse produto';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger pro_pra_cat_trigger
before insert on evento_reposicao
for each row execute procedure pro_pra_cat();
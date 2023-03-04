#!/usr/bin/python3
from wsgiref.handlers import CGIHandler
from flask import Flask, render_template, redirect, url_for, request

## PostgreSQL database adapter
import psycopg2
import psycopg2.extras

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist198966"
DB_DATABASE=DB_USER
DB_PASSWORD="ijxh6100"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

app = Flask(__name__)

# MAIN PAGE

@app.route("/")
def home():
    return render_template("index.html")

# Inserir/Remover Categorias e Sub-Categorias

## Route em que o utilizador escolhe se quer adicionar ou remover uma categoria
@app.route("/add_or_remove_category/")
def add_or_remove_category():
    return render_template("add_or_remove_category.html")

## Route em que o utilizador insere o nome da categoria a adicionar
@app.route("/insert_category_to_add/", methods=["POST", "GET"])
def insert_category_to_add():
    if request.method == "POST":
        nome = request.form["nome"]
        return redirect(url_for("add_category", nome=nome))
    else:
        return render_template("insert_category_to_add.html")

## Route de processamento de dados (inserção da categoria na tabela)
@app.route("/add_category/<nome>")
def add_category(nome):
    dbConn=None
    cursor=None

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query1 = "INSERT INTO categoria (nome) VALUES (%s);"
        query2 = "INSERT INTO categoria_simples (nome) VALUES (%s);"
        cursor.execute(query1, (nome,))
        cursor.execute(query2, (nome,))
        dbConn.commit()
        rowcount=cursor.rowcount
        return render_template("success.html")
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

    return render_template("success.html")

## Route em que o utilizador insere o nome da sub-categoria a adicionar
@app.route("/insert_subcategory_to_add/", methods=["POST", "GET"])
def insert_subcategory_to_add():
    if request.method == "POST":
        super_nome = request.form["super_nome"]
        sub_nome = request.form["sub_nome"]
        return redirect(url_for("add_subcategory", super_nome=super_nome, sub_nome=sub_nome))
    else:
        return render_template("insert_subcategory_to_add.html")

## Route de processamento de dados (inserção da sub-categoria e a sua super-categoria na tabela)
@app.route("/add_subcategory/<super_nome>&<sub_nome>")
def add_subcategory(super_nome, sub_nome):
    dbConn=None
    cursor=None

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        supercat_existent = 0

        existent_super_cat = "SELECT nome FROM super_categoria WHERE nome = %s;"
        cursor.execute(existent_super_cat, (super_nome,))
        result = cursor.fetchall()

        # Verifica se a super categoria inserida já existe
        for row in result:
            for value in row:
                if value == super_nome:
                    supercat_existent = 1

        # Se não existir, cria uma nova e associa a nova sub-categoria
        if supercat_existent == 0:
            query1 = "DELETE FROM categoria_simples WHERE nome = %s;"
            query2 = "INSERT INTO categoria VALUES (%s);"
            query3 = "INSERT INTO categoria VALUES (%s);"
            query4 = "INSERT INTO categoria_simples VALUES (%s);"
            query5 = "INSERT INTO super_categoria VALUES (%s);"
            query6 = "INSERT INTO tem_outra VALUES (%s, %s);"
            cursor.execute(query1, (super_nome,))
            cursor.execute(query2, (sub_nome,))
            cursor.execute(query3, (super_nome,))
            cursor.execute(query4, (sub_nome,))
            cursor.execute(query5, (super_nome,))
            cursor.execute(query6, (super_nome, sub_nome))
            dbConn.commit()

        # Se existir, associa só a sub-categoria
        else:
            query1 = "INSERT INTO categoria VALUES (%s);"
            query2 = "INSERT INTO categoria_simples VALUES (%s);"
            query3 = "INSERT INTO tem_outra VALUES (%s, %s);"
            cursor.execute(query1, (sub_nome,))
            cursor.execute(query2, (sub_nome,))
            cursor.execute(query3, (super_nome, sub_nome))
            dbConn.commit()

        return render_template("success.html")
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

    return render_template("success.html")

## Route em que o utilizador insere o nome da categoria a remover
@app.route("/insert_category_to_remove/", methods=["POST", "GET"])
def insert_category_to_remove():
    if request.method == "POST":
        category = request.form["input"]
        return redirect(url_for("remove_category", category=category))
    else:
        return render_template("insert_category_to_remove.html")

## Route de processamento de dados (remoção da categoria na tabela)
@app.route("/remove_category/<category>")
def remove_category(category):
    dbConn=None
    cursor=None
    supercat_existent = 0

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        existent_super_cat = "SELECT nome FROM super_categoria WHERE nome = %s;"
        cursor.execute(existent_super_cat, (category,))
        result = cursor.fetchall()

        # Verifica se a super categoria inserida já existe
        for row in result:
            for value in row:
                if value == category:
                    supercat_existent = 1

        # Se existir
        if supercat_existent:
            query = "WITH RECURSIVE super AS ( SELECT categoria FROM tem_outra c WHERE super_categoria = %s UNION SELECT cat.categoria FROM tem_outra cat, super WHERE cat.super_categoria = super.categoria) SELECT * FROM super;"
            cursor.execute(query, (category,))
            result = [(category,)] + cursor.fetchall()
        else:
            result = [(category,)]

        for category in result:

            #remover produto 
            dbConn = psycopg2.connect(DB_CONNECTION_STRING)
            cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
            query_produto = "SELECT ean FROM produto WHERE cat = %s"
            cursor.execute(query_produto, (category[0],))
            result_produto = cursor.fetchall()

            for ean in result_produto:
                query_produto_1 = "DELETE FROM evento_reposicao WHERE ean = %s;"
                query_produto_2 = "DELETE FROM planograma WHERE ean = %s;"
                query_3 = "DELETE FROM tem_categoria WHERE nome = %s;"
                query_produto_3 = "DELETE FROM produto WHERE ean = %s;"
                cursor.execute(query_produto_1, (ean[0],))
                cursor.execute(query_produto_2, (ean[0],))
                cursor.execute(query_3, (category[0],))
                cursor.execute(query_produto_3, (ean[0],))

            #remover categoria 
            query_1 = "DELETE FROM prateleira WHERE nome = %s;"
            query_2 = "DELETE FROM responsavel_por WHERE nome_cat = %s;"
            query_4 = "DELETE FROM tem_outra WHERE super_categoria = %s OR categoria = %s;"
            query_5 = "DELETE FROM categoria_simples WHERE nome = %s;"
            query_6 = "DELETE FROM super_categoria WHERE nome = %s;"
            query_7 = "DELETE FROM categoria WHERE nome = %s;"
            cursor.execute(query_1, (category[0],))
            cursor.execute(query_2, (category[0],))
            cursor.execute(query_4, (category[0], category[0]))
            cursor.execute(query_5, (category[0],))
            cursor.execute(query_6, (category[0],))
            cursor.execute(query_7, (category[0],))
            dbConn.commit()

        return render_template("success.html")
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

    return render_template("success.html")

# Inserir/Remover um Retalhista (e todos os seus Produtos)

## Route em que o utilizador escolhe se quer adicionar ou remover um retalhista
@app.route("/add_or_remove_retailer/")
def add_or_remove_retailer():
    return render_template("add_or_remove_retailer.html")

## Route em que o utilizador insere o TIN e o nome do retalhista a adicionar
@app.route("/insert_tin_to_add/", methods=["POST", "GET"])
def insert_tin_to_add():
    if request.method == "POST":
        tin = request.form["tin"]
        nome = request.form["nome"]
        return redirect(url_for("add_retailer", tin=tin, nome=nome))
    else:
        return render_template("insert_tin_to_add.html")

## Route em que o utilizador insere o TIN do retalhista a remover
@app.route("/insert_tin_to_remove/", methods=["POST", "GET"])
def insert_tin_to_remove():
    if request.method == "POST":
        tin = request.form["input"]
        return redirect(url_for("remove_retailer", tin=tin))
    else:
        return render_template("insert_tin_to_remove.html")

## Route de processamento de dados (remoção do retalhista na tabela)
@app.route("/remove_retailer/<tin>")
def remove_retailer(tin):
    dbConn=None
    cursor=None

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        produto_retalhista = "SELECT ean FROM produto WHERE cat IN (SELECT nome_cat FROM responsavel_por WHERE tin = %s);"
        cursor.execute(produto_retalhista, (tin,))
        result = cursor.fetchall()

        #remover retalhista
        query_retalhista_1 = "DELETE FROM evento_reposicao WHERE tin = %s;"
        query_retalhista_2 = "DELETE FROM responsavel_por WHERE tin = %s;"
        query_retalhista_3 = "DELETE FROM retalhista WHERE tin = %s;"

        cursor.execute(query_retalhista_1, (tin,))
        cursor.execute(query_retalhista_2, (tin,))
        cursor.execute(query_retalhista_3, (tin,))


        for ean in result:

            #remover produto 
            query_produto_1 = "DELETE FROM evento_reposicao WHERE ean = %s;"
            query_produto_2 = "DELETE FROM planograma WHERE ean = %s;"
            query_produto_3 = "DELETE FROM tem_categoria WHERE ean = %s;"
            query_produto_4 = "DELETE FROM produto WHERE ean = %s;"
            cursor.execute(query_produto_1, (ean[0],))
            cursor.execute(query_produto_2, (ean[0],))
            cursor.execute(query_produto_3, (ean[0],))
            cursor.execute(query_produto_4, (ean[0],))

        return render_template("success.html")
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

    return render_template("success.html")

## Route de processamento de dados (adição do retalhista na tabela)
@app.route("/add_retailer/<tin>&<nome>")
def add_retailer(tin, nome):
    dbConn=None
    cursor=None

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "INSERT INTO retalhista(tin, name) VALUES (%s, %s);"
        cursor.execute(query, (tin, nome))
        dbConn.commit()
        rowcount=cursor.rowcount
        return render_template("success.html")
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

    return render_template("success.html")

# Listar todos os Eventos de Reposição de uma IVM

## Route em que o utilizador insere o n de serie e o fabricante da IVM
@app.route("/insert_nserie_manufacturer_ivm/", methods=["POST", "GET"])
def insert_nserie_manufacturer_ivm():
    if request.method == "POST":
        nserie = request.form["nserie"]
        manufacturer = request.form["manufacturer"]
        return redirect(url_for("list_replenishment_events_from_ivm", nserie=nserie, manufacturer=manufacturer))
    else:
        return render_template("insert_nserie_manufacturer_ivm.html")

## Route em que lista todos os Eventos de Reposicao da IVM
@app.route("/list_replenishment_events_from_ivm/<nserie>&<manufacturer>")
def list_replenishment_events_from_ivm(nserie, manufacturer):
    dbConn=None
    cursor=None

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT tin , SUM(unidades),cat FROM evento_reposicao NATURAL JOIN produto NATURAL JOIN IVM WHERE num_serie = 0 AND fabricante LIKE 'Augusto' GROUP BY tin, cat;"
        cursor.execute(query, (nserie,))
        rowcount=cursor.rowcount
        html = '''
        <!DOCTYPE html>
        <style>
        body {
            font-family: Montserrat;
            margin: 0;
        }
        /* Header/Logo Title */
        .header {
          padding: 15px;
          text-align: left;
          background: #55BCC9;
          color: white;
          font-size: 15px;
        }

        /* Page Content */
        .content {padding:20px;}

        .button {
          border: none;
          color: white;
          padding: 15px 50px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          margin: 4px 2px;
          cursor: pointer;
          border-radius: 5px;
        }

        .logo {float:right}

        .button1 {background-color: #4CAF50;} /* Green */
        .button2 {background-color: #55BCC9;} /* Blue */
        </style>
        <html>
            <head>
                <meta charset="utf-8">
                <title>List of categories - Python </title>
            </head>
            <div class="header">
                <h1>Databases Project - Delivery 3</h1>
            </div>
            <div class="content">
                <h1>Lista de Eventos de Reposição</h1>
                <body style="padding:20px" >
                    <table border="5" cellspacing="5" style="background-color:#FFFFFF;">
                        <th style="background-color: #55BCC9; width: 500px; text-align: center;" colspan="7"><strong><span style="color: #ffffff;">Lista de Eventos de Reposição da IVM</span></strong></th>
                        <tbody>
                          <tr>
                            <th>TIN</th>
                            <th>Categoria</th>
                            <th>Nº Unidades</th>
                          </tr>
        '''

        for record in cursor:
            html += f'''
                    <tr>
                        <td>{record[0]}</td>
                        <td>{record[2]}</td>
                        <td>{record[1]}</td>
                    </tr>
            '''
        html += '''
                        </tbody>
                    </table>
                </body>
            </div>
            <div>
                <br />
                <button class="button button2" onclick="document.location='../../app.cgi/'">Voltar</button>
            </div>
        </html>
        '''

        return html ## Renders the html string
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

    return html

# Listar todas as Sub-categorias de uma Super-categoria

## Route em que o utilizador insere o nome da super categoria
@app.route("/insert_supercat/", methods=["POST", "GET"])
def insert_supercat():
    if request.method == "POST":
        super_cat = request.form["input"]
        return redirect(url_for("list_subcat_from_supercat", super_cat=super_cat))
    else:
        return render_template("insert_supercat.html")

## Route que lista todas as sub-categorias da super-categoria inserida
@app.route("/list_subcat_from_supercat/<super_cat>")
def list_subcat_from_supercat(super_cat):

    dbConn=None
    cursor=None

    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "WITH RECURSIVE super AS ( SELECT categoria FROM tem_outra c WHERE super_categoria = %s UNION SELECT cat.categoria FROM tem_outra cat, super WHERE cat.super_categoria = super.categoria) SELECT * FROM super;"
        cursor.execute(query, (super_cat,))
        rowcount=cursor.rowcount
        html = '''
        <!DOCTYPE html>
        <style>
        body {
            font-family: Montserrat;
            margin: 0;
        }
        /* Header/Logo Title */
        .header {
          padding: 15px;
          text-align: left;
          background: #55BCC9;
          color: white;
          font-size: 15px;
        }

        /* Page Content */
        .content {padding:20px;}

        .button {
          border: none;
          color: white;
          padding: 15px 50px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          margin: 4px 2px;
          cursor: pointer;
          border-radius: 5px;
        }

        .logo {float:right}

        .button1 {background-color: #4CAF50;} /* Green */
        .button2 {background-color: #55BCC9;} /* Blue */
        </style>
        <html>
            <head>
                <meta charset="utf-8">
                <title>List of categories - Python </title>
            </head>
            <div class="header">
                <h1>Databases Project - Delivery 3</h1>
            </div>
            <div class="content">
                <h1>Lista de Sub-Categorias de uma Super-Categoria</h1>
                <body style="padding:20px" >
                    <table border="5" cellspacing="5" style="background-color:#FFFFFF;">
                        <th style="background-color: #55BCC9; width: 500px; text-align: center;" colspan="5"><strong><span style="color: #ffffff;">Super-Categoria '''+ super_cat +'''</span></strong></th>
                        <tbody>
        '''

        for record in cursor:
            html += f'''
                    <tr>
                        <td>{record[0]}</td>
                    </tr>
            '''
        html += '''
                        </tbody>
                    </table>
                </body>
            </div>
            <div>
                <br />
                <button class="button button2" onclick="document.location='../../app.cgi/'">Voltar</button>
            </div>
        </html>
        '''

        return html ## Renders the html string
    except Exception as e:
        return str(e) ## Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

    return html


CGIHandler().run(app)

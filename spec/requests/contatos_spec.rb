require 'swagger_helper'

describe 'Agenda de Contatos API' do
 path '/contatos' do # bloco que define as operações do caminho /contatos
   post 'Criar um contato' do # bloco de especificação da operação POST /contatos
     consumes 'application/json' # determina que o corpo da requisição deve estar no formato JSON
     parameter name: :contato, in: :body, schema: { # bloco que determina o formato do objeto JSON que deve ser enviado na requisição
       type: :object, # deve ser enviado um objeto JSON
       properties: { # com as seguintes propriedades:
         nome: { type: :string }, # propriedade nome do tipo string
         telefone: { type: :string }, # propriedade telefone do tipo string
         email: { type: :string } # propriedade email do tipo string
       },
       required: [ :nome, :telefone ] # define quais propriedades são obrigatórias
     }
    
     # o seguinte bloco de código define que uma possível resposta dessa operação é 201 (Created), que significa que
     # o contato foi criado com sucesso.
     response '201', 'contato criado com sucesso' do
       let(:contato) { # cria um objeto 'contato' com os seguintes dados:
         {
           nome: 'Ariano Suassuna',
           telefone: '(84) 98888-8888',
           email: 'ariano.suassuna@academia.org.br'
         }
       }
       run_test! # executa o teste com o contato criado anteriormente
     end

     # o seguinte bloco de código define que uma possível resposta dessa operação é 422 (Unprocessable Entity), que
     # significa que a requisição é inválida.
     response '422', 'requisição inválida' do
       let(:contato) { # cria um objeto 'contato' com os seguintes dados:
         {
           telefone: '(84) 98888-8888',
           email: 'ariano.suassuna@academia.org.br'
         }
       }
       run_test! # executa o teste com o contato criado anteriormente
     end
   end

   get 'Listar contatos' do # bloco de especificação da operação GET /contatos
     # o seguinte bloco de código define que uma possível resposta dessa operação é 200 (OK), que significa que
     # a lista de contatos foi fornecida com sucesso.
     response '200', 'Contatos listados com sucesso' do
       # cria um objeto contato com os seguintes dados
       let(:contato) { Contato.create(nome: 'Ariano Suassuna', telefone: '(84) 98888-8888', email: 'ariano.suassuna@academia.org.br') }
       run_test! # executa o teste com o contato criado anteriormente
     end
   end
 end

 path '/contatos/{id}' do # bloco que define as operações do caminho /contatos/{id}
   parameter name: :id, in: :path, type: :integer # determina que o parâmetro {id} é um número do tipo inteiro

   get 'Detalhar um contato' do # bloco de especificação da operação GET /contatos/{id}
     produces 'application/json' # determina que o corpo da resposta está no formato JSON

     # o seguinte bloco de código define que uma possível resposta dessa operação é 200 (OK), que significa que
     # o contato foi encontrado.
     response '200', 'Contato encontrado' do
       schema type: :object, # define o formato do corpo da resposta
         properties: { # com as seguintes propriedades:
           id: { type: :integer }, # um parâmtro id do tipo inteiro
           nome: { type: :string }, # um parâmetro nome do tipo string
           email: { type: :string }, # um parâmetro email do tipo string
           created_at: { type: :string }, # um parâmetro created_at do tipo string
           updated_at: { type: :string } # um parâmetro updated_at do tipo string
         },
         required: [ :id, :nome, :email, :created_at, :updated_at ] # define quais propriedades são obrigatórias
      
       # cria uma variável 'id' com o id de um contato existente
       let(:id) { Contato.create(nome: 'Ariano Suassuna', telefone: '(84) 98888-8888', email: 'ariano.suassuna@academia.org.br').id }

       # executa o teste
       run_test!
     end

     # o seguinte bloco de código define que uma possível resposta dessa operação é 404 (Not found), que significa que
     # o contato não foi encontrado.
     response '404', 'Contato não encontrado' do
       # cria uma variável 'id' com o valor 9999 (o id de um contato que não existe)
       let(:id) { 9999 }

       # executa o teste
       run_test!
     end
   end

   delete 'Apagar um contato' do # bloco de especificação da operação DELETE /contatos/{id}
     produces 'application/json' # determina que o formato do corpo da resposta é JSON

     # o seguinte bloco de código define que uma possível resposta dessa operação é 204 (No content), que significa que
     # o contato foi apagado com sucesso e o corpo da resposta está vazio.
     response '204', 'Contato apagado com sucesso' do
       # cria uma variável 'id' com o id de um contato existente
       let(:id) { Contato.create(nome: 'Ariano Suassuna', telefone: '(84) 98888-8888', email: 'ariano.suassuna@academia.org.br').id }
       run_test! # executa o teste
     end
   end
 end
end

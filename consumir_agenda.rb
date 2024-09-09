require 'net/http'
require 'json'
require 'uri'

# Função para criar um novo contato
def criar_contato(nome, telefone, email)
  uri = URI('http://localhost:3000/contatos') # Ajuste a URL se necessário
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
  
  # Dados do contato
  contato = { contato: { nome: nome, telefone: telefone, email: email } }
  request.body = contato.to_json
  
  # Envia a requisição
  response = http.request(request)
  
  puts ""
  puts "Contato criado: #{response.body}"
  puts ""
end

# Função para listar todos os contatos
def listar_contatos
  puts ""
  puts "Lista de Contatos"
  puts ""

  uri = URI('http://localhost:3000/contatos') # Ajuste a URL se necessário
  response = Net::HTTP.get(uri)
  
  contatos = JSON.parse(response)
  contatos.each do |contato|
    puts "Nome: #{contato['nome']}, Telefone: #{contato['telefone']}, Email: #{contato['email']}"
  end
end

# Leitura de dados do terminal
print 'Digite o nome do contato:'
nome = gets.chomp
print 'Digite o telefone do contato:'
telefone = gets.chomp
print 'Digite o email do contato:'
email = gets.chomp

# Criar um novo contato
criar_contato(nome, telefone, email)

# Listar todos os contatos
listar_contatos

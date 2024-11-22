class ContatosController < ApplicationController
  # Executa o método autenticar antes de executar qualquer outra ação
  before_action :autenticar
 
  def create
    # Cria um novo contato com os dados retornados por contato_params
    @contato = Contato.new(contato_params)
    # Associa o @usuario ao objeto @contato antes de salvá-lo no banco de dados
    @contato.usuario = @usuario
 
    # Salva o contato no banco de dados. A função save retorna um booleano indicando se o salvamento foi feito com sucesso ou não.
    if @contato.save
      # Caso o salvamento tenha sido feito com sucesso, responde com o JSON do contato e status 201 (Created)
      render json: @contato, status: :created
    else
      # Caso o salvamento falhe, responde com um JSON com erros e o status 422 (Unprocessable entity)
      render json: @contato.errors, status: :unprocessable_entity
    end
  end
 
  def show
    # Busca no banco de dados um contato com um ID específico
    @contato = Contato.find(params[:id])
 
    # Verifica se o @contato pertence ao @usuario
    if @contato.usuario_id = @usuario.id
      # Se sim, responde com o JSON do contato
      render json: @contato
    else
      # Se não, responde com o seguinte JSON e o status 404 (não encontrado)
      render json: { erro: 'Não encontrado' }, status: :not_found
    end
  end
 
  def index
    # Busca os contatos que pertençam ao @usuario
    @contatos = Contato.where(usuario_id: @usuario.id)
 
    # Responde com o JSON dos contatos que pertencem ao @usuario
    render json: @contatos
  end
 
  def update
    # Busca no banco de dados um contato com um ID específico
    @contato = Contato.find(params[:id])
 
    # Verifica se o @contato pertence ao @usuario
    if @contato.usuario_id == @usuario.id
      # Atualiza o contato no banco de dados. A função update retorna um booleano
      # indicando se a atualização foi realizada com sucesso.
      if @contato.update(contato_params)
        # Caso o contato tenha sido atualizado, responde a requisição com seu JSON e status 200 (Ok)
        render json: @contato
      else
        # Caso contrário, responde a requisição com erros em JSON e status 422 (Unprocessable entity)
        render json: @contato.errors, status: :unprocessable_entity
      end
    else
      # Caso contrário, responde a requisição com o seguinte JSON e status 404 (Not found)
      render json: { erro: 'Não encontrado' }, status: :not_found
    end
  end
 
  def destroy
    # Busca no banco de dados um contato com um ID específico
    @contato = Contato.find(params[:id])
    # Verifica se o @contato pertence ao @usuario
    if @contato.usuario_id == @usuario.id
      # Apaga o contato do banco de dados
      @contato.destroy!
    else
      # Caso contrário, responde a requisição com o seguinte JSON e status 404 (Not found)
      render json: { erro: 'Não encontrado' }, status: :not_found
    end
  end
 
  private
    def contato_params
      params.require(:contato).permit(:nome, :telefone, :email)
    end
 
    def autenticar
      # Busca pelo valor do cabeçalho de nome 'Authorization', apaga o prefixo 'Bearer ' e salva na variável token
      token = request.headers['Authorization']&.delete_prefix('Bearer ')
      # Se a variável token tiver algum valor, então busca por um usuário que tenha o token igual ao guardado na
      # variável token e guarda o retorno na variável de instância @usuario
      @usuario = Usuario.find_by_token(token) if token.present?
      # Verifica se a variável @usuario é nil
      if @usuario.nil?
        # Caso a variável de instância @usuario seja nil, significa que nenhum usuário foi encontrado com o token fornecido
        # Nesse caso, responde a requisição com o JSON abaixo e o status 401 Unauthorized (não autorizado)
        render json: { erro: 'Não autorizado' }, status: :unauthorized
        # Retorna para não executar a ação que foi requisitada
        return
      end
      # Caso a variável de instância @usuario não seja nil, significa que o usuário foi encontrado e a requisição pode seguir
    end
 end
 
class ContatosController < ApplicationController
  
  def create
    # Cria um novo contato com os dados retornados por contato_params.
    @contato = Contato.new(contato_params)
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
    # Responde com o JSON do contato
    render json: @contato
  end

  def index
    # Busca no banco de dados todos os contatos existentes
    @contatos = Contato.all
    # Responde com o JSON de todos os contatos
    render json: @contatos
  end

  def update
    # Busca no banco de dados um contato com um ID específico
    @contato = Contato.find(params[:id])
    # Atualiza o contato no banco de dados. A função update retorna um booleano
    # indicando se a atualização foi realizada com sucesso.
    if @contato.update(contato_params)
      # Caso o contato tenha sido atualizado, responde a requisição com seu JSON e status 200 (Ok)
      render json: @contato
    else
      # Caso contrário, responde a requisição com erros em JSON e status 422 (Unprocessable entity)
      render json: @contato.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Busca no banco de dados um contato com um ID específico
    @contato = Contato.find(params[:id])
    # Apaga o contato do banco de dados
    @contato.destroy!
  end

  private
    def contato_params
      params.require(:contato).permit(:nome, :telefone, :email)
    end

end
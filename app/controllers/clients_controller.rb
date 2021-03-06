# coding: utf-8

class ClientsController < ApplicationController

  def index
  	@title = 'Список клиентов'
  	@clients = Client.paginate(:page => params[:page])

    if params[:status]
      @clients = @clients.where(:status => (params[:status] == "1"))
    end
  end

  def show
  	@client = Client.find(params[:id])
  	@title = @client.name
  end

  def new
  	@client = Client.new
  	@title = 'Добавление клиента'
  end

  def create
  	@client = Client.new(params[:client])
  	if @client.save
  	  flash[:notice] = 'Клиент успешно добавлен'
  	  redirect_to clients_path
  	else
  	  @title = 'Добавление клиента'
  	  render 'new'
  	end
  end

  def edit
  	@client = Client.find(params[:id])
  	@title = 'Редактирование клиента'
  end

  def update
  	@client = Client.find(params[:id])
  	if @client.update_attributes(params[:client])
  	  flash[:notice] = 'Данные обновлены'
  	  redirect_to edit_client_path(@client)
  	else
  	  @title = 'Редактирование клиента'
  	  render 'edit'
  	end
  end

  def destroy
  	Client.find(params[:id]).destroy
  	flash[:notice] = 'Клиент удален'
  	redirect_to clients_path
  end


end

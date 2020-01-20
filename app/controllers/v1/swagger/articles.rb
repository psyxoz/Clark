module V1::Swagger::Articles
  extend ActiveSupport::Concern

  included do
    swagger_controller :articles, 'Articles Management'

    swagger_model :Article do
      description 'Article object'
      property :id, :integer, :required, 'Id'
      property :title, :string, :required, 'Title'
      property :content, :string, :required, 'Content'
      property_list :status, :string, :optional, 'Status', ['active', 'archived']
    end

    swagger_api :index do
      summary 'Fetches all Article items'
      notes 'This lists all the active articles'
      param :query, :page, :integer, :optional, 'Page number'
      response :ok
    end

    swagger_api :show do
      summary 'Fetches a single Article item'
      param :path, :id, :integer, :optional, 'Article Id'
      response :ok, 'Success', :Article
      response :not_found
    end

    swagger_api :create do
      summary 'Creates a new Article'
      param :form, 'article[title]', :string, :required, 'Title of article'
      param :form, 'article[content]', :string, :required, 'Content of article'
      param_list :form, 'article[status]', :string, :optional, 'Status', ['active', 'archived']
      response :created
      response :not_acceptable
      response :unauthorized
    end

    swagger_api :update do
      summary 'Updates an existing Article'
      param :form, 'article[title]', :string, :required, 'Title of article'
      param :form, 'article[content]', :string, :required, 'Content of article'
      param_list :form, 'article[status]', :string, :optional, 'Status', ['active', 'archived']
      response :accepted
      response :unauthorized
      response :not_found
      response :not_acceptable
    end

    swagger_api :destroy do
      summary 'Deletes an existing Article item'
      param :path, :id, :integer, :required, 'Article Id'
      response :no_content
      response :unauthorized
      response :not_found
    end
  end
end

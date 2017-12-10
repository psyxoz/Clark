module V1::Swagger::Comments
  extend ActiveSupport::Concern

  included do
    swagger_controller :comments, 'Comments Management'

    swagger_model :Comment do
      description 'Comment object'
      property :id, :integer, :required, 'Id'
      property :user_id, :string, :required, 'User Id'
      property :article_id, :string, :required, 'Article Id'
      property :content, :string, :required, 'Content'
    end

    swagger_api :index do
      summary 'Fetches all Comment items'
      notes 'This lists all comments'
      param :path, :id, :integer, :required, 'Article Id'
      param :query, :page, :integer, :optional, 'Page number'
      response :ok
    end

    swagger_api :show do
      summary 'Fetches a single Comment item'
      param :path, :id, :integer, :required, 'Article Id'
      response :ok, 'Success', :Comment
      response :not_found
    end

    swagger_api :create do
      summary 'Creates a new Comment'
      param :path, :article_id, :integer, :optional, 'Article Id'
      param :form, 'comment[content]', :string, :required, 'Content of comment'
      response :created
      response :not_acceptable
      response :unauthorized
    end

    swagger_api :destroy do
      summary 'Deletes an existing Comment item'
      param :path, :id, :integer, :required, 'Comment Id'
      response :no_content
      response :unauthorized
      response :not_found
    end
  end
end

module V1
  class ArticlesController < ApplicationController
    include Common

    expose(:articles) { Article.includes(:user).page(page) }
    expose :article, scope: -> do
      if %w(create update).include?(action_name)
        current_user.articles
      else
        Article
      end
    end

    def create
      article.save!
      render :show, status: :created
    end

    def update
      article.update!(article_params)
      render :show, status: :ok
    end

    def destroy
      article.destroy!
      head :no_content
    end

    private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def check_permissions
      authorize!(:manage, article)
    end
  end
end

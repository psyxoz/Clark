module V1
  class ArticlesController < ApplicationController
    include Common

    expose(:articles) { Article.active_with_users.page(page) }
    expose(:article, build: ->(article_params,_){ current_user.articles.new(article_params) })

    def create
      article.save!
      render :show, status: :created
    end

    def update
      article.update!(article_params)
      head :accepted
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

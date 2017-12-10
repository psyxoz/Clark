module V1
  class ArticlesController < ApplicationController
    include Common

    expose(:articles) { Article.active_with_users.page(page) }
    expose(:article)

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
      params.require(:article).permit(:title, :content).tap do |p|
        p[:user_id] = current_user.id
      end
    end

    def check_permissions
      authorize!(:manage, article)
    end
  end
end

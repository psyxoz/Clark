module V1
  class ArticlesController < ::ApplicationController
    before_action :check_permissions, except: [:index, :show]

    expose(:page) { (params[:page].presence || 1).to_i }
    expose(:articles) { Article.page(page) }
    expose(:article)

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

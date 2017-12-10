module V1
  class ArticlesController < ::ApplicationController
    include Common

    expose(:article) { Article.find(article_id) }
    expose(:comments) { article.comments.page(page) }
    expose(:comment, scope: -> { article.comments })

    def create
      comment.save!
      render :show, status: :created
    end

    def destroy
      comment.destroy!
      head :no_content
    end

    private

    def article_id
      params.require(:article_id)
    end

    def comment_params
      params.require(:comment).permit(:content).tap do |p|
        p[:user_id] = current_user.id
      end
    end

    def check_permissions
      authorize!(:manage, comment)
    end
  end
end

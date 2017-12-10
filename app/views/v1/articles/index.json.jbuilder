json.set! :articles do
  json.array! articles, partial: 'v1/articles/base', as: :article
end

json.set! :total, articles.total_count
json.set! :page, page

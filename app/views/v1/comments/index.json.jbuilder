json.set! :comments do
  json.array! comments, partial: 'v1/comments/base', as: :comment
end

json.set! :total, comments.total_count
json.set! :page, page

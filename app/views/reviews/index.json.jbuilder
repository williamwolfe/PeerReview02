json.array!(@reviews) do |review|
  json.extract! review, :id, :submission_id, :user_id, :comment, :score
  json.url review_url(review, format: :json)
end

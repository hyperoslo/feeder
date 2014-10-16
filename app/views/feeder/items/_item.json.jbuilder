json.partial! "feeder/types/#{item.type}", feedable: item.feedable

json.likes do |json|
  json.count item.likes.size
  json.liked item.liked_by? liker

  like_scopes.each do |scope|
    json.set! scope do |json|
      json.count item.likes.size
      json.liked item.liked_by? liker
    end
  end
end

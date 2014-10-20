json.partial! "feeder/types/#{item.type}", feedable: item.feedable

json.likes do |json|
  json.count item.likes.size
  json.liked item.liked_by? liker
  json.like_url feeder.like_item_path(id: item.id)
  json.unlike_url feeder.unlike_item_path(id: item.id)

  json.scopes do |json|
    like_scopes.each do |scope|
        json.count item.likes(scope).size
        json.liked item.liked_by?(liker, scope)
        json.like_url feeder.like_item_path(id: item.id, like_scope: scope)
        json.unlike_url feeder.unlike_item_path(id: item.id, like_scope: scope)
      end
    end
  end
end

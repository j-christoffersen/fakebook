module PostsHelper
  
  #returns string for captioning posts about likes
  def render_likes_caption likers
    num_likers = likers.count
    
    if likers.include? current_user
      if num_likers > 2
        return "You, #{likers.first == current_user ? likers.second.name : likers.first.name}, and #{num_likers-2} others like this"
      elsif num_likers == 2
        return "You and #{likers.first == current_user ? likers.second.name : likers.first.name} like this"
      elsif num_likers == 1
        return "You like this"
      else
        return "Nobody likes this"
      end
    else
      if num_likers > 2
        return "#{likers.first.name}, #{likers.second.name}, and #{num_likers} others like this"
      elsif num_likers == 2
        return "#{likers.first.name} and #{likers.second.name} like this"
      elsif num_likers == 1
        return "#{likers.first.name} likes this"
      else
        return "Nobody likes this"
      end
    end
  end
  
end

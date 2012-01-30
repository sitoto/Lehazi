module Tagger

 def tag_get(model,id, limit)
    options = {
    :select => " tags.name as tag_name",
    :conditions => {:taggable_id => model, :taggable_id => id},
    :joins => " left outer join tags on tags.id=taggings.tag_id" ,
    :limit => limit
    }

    taggings = Tagging.all(options)

    return "" if taggings.blank?
    cloud = []
    taggings.each do |tagging|
      cloud << tagging['tag_name']
    end
    return cloud.to_sentence({:two_words_connector => ',', :last_word_connector => ','})
  end
end
module TagsHelper

  def tags_cloud(model, limit=30)
    options = {
    :select => "count(taggings.id) as count_all, tags.name as tag_name, tag_id",
    :conditions => {:taggable_type => model.to_s },
    :joins => " left outer join tags on tags.id=taggings.tag_id" ,
    :group => 'tag_id',
    :order => 'count_all desc',
    :limit => limit
    }

    taggings = Tagging.all(options)

    return [] if taggings.blank?

    maxlog = Math.log(taggings.first['count_all'])
    minlog = Math.log(taggings.last['count_all'])
    rangelog = maxlog - minlog;
    rangelog = 1 if maxlog==minlog
    min_font = 1
    max_font = 5
    font_range = max_font - min_font
    cloud = []
    taggings = taggings.sort{|a,b| a['tag_name'] <=> b['tag_name']}

    taggings.each do |tagging|
    font_size = (min_font + font_range * (Math.log(tagging['count_all']) - minlog)/rangelog).round
    cloud << [tagging['tag_name'], tagging['tag_id'], font_size.to_i, tagging['count_all']] end
    return cloud
  end

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

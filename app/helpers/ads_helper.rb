module AdsHelper
  def get_ad(model)
    if model == 'topics_right'
      ads = Ad.find_by_id(5)
    else if model == 'funs_right'
          ads = Ad.find_by_id(7)
         else if model == 'fun_detail_down'
              ads = Ad.find_by_id(6)
              end
         end
    end

    return "" if ads.blank?

    return ads.body
  end
end

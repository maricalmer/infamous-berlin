class Autocomplete
  def skill_set
    ["acting", "voice acting", "singing", "oil painting",
     "acrylic painting", "digital painting", "3d drawing",
     "music producing", "dancing", "film editing", "film production",
     "video animation", "video design", "photography", "model"]
  end

  def usernames
    User.all.pluck(:username).sort
  end

  def location_set
    ["Kreuzberg", "Mitte", "Wedding", "P.Berg",
     "Neukölln", "Friedrichshain", "Remote"]
  end

  def category_set
    ['painting', 'music production', 'photography', 'DJing',
     'sculpture', 'fashion', 'graphic design', 'other']
  end
end

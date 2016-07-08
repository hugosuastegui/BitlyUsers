class Url < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  
  validates :url_long, format: { with: /([https])\w+:+\/+\//,
  message: "Solo son validos las paginas que comiencen http:// o https://"
} 

  before_create :short_url


  def short_url
    # base = "http://mauyhugo/"
    random = Randomstring.generate(4)
    # pagina = base + random
    self.url_short = random
  end


end



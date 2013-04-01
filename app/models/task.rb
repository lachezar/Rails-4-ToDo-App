class Task < ActiveRecord::Base
  has_many :tags

  # http://en.wikipedia.org/wiki/Most_common_words_in_English
  # list of most common words in English longer than 3 letters
  @@common_words = %w{play watch do visit drink check that have with this from they will would there their what about which when make like time just know take people into year your good some could them other than then look only come over think also back after work first well even want because these give most us}
  @@whitelisted_words = %w{cat dog}

  def generate_tags!
    tags = self.title.split.map(&:downcase).select { |w| @@whitelisted_words.include? w or (w.length > 3 and @@common_words.exclude? w) }
    self.tags = tags.map { |t| Tag.new(:name => t) }
  end

end

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess letter
    if
      letter.nil? or not letter =~ /^[A-Za-z]$/
      raise ArgumentError.new
    end
    letter.downcase!
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end

  def word_with_guesses
    return '-' * @word.length unless not @guesses.empty?
    return @word.tr("^#{@guesses}", '-')
  end

  def check_win_or_lose
    if @word.tr("#{@guesses}",'').empty?
      return :win
    elsif @wrong_guesses.length < 7
      return :play
    else
      return :lose
    end
    return
  end

  attr_reader :word, :guesses, :wrong_guesses

end

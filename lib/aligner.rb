class Aligner
  attr_reader :to_s, :margin

  def self.align(input, margin)
    new(input, margin).to_s
  end

  def initialize(input, margin)
    @to_s, @margin = "", margin
    input.split(/\n\s*\n/m).each do |paragraph|
      self << paragraph
    end
    to_s << "\n" if input =~ /\n\s*$/
  end

  protected

  def <<(paragraph)
    @to_s << "\n\n" unless @to_s.empty?
    @paragraph, @line = paragraph, ""
    if listing?
      parse_list
    else
      @prefix = @paragraph[/\s*/m]
      parse @paragraph
    end
    @to_s << @line
  end

  private

  def parse_list
    items = @paragraph.split /^#{Regexp.escape(@list_prefix)}/
    @prefix = @list_prefix.gsub /[\*-]/, " "
    items.shift
    items.each do |item|
      @to_s << @line << "\n" unless @line.empty?
      @line = @list_prefix[0..-2]
      parse item
    end
  end

  def parse(input)
    input.split(/\s+/).each { |w| add_word(w) unless w.empty? }
  end

  def listing?
    @list_prefix = $1 if @paragraph =~ /^(\s*[\*-]\s*)/m
  end

  def add_word(word)
    return(@line << @prefix << word) if @line.empty?
    if @line.length + word.length < margin
      @line << " " << word
    else
      @to_s << @line << "\n"
      @line = ""
      add_word word
    end
  end
end

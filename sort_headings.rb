class SortHeadings
  def initialize(headings = HEADINGS_TO_SORT)
    @headings = headings
  end

  def sort_headings
    sorted_headings = ''
    initial_counter = INITIAL_HEADING_COUNTER
    current_paragraph_nesting = 0
    current_node = 1.1

    headings.each do |heading|
      if heading[:heading_level].zero?
        sorted_headings << "#{initial_counter}. #{heading[:title]} \n"
        initial_counter = initial_counter + 1
      else
        if heading[:heading_level] > current_paragraph_nesting
          additional_breaks = current_paragraph_nesting + (heading[:heading_level] - current_paragraph_nesting)
          paragraph = "#{define_additional_breaks(additional_breaks)}#{current_node}.#{define_rest_value(additional_breaks)}"
        else
          current_node = (current_node + 0.1).round(1)
          paragraph = "#{define_additional_breaks(heading[:heading_level])}#{current_node}"
        end

        current_paragraph_nesting = heading[:heading_level]
        sorted_headings << "#{paragraph}. #{heading[:title]} \n"
      end
    end

    puts sorted_headings
  end

  private

  attr_reader :headings

  HEADINGS_TO_SORT = [
    { id: 1, title: "heading1", heading_level: 0 },
    { id: 2, title: "heading2", heading_level: 2 },
    { id: 3, title: "heading3", heading_level: 1 },
    { id: 4, title: "heading4", heading_level: 1 }
  ].freeze
  INITIAL_HEADING_COUNTER = 1
  EMPTY_SPACE = ' '.freeze

  def define_rest_value(nesting_count)
    arr = []
    (0...nesting_count - 1).each {|_i| arr << 1}

    arr.join('.')
  end

  def define_additional_breaks(additional_breaks)
    EMPTY_SPACE * additional_breaks
  end
end


SortHeadings.new.sort_headings

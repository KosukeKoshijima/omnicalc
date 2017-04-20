class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length - @text.count("\r")

    @character_count_without_spaces = @text.gsub(" ","").length - @text.count("\n") - @text.count("\r")

    @word_count = @text.split.size

    @occurrences = @text.downcase.scan(@special_word.downcase).count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@apr / 12 / 100 * @principal) / (1 - ((1 + @apr / 12 / 100) ** ((-1) * @years * 12)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = (@ending - @starting).abs
    @minutes = @seconds / 60
    @hours =  @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
a = @numbers
    @sorted_numbers = a.sort

    @count = a.count

    @minimum = a.min

    @maximum = a.max

    @range = @maximum-@minimum

    @len = @sorted_numbers.length
    @median = (@sorted_numbers[(@len - 1) / 2] + @sorted_numbers[@len / 2]) / 2.0

    @sum = a.sum

    @mean = @sum/@count

    @variance = a.inject(0){|sum, i| sum + (i - @mean) ** 2 }/@count

    @standard_deviation = Math.sqrt(@variance)

    @mode = a.max_by {|value| a.count(value)}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

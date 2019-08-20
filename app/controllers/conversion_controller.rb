class ConversionController < ApplicationController

  def new
  end

  def return_roman_numeral
    i = param[:integer_input].to_i
    if !is_param_integer?(param[:integer_input])
      flash[:danger] = "Please enter a valid integer"
      redirect_to root_path
    elsif i < 1 || i > 99999
      flash[:danger] = "Please enter an integer between 1 and 99999"
      redirect_to root_path
    else
      @roman_numeral = convert(i)
      render 'conversion/new'
    end
  end

  # convert takes an integer and return the corresponding roman numeral
  def convert(i)
    roman_symbols_hash = {1 => "I", 4 => "IV", 5 => "V", 9 => "IX", 10 => "X", 40 => "XL", 50 => "L", 90 => "XC", 100 => "C", 400 => "CD", 500 => "D", 900 => "CM", 1000 => "M"}
    roman_numeral = ''
    roman_symbols_hash.keys.reverse_each do |val|
      quotient = i / val
      next if quotient == 0
      roman_numeral << roman_symbols_hash[val] * quotient
      i = i % val
      break if i == 0
    end
    return roman_numeral
  end

  #is_param_integer? method checks whether the input is an integer or not
  def is_param_integer?(param)
    param.to_i.to_s == param
  end

  def param
    params.permit(:integer_input)
  end

end
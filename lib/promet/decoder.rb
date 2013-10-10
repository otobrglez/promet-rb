# coding: utf-8
require "oj"

class Promet::Decoder

  def initialize string
    @string, @i = string, 0
  end

  def ch char
    ((255 - char.ord) % 65536).chr "UTF-8"
  end

  def decode
    s_size = @string.size
    out = ''
    i = 0

    while i < s_size
      out << ch(@string[i])
      i += 2
    end

    s = @string[0,(s_size-1)] if (s_size > 0) and (s_size % 2 == 1)

    i = s.size - 1
    while i >= 0
      out << ch(s[i])
      i += -2
    end

    right_json = out.gsub!(/new\ Date\((?<time>\d+)\)/i,'\k<time>')
		Oj.load(right_json)
  end

end


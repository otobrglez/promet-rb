# coding: utf-8

class Promet::Decoder

  class << self

    def ch char
      ((255 - char.ord) % 65536).chr "UTF-8"
    end

    def decode string
      s_size = string.size
      out = ''
      i = 0

      while i < s_size
        out << ch(string[i])
        i += 2
      end

      s = string[0,(s_size-1)] if (s_size > 0) and (s_size % 2 == 1)

      i = s.size - 1
      while i >= 0
        out << ch(s[i])
        i += -2
      end

      right_json = out.gsub!(/new\ Date\((?<time>\d+)\)/i,'\k<time>')
      JSON.parse(right_json)
    end

  end


end


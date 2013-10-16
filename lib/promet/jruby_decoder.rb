# coding: utf-8

require 'java'
require 'singleton'

# 'java_import' is used to import java classes
java_import 'java.util.concurrent.Callable'
java_import 'java.util.concurrent.FutureTask'
java_import 'java.util.concurrent.LinkedBlockingQueue'
java_import 'java.util.concurrent.ThreadPoolExecutor'
java_import 'java.util.concurrent.TimeUnit'

class Promet::Decoder
  include Singleton

  attr_accessor :first_part, :second_part

  def self.ch char
    ((255 - char.ord) % 65536).chr "UTF-8"
  end

  def self.decode string
    executor = ThreadPoolExecutor.new(2, # core_pool_treads
                                      2, # max_pool_threads
                                      60, # keep_alive_time
                                      TimeUnit::SECONDS,
                                      LinkedBlockingQueue.new)
    tasks=[]

    task_1 = FutureTask.new Promet::Decoder::LRDecoder.new(string)
    task_2 = FutureTask.new Promet::Decoder::RLDecoder.new(string)

    executor.execute(task_1)
    executor.execute(task_2)

    tasks << task_1
    tasks << task_2

    tasks.each { |t| t.get }

    executor.shutdown()

    raw = Promet::Decoder.instance.first_part+Promet::Decoder.instance.second_part

    right_json = raw.gsub!(/new\ Date\((?<time>\d+)\)/i,'\k<time>')
    JSON.parse(right_json)
  end

  class LRDecoder
    include Callable

    def initialize string
      @out = ''
      @string = string
    end

    def call
      i = 0
      s_size = @string.size

      while i < s_size
        @out << Promet::Decoder.ch(@string[i])
        i += 2
      end

      Promet::Decoder.instance.first_part = @out
    end
  end

  class RLDecoder
    include Callable

    def initialize string
      @out = ''
      @string = string
    end

    def call
      s_size = @string.size
      s = @string[0,(s_size-1)] if (s_size > 0) and (s_size % 2 == 1)

      i = s.size - 1
      while i >= 0
        @out << Promet::Decoder.ch(s[i])
        i += -2
      end

      Promet::Decoder.instance.second_part = @out
    end
  end

end

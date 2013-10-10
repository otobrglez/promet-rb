require "spec_helper"

describe Promet::Decoder do

  let(:raw_file) { File.open("./spec/raw/events.txt","r:UTF-8") {|f| f.read } }

  context "#decode" do
    subject { Promet::Decoder.new(raw_file) }
    its(:decode){ should_not eq nil }
  end

end


require 'minitest/autorun'
require 'aligner'

class AlginerTest < MiniTest::Unit::TestCase
  def self.expect(margin, from, to)
    define_method("test_#{@i = (@i || 0) + 1}") do
      a, b = to, Aligner.align(from, margin)
      assert_equal a, b, "Expected:\n#{a}\nWas:\n#{b}"
    end
  end

  expect 20, %{foo}, %{foo}
  
  expect 20, <<-IN, <<-OUT
    foo bar blah blubb jo jo no
  IN
    foo bar blah
    blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
    foo bar blah blubb jo jo no
    
    foo bar blah blubb jo jo no
  IN
    foo bar blah
    blubb jo jo no

    foo bar blah
    blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
    foo bar blah blubb jo jo no
    
      foo bar blah blubb jo jo no
  IN
    foo bar blah
    blubb jo jo no

      foo bar blah
      blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
      foo bar blah blubb jo jo no
    
    foo bar blah blubb jo jo no
  IN
      foo bar blah
      blubb jo jo no

    foo bar blah
    blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
    foo bar
    blah blubb jo jo no
  IN
    foo bar blah
    blubb jo jo no
  OUT
  
  expect 20, <<-IN, <<-OUT
    11111111111111111111111111111111111
    22222222222222222222222222222222222
    3333333333333333   3333333333333333
  IN
    11111111111111111111111111111111111
    22222222222222222222222222222222222
    3333333333333333
    3333333333333333
  OUT

  expect 20, <<-IN, <<-OUT
    * foo bar blah blubb jo jo no
    
    * foo bar blah blubb jo jo no
  IN
    * foo bar blah
      blubb jo jo no

    * foo bar blah
      blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
    * foo bar blah blubb jo jo no
    
    - foo bar blah blubb jo jo no
  IN
    * foo bar blah
      blubb jo jo no

    - foo bar blah
      blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
    * foo
    bar blah blubb jo jo no
    
    * foo bar blah blubb jo jo
        no
  IN
    * foo bar blah
      blubb jo jo no

    * foo bar blah
      blubb jo jo no
  OUT

  expect 20, <<-IN, <<-OUT
    - foo bar blah blubb jo jo no
    - foo bar blah blubb jo jo no
  IN
    - foo bar blah
      blubb jo jo no
    - foo bar blah
      blubb jo jo no
  OUT
end

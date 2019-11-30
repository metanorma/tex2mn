# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestMncite < Minitest::Test
  def test_minimal
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712>>

    OUTPUT
      \mncite{ISO712}
    INPUT
  end

  def test_citation_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,the foregoing reference>>

    OUTPUT
      \mncite[the foregoing reference]{ISO712}
    INPUT
  end

  def test_standard_localities
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,section=5,page=8-10>>

    OUTPUT
      \mncite{ISO712}[section=5,page=8-10]
    INPUT
  end

  def test_locality_with_special_characters
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,section="5-3-1,bis">>

    OUTPUT
      \mncite{ISO712}[section="5-3-1,bis"]
    INPUT
  end

  def test_custom_localities
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,locality:frontispiece=5,page=8-10>>

    OUTPUT
      \mncite{ISO712}[locality:frontispiece=5,page=8-10]
    INPUT
  end

  def test_full_example
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,clause=5,table=1,this table>>

    OUTPUT
      \mncite[this table]{ISO712}[clause=5,table=1]
    INPUT
  end
end

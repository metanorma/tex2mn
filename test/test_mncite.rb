# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestMncite < Minitest::Test
  def test_minimal
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712>>

    OUTPUT
      \begin{document}
        \mncite{ISO712}
      \end{document}
    INPUT
  end

  def test_citation_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,the foregoing reference>>

    OUTPUT
      \begin{document}
        \mncite[the foregoing reference]{ISO712}
      \end{document}
    INPUT
  end

  def test_standard_localities
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,section=5,page=8-10>>

    OUTPUT
      \begin{document}
        \mncite{ISO712}[section=5,page=8-10]
      \end{document}
    INPUT
  end

  def test_locality_with_special_characters
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,section="5-3-1,bis">>

    OUTPUT
      \begin{document}
        \mncite{ISO712}[section="5-3-1,bis"]
      \end{document}
    INPUT
  end

  def test_custom_localities
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,locality:frontispiece=5,page=8-10>>

    OUTPUT
      \begin{document}
        \mncite{ISO712}[locality:frontispiece=5,page=8-10]
      \end{document}
    INPUT
  end

  def test_full_example
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      <<ISO712,clause=5,table=1,this table>>

    OUTPUT
      \begin{document}
        \mncite[this table]{ISO712}[clause=5,table=1]
      \end{document}
    INPUT
  end
end

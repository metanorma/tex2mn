require "minitest/autorun"
require "helper"

class TestTitle < Minitest::Test
  def test_title
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      = Document title
      :attribute: value

    OUTPUT
      \documentclass{metanorma}
      \set{attribute}{value}
      \title{Document title}
      \begin{document}
      \end{document}
    INPUT
  end
end

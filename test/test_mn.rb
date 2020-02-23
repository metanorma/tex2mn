# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestMn < Minitest::Test
  def test_underscore_usage
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[fig1]]
      [link=https://en.wikipedia.org/wiki/Underscore_(disambiguation)]
      image::example-image-a[]

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}
          \mn{link=https://en.wikipedia.org/wiki/Underscore_(disambiguation)}
          \includegraphics{example-image-a}
        \end{figure}
      \end{document}
    INPUT
  end
end

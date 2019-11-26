# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestLinks < Minitest::Test
  def test_link_without_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Go look at link:++https://www.metanorma.com/++[].

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Go look at \url{https://www.metanorma.com/}.

      \end{document}
    INPUT
  end

  def test_link_with_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Go look at link:++https://www.metanorma.com/++[Metanorma home].

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Go look at \href{https://www.metanorma.com/}{Metanorma home}.

      \end{document}
    INPUT
  end
end

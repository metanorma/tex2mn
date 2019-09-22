require "minitest/autorun"
require "helper"

class TestFootnotes < Minitest::Test
  def test_footnote
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        This text has a footnote\footnote{Here is the footnote text.}.
      \end{document}
    INPUT
      This text has a footnote footnote:[Here is the footnote text.].

    OUTPUT
  end
end

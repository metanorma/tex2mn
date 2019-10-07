# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestFootnotes < Minitest::Test
  def test_footnote
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      This text has a footnote footnote:[Here is the footnote text.].

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        This text has a footnote\footnote{Here is the footnote text.}.
      \end{document}
    INPUT
  end
end

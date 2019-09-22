require "minitest/autorun"
require "helper"

class TestTextFormatting < Minitest::Test
  def test_bold_text
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Bold \textbf{text} and {\bfseries bold group}.
      \end{document}
    INPUT

      Bold **text** and **bold group**.
    OUTPUT
  end

  def test_italic_text
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Italic \textit{text} and {\itshape italic group}.
      \end{document}
    INPUT

      Italic __text__ and __italic group__.
    OUTPUT
  end

  def test_smallcaps_text
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Smallcaps \textsc{text} and {\scshape smallcaps group}.
      \end{document}
    INPUT

      Smallcaps [smallcap]#text# and [smallcap]#smallcaps group#.
    OUTPUT
  end

  def test_strikethrough_text
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Strikethrough \textst{text}.
      \end{document}
    INPUT

      Strikethrough [strike]#text#.
    OUTPUT
  end
end

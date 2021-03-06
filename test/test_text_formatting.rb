# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestTextFormatting < Minitest::Test
  def test_bold_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Bold **text** and **bold group**.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Bold \textbf{text} and {\bfseries bold group}.
      \end{document}
    INPUT
  end

  def test_italic_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Italic __text__ and __italic group__.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Italic \textit{text} and {\itshape italic group}.
      \end{document}
    INPUT
  end

  def test_monospace_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Monospace ``text`` and ``monospace group``.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Monospace \texttt{text} and {\ttfamily monospace group}.
      \end{document}
    INPUT
  end

  def test_smallcaps_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Smallcaps [smallcap]#text# and [smallcap]#smallcaps group#.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Smallcaps \textsc{text} and {\scshape smallcaps group}.
      \end{document}
    INPUT
  end

  def test_strikethrough_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Strikethrough [strike]#text#.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Strikethrough \textst{text}.
      \end{document}
    INPUT
  end

  def test_superscript_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Superscript ^text^.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Superscript \textsuperscript{text}.
      \end{document}
    INPUT
  end

  def test_subscript_text
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Subscript ~text~.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Subscript \textsubscript{text}.
      \end{document}
    INPUT
  end
end

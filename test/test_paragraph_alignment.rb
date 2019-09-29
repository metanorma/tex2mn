require "minitest/autorun"
require "helper"

class TestParagraphAlignment < Minitest::Test
  def test_justified
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      This paragraph is justified.

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        This paragraph is justified.

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_left_aligned
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [align=left]
      This paragraph is left aligned.

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{flushleft}
          This paragraph is left aligned.
        \end{flushleft}

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_centered
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [align=center]
      This paragraph is centered.

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{center}
          This paragraph is centered.
        \end{center}

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_right_aligned
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [align=right]
      This paragraph is right aligned.

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{flushright}
          This paragraph is right aligned.
        \end{flushright}

        Following paragraph.
      \end{document}
    INPUT
  end
end

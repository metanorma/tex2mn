require "minitest/autorun"
require "helper"

class TestAdmonitions < Minitest::Test
  def test_note
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{note}
          This is a note.
        \end{note}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [NOTE]
      ====
      This is a note.
      ====

      Following paragraph.

    OUTPUT
  end

  def test_tip
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{tip}
          This is a tip.
        \end{tip}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [TIP]
      ====
      This is a tip.
      ====

      Following paragraph.

    OUTPUT
  end

  def test_important
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{important}
          This is important.
        \end{important}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [IMPORTANT]
      ====
      This is important.
      ====

      Following paragraph.

    OUTPUT
  end

  def test_caution
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{caution}
          This is a cautionary advice.
        \end{caution}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [CAUTION]
      ====
      This is a cautionary advice.
      ====

      Following paragraph.

    OUTPUT
  end

  def test_warning
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{warning}
          This is a warning.
        \end{warning}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [WARNING]
      ====
      This is a warning.
      ====

      Following paragraph.

    OUTPUT
  end

  def test_long_note
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{note}
          This is a note.

          It contains multiple paragraphs.

          It is pretty long.
        \end{note}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [NOTE]
      ====
      This is a note.

      It contains multiple paragraphs.

      It is pretty long.
      ====

      Following paragraph.

    OUTPUT
  end
end

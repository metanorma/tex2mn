require "minitest/autorun"
require "helper"

class TestBlockQuotations < Minitest::Test
  def test_single_paragraph
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{quote}
          This is a quote with a single paragraph.
        \end{quote}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [quote]
      -----
      This is a quote with a single paragraph.
      -----

      Following paragraph.

    OUTPUT
  end

  def test_multiple_paragraphs
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{quote}
          This is a quote with a multiple paragraphs.

          Here is the second one.

          And a third one, for good measure.
        \end{quote}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [quote]
      -----
      This is a quote with a multiple paragraphs.

      Here is the second one.

      And a third one, for good measure.
      -----

      Following paragraph.

    OUTPUT
  end

  def test_attributes
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{quote}
          \mn{ISO,"ISO7301,section 1"}
          This quotation has attributes.
        \end{quote}

        Following paragraph.
      \end{document}
    INPUT
      Previous paragraph.

      [quote,ISO,"ISO7301,section 1"]
      -----
      This quotation has attributes.
      -----

      Following paragraph.

    OUTPUT
  end
end

require "minitest/autorun"
require "helper"

class TestBlockQuotations < Minitest::Test
  def test_single_paragraph
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [quote]
      -----
      This is a quote with a single paragraph.
      -----

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{quote}
          This is a quote with a single paragraph.
        \end{quote}

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_multiple_paragraphs
    skip "see https://github.com/metanorma/tex2mn/issues/33"
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [quote]
      -----
      This is a quote with a multiple paragraphs.

      Here is the second one.

      And a third one, for good measure.
      -----

      Following paragraph.

    OUTPUT
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
  end

  def test_attributes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [quote,ISO,"ISO7301,section 1"]
      -----
      This quotation has attributes.
      -----

      Following paragraph.

    OUTPUT
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
  end
end

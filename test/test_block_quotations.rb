# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestBlockQuotations < Minitest::Test
  def test_single_paragraph
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [quote]
      _____
      This is a quote with a single paragraph.
      _____

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
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [quote]
      _____
      This is a quote with a multiple paragraphs.

      Here is the second one, +
      which is broken.

      And a third one, for good measure.
      _____

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{quote}
          This is a quote with a multiple paragraphs.

          Here is the second one,\\
          which is broken.

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
      _____
      This quotation has attributes.
      _____

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

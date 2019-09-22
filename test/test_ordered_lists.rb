require "minitest/autorun"
require "helper"

class TestOrderedLists < Minitest::Test
  def test_short_items
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{enumerate}
          \item Hey,
          \item ho,
          \item let's go!
        \end{enumerate}

        Following paragraph.
      \end{document}
    INPUT

      Previous paragraph.

      . Hey,
      . ho,
      . let’s go!

      Following paragraph.
    OUTPUT
  end

  def test_long_items
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{enumerate}
          \item No lines here.
      
          \item This is a paragraph\\
                containing a line break.
      
          \item This is a paragraph.
      
                This is another paragraph.
        \end{enumerate}

        Following paragraph.
      \end{document}
    INPUT

      Previous paragraph.

      . No lines here.
      . This is a paragraph +
      containing a line break.
      . This is a paragraph.
      +
      This is another paragraph.

      Following paragraph.
    OUTPUT
  end

  def test_nesting
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{enumerate}
          \item A0
          \item B0
          \begin{enumerate}
            \item A1
            \item B1
          \end{enumerate}
          \item C0
          \begin{enumerate}
            \item A1
            \item B1
            \begin{enumerate}
              \item A2
              \item B2
              \begin{enumerate}
                \item A3
                \item B3
                \item C3
              \end{enumerate}
              \item C2
            \end{enumerate}
            \item C1
          \end{enumerate}
        \end{enumerate}

        Following paragraph.
      \end{document}
    INPUT

      Previous paragraph.

      . A0
      . B0
      .. A1
      .. B1
      . C0
      .. A1
      .. B1
      ... A2
      ... B2
      .... A3
      .... B3
      .... C3
      ... C2
      .. C1

      Following paragraph.
    OUTPUT
  end
end

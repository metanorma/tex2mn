require "minitest/autorun"
require "helper"

class TestHeadings < Minitest::Test
  def test_levels
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Lorem ipsum.

        \section{L1 heading}

        Lorem ipsum.

        \subsection{L2 heading}

        Lorem ipsum.

        \subsubsection{L3 heading}

        Lorem ipsum.

        \paragraph{L4 heading}

        Lorem ipsum.

        \subparagraph{L5 heading}

        Lorem ipsum.

        \subparagraph{L6 heading}
        \mn{level=6}

        Lorem ipsum.

        \subparagraph{L7 heading}
        \mn{level=7}

        Lorem ipsum.
      \end{document}
    INPUT
      Lorem ipsum.

      == L1 heading

      Lorem ipsum.

      === L2 heading

      Lorem ipsum.

      ==== L3 heading

      Lorem ipsum.

      ===== L4 heading

      Lorem ipsum.

      ====== L5 heading

      Lorem ipsum.

      [level=6]
      ====== L6 heading

      Lorem ipsum.

      [level=7]
      ====== L7 heading

      Lorem ipsum.

    OUTPUT
  end

  def test_blank_levels
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Lorem ipsum.

        \section{}

        Lorem ipsum.

        \subsection{}

        Lorem ipsum.

        \subsubsection{}

        Lorem ipsum.

        \paragraph{}

        Lorem ipsum.

        \subparagraph{}

        Lorem ipsum.

        \subparagraph{}
        \mn{level=6}

        Lorem ipsum.

        \subparagraph{}
        \mn{level=7}

        Lorem ipsum.

      \end{document}
    INPUT
      Lorem ipsum.

      == {blank}

      Lorem ipsum.

      === {blank}

      Lorem ipsum.

      ==== {blank}

      Lorem ipsum.

      ===== {blank}

      Lorem ipsum.

      ====== {blank}

      Lorem ipsum.

      [level=6]
      ====== {blank}

      Lorem ipsum.

      [level=7]
      ====== {blank}

      Lorem ipsum.

    OUTPUT
  end

  def test_attributes
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Lorem ipsum.

        \section{Termini e definizioni}
        \mn{heading=terms and definitions}

        Lorem ipsum.

        \section{Annex}
        \mn{annex}

        Lorem ipsum.

        \section{Inline header}
        \mn{\%inline-header}

        Lorem ipsum.
      \end{document}
    INPUT
      Lorem ipsum.

      [heading=terms and definitions]
      == Termini e definizioni

      Lorem ipsum.

      [annex]
      == Annex

      Lorem ipsum.

      [%inline-header]
      == Inline header

      Lorem ipsum.

    OUTPUT
  end
end

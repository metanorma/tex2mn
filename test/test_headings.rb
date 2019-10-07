# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestHeadings < Minitest::Test
  def test_levels
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
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
        \mna{level=6}

        Lorem ipsum.

        \subparagraph{L7 heading}
        \mna{level=7}

        Lorem ipsum.
      \end{document}
    INPUT
  end

  def test_blank_levels
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
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
        \mna{level=6}

        Lorem ipsum.

        \subparagraph{}
        \mna{level=7}

        Lorem ipsum.

      \end{document}
    INPUT
  end

  def test_attributes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Lorem ipsum.

      [[foobar]]
      == The foo and the bar

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
      \documentclass{metanorma}
      \begin{document}
        Lorem ipsum.

        \section{The foo and the bar}
        \label{foobar}

        Lorem ipsum.

        \section{Termini e definizioni}
        \mna{heading=terms and definitions}

        Lorem ipsum.

        \section{Annex}
        \mna{annex}

        Lorem ipsum.

        \section{Inline header}
        \mna{\%inline-header}

        Lorem ipsum.
      \end{document}
    INPUT
  end
end

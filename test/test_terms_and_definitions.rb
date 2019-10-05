require "minitest/autorun"
require "helper"

class TestTermsAndDefinitions < Minitest::Test
  def test_rough_example
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[paddy]]
      === paddy

      alt:[paddy rice]
      alt:[rough rice]
      deprecated:[cargo rice]
      domain:[rice]

      rice retaining its husk after threshing

      [example]
      ====
      Foreign seeds, husks, bran, sand, dust.
      ====

      [NOTE]
      ====
      The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.
      ====

      [.source]
      <<ISO7301>>, The term ”cargo rice” is shown as deprecated, and Note 1 to entry is not included here

      [bibliography]
      == References

      * [[[ISO7301,1]]] Rice Specification


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \subsection{paddy}
        \label{paddy}
        \alt{paddy rice}
        \alt{rough \textbf{rice}}
        \deprecated{cargo rice}
        \domain{rice}

        rice retaining its husk after threshing

        \begin{example}
          Foreign seeds, husks, bran, sand, dust.
        \end{example}

        \begin{note}
          The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.
        \end{note}

        \begin{source}
          \ref{ISO7301}, The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here
        \end{source}

        \begin{thebibliography}{1}
          \bibitem{ISO7301} Rice Specification
        \end{thebibliography}
      \end{document}
    INPUT
  end
end

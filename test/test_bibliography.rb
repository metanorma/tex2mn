require "minitest/autorun"
require "helper"

class TestBibliography < Minitest::Test
  def test_embedded
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      This document is an example of thebibliography environment using
      in bibliography management. Three items are cited: __The LaTeX Companion__
      book <<latexcompanion>>, the Einstein journal paper <<einstein>>, and the
      Donald Knuth’s website <<knuthwebsite>>. The LaTeX related items are
      <<latexcompanion>><<knuthwebsite>>.

      [bibliography]
      == References

      * [[[latexcompanion,1]]]
      Michel Goossens, Frank Mittelbach, and Alexander Samarin.
      __The LaTeX Companion__.
      Addison-Wesley, Reading, Massachusetts, 1993.

      * [[[einstein,2]]]
      Albert Einstein.
      __Zur Elektrodynamik bewegter Körper__. (German)
      [__On the electrodynamics of moving bodies__].
      Annalen der Physik, 322(10):891–921, 1905.

      * [[[knuthwebsite,3]]]
      Knuth: Computers and Typesetting,
      http://www-cs-faculty.stanford.edu/~uno/abcde.html

    OUTPUT
      \documentclass{metanorma}

      \begin{document}
        This document is an example of \texttt{thebibliography} environment using
        in bibliography management. Three items are cited: \textit{The \LaTeX\ Companion}
        book \cite{latexcompanion}, the Einstein journal paper \cite{einstein}, and the
        Donald Knuth's website \cite{knuthwebsite}. The \LaTeX\ related items are
        \cite{latexcompanion,knuthwebsite}.

        \begin{thebibliography}{3}
          \bibitem{latexcompanion}
            Michel Goossens, Frank Mittelbach, and Alexander Samarin.
            \textit{The \LaTeX\ Companion}.
            Addison-Wesley, Reading, Massachusetts, 1993.

          \bibitem{einstein}
            Albert Einstein.
            \textit{Zur Elektrodynamik bewegter K{\"o}rper}. (German)
            [\textit{On the electrodynamics of moving bodies}].
            Annalen der Physik, 322(10):891–921, 1905.

          \bibitem{knuthwebsite}
            Knuth: Computers and Typesetting,
            \\\texttt{http://www-cs-faculty.stanford.edu/\~{}uno/abcde.html}
        \end{thebibliography}
      \end{document}
    INPUT
  end
end

# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestBibliography < Minitest::Test
  def test_bibtex
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      As seen in <<einstein>>, this is cool stuff.
      Other references are <<latexcompanion>> and <<knuthwebsite>>.

      [bibliography]
      == References

      * [[[einstein,1]]]
      {blank}A. Einstein (1905)
      Zur Elektrodynamik bewegter Körper. (German) [On the electrodynamics of moving bodies].
      Annalen der Physik322 (10),  pp. 891–921.
      External Links: link:++http://dx.doi.org/http%3A//dx.doi.org/10.1002/andp.19053221004++[Document]

      * [[[latexcompanion,2]]]
      {blank}M. Goossens, F. Mittelbach, and A. Samarin (1993)
      The latex companion.
      Addison-Wesley, Reading, Massachusetts.

      * [[[knuthwebsite,3]]]
      {blank}D. Knuth
      Knuth: computers and typesetting.
      External Links: link:++http://www-cs-faculty.stanford.edu/\~uno/abcde.html++[Link]

    OUTPUT
      \documentclass{Metanorma}

      \begin{document}
        As seen in \cite{einstein}, this is cool stuff.
        Other references are \cite{latexcompanion} and \cite{knuthwebsite}.

        \bibliography{test/fixtures/sample}
      \end{document}
    INPUT
  end

  def test_embedded
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      This document is an example of thebibliography environment using
      in bibliography management. Three items are cited: __The LaTeX Companion__
      book <<latexcompanion>>, the Einstein journal paper <<einstein>>, and the
      Donald Knuth’s website <<knuthwebsite>>.

      [bibliography]
      == References

      * [[[ISO7301,ISO 7301]]]
      Rice – Specification

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
        Donald Knuth's website \cite{knuthwebsite}.

        \begin{thebibliography}{3}
          \bibitem[ISO 7301]{ISO7301}
          Rice -- Specification

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

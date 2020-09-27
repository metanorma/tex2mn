# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestDocumentAuthors < Minitest::Test
  def test_single_author
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      :author: John Doe

      Document authored by {author}.

    OUTPUT
      \documentclass{metanorma}
      \set{author}{John Doe}
      \begin{document}
        Document authored by \get{author}.
      \end{document}
    INPUT
  end

  def test_multiple_authors
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      :author_1: Tom Sawyer
      :author_2: Dick Tracy
      :author_3: Harry Potter

      Document authored by {author_1}, {author_2}, and {author_3}.

    OUTPUT
      \documentclass{metanorma}
      \set{author_1}{Tom Sawyer}
      \set{author_2}{Dick Tracy}
      \set{author_3}{Harry Potter}
      \begin{document}
        Document authored by \get{author_1}, \get{author_2}, and \get{author_3}.
      \end{document}
    INPUT
  end

  def test_author_macro_is_ignored
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Lorem ipsum.

    OUTPUT
    \documentclass{metanorma}
    \author{John Doe}
    \begin{document}
      Lorem ipsum.
    \end{document}
    INPUT
  end
end

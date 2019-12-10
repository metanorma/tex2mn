# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestReviewerNotes < Minitest::Test
  def test_reviewer_note
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [reviewer="John Doe",date=20180125T0121,from=A,to=B]
      ****
      Lorem ipsum.
      ****

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}

        Previous paragraph.

        \begin{reviewernote}
          \mn{reviewer="John Doe",date=20180125T0121,from=A,to=B}
          Lorem ipsum.
        \end{reviewernote}

        Following paragraph.
      \end{document}
    INPUT
  end
end

# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestForeword < Minitest::Test
  def test_name
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
    [[Foreword]]
    .Foreword
    Lorem ipsum.

    Lorem ipsum.

    == Stuff

    Lorem ipsum.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \section{Foreword}

        Lorem ipsum.

        Lorem ipsum.

        \section{Stuff}

        Lorem ipsum.
      \end{document}
    INPUT
  end

  def test_attribute
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
    [[Foreword]]
    .Prefazione
    Lorem ipsum.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \section{Prefazione}
        \mn{heading=foreword}

        Lorem ipsum.
      \end{document}
    INPUT
  end
end

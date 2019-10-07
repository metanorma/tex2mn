# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestMathEnvironments < Minitest::Test
  def test_equation
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [stem]
      ++++
      f(x)=(x+a)(x+b)
      ++++


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{equation}
          f(x)=(x+a)(x+b)
        \end{equation}
      \end{document}
    INPUT
  end

  def test_equation_with_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[eq:quadratic]]
      [stem]
      ++++
      f(x)=(x+a)(x+b)
      ++++


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{equation}\label{eq:quadratic}
          f(x)=(x+a)(x+b)
        \end{equation}
      \end{document}
    INPUT
  end

  def test_gather
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [stem]
      ++++
      \displaystyle A
      ++++

      [stem]
      ++++
      \displaystyle B
      ++++

      [stem]
      ++++
      \displaystyle C
      ++++


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{gather}
          A \\
          B \\
          C \\
        \end{gather}
      \end{document}
    INPUT
  end

  def test_gather_with_labels
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[eq:A]]
      [stem]
      ++++
      \displaystyle A
      ++++

      [[eq:B]]
      [stem]
      ++++
      \displaystyle B
      ++++

      [[eq:C]]
      [stem]
      ++++
      \displaystyle C
      ++++


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{gather}
          A \label{eq:A}\\
          B \label{eq:B}\\
          C \label{eq:C}\\
        \end{gather}
      \end{document}
    INPUT
  end

  def test_align
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [stem]
      ++++
      \displaystyle B^{\prime}=-\nabla\times E
      ++++

      [stem]
      ++++
      \displaystyle E^{\prime}=\nabla\times B-4\pi j
      ++++


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{align}
          B'&=-\nabla \times E\\
          E'&=\nabla \times B - 4\pi j
        \end{align}
      \end{document}
    INPUT
  end

  def test_align_with_labels
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[eq:MaxB]]
      [stem]
      ++++
      \displaystyle B^{\prime}=-\nabla\times E
      ++++

      [[eq:MaxE]]
      [stem]
      ++++
      \displaystyle E^{\prime}=\nabla\times B-4\pi j
      ++++


    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{align}
          B'&=-\nabla \times E         \label{eq:MaxB} \\
          E'&=\nabla \times B - 4\pi j \label{eq:MaxE}
        \end{align}
      \end{document}
    INPUT
  end
end

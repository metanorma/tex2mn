require "minitest/autorun"
require "helper"

class TestDocumentAttributes < Minitest::Test
  def test_setter
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      :my-attribute: foobar

    OUTPUT
      \documentclass{metanorma}
      \set{my-attribute}{foobar}
      \begin{document}
      \end{document}
    INPUT
  end

  def test_setter_on_boolean
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      :my-boolean:

    OUTPUT
      \documentclass{metanorma}
      \set{my-boolean}{}
      \begin{document}
      \end{document}
    INPUT
  end

  def test_getter
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      :my-attribute: foobar

      Here is the value of my attribute: {my-attribute}.

    OUTPUT
      \documentclass{metanorma}
      \set{my-attribute}{foobar}
      \begin{document}
        Here is the value of my attribute: \get{my-attribute}.
      \end{document}
    INPUT
  end

  def test_multiple_attributes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      :foo: 1
      :bar: 2
      :baz: 3

      Our values are {foo}, {bar} and {baz}.

    OUTPUT
      \documentclass{metanorma}
      \set{foo}{1}
      \set{bar}{2}
      \set{baz}{3}
      \begin{document}
        Our values are \get{foo}, \get{bar} and \get{baz}.
      \end{document}
    INPUT
  end
end

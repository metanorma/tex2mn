require 'open3'

def wrap_stderr(stderr, separator = '#'*80)
  separator + "\n" + stderr + separator
end

def render_string(string)
  command = 'latexml - --nocomments'
  stdout, stderr, status = Open3.capture3(command, stdin_data: string)
  raise StandardError.new("latexml execution failed; stderr below.\n" + wrap_stderr(stderr)) unless status.success?
  command = 'latexmlpost - --stylesheet=Metanorma.xsl --nodefaultresources --novalidate'
  stdout, stderr, status = Open3.capture3(command, stdin_data: stdout)
  raise StandardError.new("latexmlpost execution failed; stderr below.\n" + wrap_stderr(stderr)) unless status.success?
  stdout
end

def read_file(filename)
  File.read(File.join(File.dirname(__FILE__), filename))
end

def render_file(filename)
  render_string(read_file(filename))
end
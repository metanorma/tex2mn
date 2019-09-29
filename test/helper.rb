require "open3"

def wrap_stderr(stderr, separator = "#" * 80)
  separator + "\n" + stderr + separator
end

def render_string(string)
  run_latexmlpost(run_latexml(string))
end

def read_file(filename)
  File.read(File.join(File.dirname(__FILE__), filename))
end

def render_file(filename)
  render_string(read_file(filename))
end

def run_latexml(stdin_data)
  command = "latexml - --preload=Metanorma.cls --nocomments"
  stdout, stderr, status = Open3.capture3(command, stdin_data: stdin_data)
  return stdout if status.success?
  raise StandardError.new("latexml execution failed; stderr below.\n" + wrap_stderr(stderr))
end

def run_latexmlpost(stdin_data)
  command = "latexmlpost - --stylesheet=Metanorma.xsl --nodefaultresources --novalidate"
  stdout, stderr, status = Open3.capture3(command, stdin_data: stdin_data)
  return stdout if status.success?
  raise StandardError.new("latexmlpost execution failed; stderr below.\n" + wrap_stderr(stderr))
end

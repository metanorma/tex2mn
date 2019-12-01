# frozen_string_literal: true

require "open3"

def wrap_stderr(stderr)
  separator("STDERR") + "\n" + stderr + separator
end

def separator(label = "", length = 120)
  return "█" * length if label.empty?
  "██ #{label} ".yield_self { |head| head + "█" * (length - head.size) }
end

def render_string(string)
  tex = string
  xml = run_latexml(string)
  adoc = run_latexmlpost(xml)
  print_debug(tex, xml, adoc) if ENV.key?("DEBUG")
  adoc
end

def print_debug(tex, xml, adoc)
  puts ["\n", separator("TEX"), "\n", tex].join
  puts ["\n", separator("XML"), "\n", xml].join
  puts ["\n", separator("ADOC"), "\n", adoc].join
  puts [separator, "\n"].join
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
  command = "latexmlpost - --stylesheet=Metanorma.xsl --nocrossref --nodefaultresources"
  stdout, stderr, status = Open3.capture3(command, stdin_data: stdin_data)
  return stdout if status.success?
  raise StandardError.new("latexmlpost execution failed; stderr below.\n" + wrap_stderr(stderr))
end

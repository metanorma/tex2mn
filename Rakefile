require "rake/testtask"
require 'asciidoctor'

Rake::TestTask.new(:test) do |t|
  t.libs << "test" # needed to require test/helper.rb
  t.test_files = FileList["test/**/test_*.rb"]
end

namespace 'manual' do
  # NOTE: this is a distilled version of
  #   https://github.com/asciidoctor/asciidoctor-extensions-lab/blob/master/scripts/asciidoc-coalescer.rb
  #   This is helpful to produce a version of the manual which can be browsed on GitHub.
  desc 'Coalesce manual/index.adoc and its dependencies into MANUAL.adoc'
  task :build do
    source_path = 'manual/index.adoc'
    target_path = 'MANUAL.adoc'
    document = Asciidoctor.load_file source_path, safe: :unsafe, parse: false
    lines = document.reader.read.gsub(/^include::(?=.*\[\]$)/m, '\\include::')
    File.open(target_path, 'w') { |file| file.write lines }
  end

  # NOTE: this is to simplify usage of
  #   https://github.com/asciidoctor/asciidoctor-browser-extension
  #   on structured files, since it does not live reload when included files change.
  #   Editing the manual is much easier this way.
  desc 'Touches :epoch: in manual/index.adoc on changes in manual/*.adoc'
  task :watch do
    sh 'find manual/*.adoc ! -name index.adoc | entr ruby -i -pe "gsub(/(?<=^:epoch: )\d+$/,Time.now.to_i.to_s)" manual/index.adoc'
  end
end

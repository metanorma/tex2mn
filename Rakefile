require "rake/clean"
require "rake/testtask"

# NOTE: needed by print_task_title
Rake::TaskManager.record_task_metadata = true

CLEAN.include "build/"
CLOBBER.include "build/", "dist/"

Rake::TestTask.new(:test) do |task|
  task.libs << "test" # needed to require test/helper.rb
  task.test_files = FileList["test/**/test_*.rb"]
end

BUILD_TARGET_PATH = "build"

def print_task_title(task)
  puts ("#==[ #{task.name} ]" + "=" * 80)[0, 80]
end

def update_meta(filename)
  source = File.read(filename)
  # TODO: we need something smarter to handle metadata in CI when releasing
  source.gsub!("<<<VERSION>>>", ENV.fetch("VERSION", "UNRELEASED"))
  File.write(filename, source)
end

namespace :dev do
  namespace :manual do
    # NOTE: this is to simplify usage of
    #   https://github.com/asciidoctor/asciidoctor-browser-extension
    #   on structured files, since it does not live reload when included files change.
    #   Editing the manual is much easier this way.
    desc "Touches :epoch: in manual/index.adoc on changes in manual/*.adoc"
    task :watch do |task|
      print_task_title(task)
      puts "Running shell command..."
      sh <<~'BASH'.gsub(/[[:space:]]+/, " ")
           find
             manual/*.adoc
             ! -name index.adoc
           | entr
             ruby -i -pe "gsub(/(?<=^:epoch: )\d+$/,Time.now.to_i.to_s)"
             manual/index.adoc
         BASH
    end
  end
end

namespace :build do
  namespace :manual do
    # NOTE: this is a distilled version of
    #   https://github.com/asciidoctor/asciidoctor-extensions-lab/blob/master/scripts/asciidoc-coalescer.rb
    #   This is helpful to produce a version of the manual which can be browsed on GitHub.
    desc "Flatten the manual into a single ADOC file"
    task :flatten do |task|
      print_task_title(task)

      require "asciidoctor"

      source_path = "manual/index.adoc"
      target_path = "#{BUILD_TARGET_PATH}/metanorma.adoc"

      mkdir_p(BUILD_TARGET_PATH)

      puts "Running Asciidoctor..."
      document = Asciidoctor.load_file(source_path, safe: :unsafe, parse: false)
      lines = document.reader.read.gsub(/^include::(?=.*\[\]$)/m, '\\include::')
      File.open(target_path, "w") { |file| file.write lines }

      puts "Updating metadata..."
      update_meta(target_path)
    end

    desc "Compile the manual to PDF"
    task compile: %i{flatten} do |task|
      print_task_title(task)

      require "asciidoctor-pdf"

      source_path = "#{BUILD_TARGET_PATH}/metanorma.adoc"
      target_path = "#{BUILD_TARGET_PATH}/metanorma.pdf"

      # NOTE: for reference, check
      #   https://asciidoctor.org/docs/user-manual/#ruby-api-options
      puts "Running Asciidoctor..."
      Asciidoctor.convert_file(
        source_path,
        backend: :pdf,
        safe: :unsafe,
        to_file: target_path,
        attributes: {
          "source-highlighter" => "rouge",
          "pdf-theme" => "metanorma-theme.yml",
        },
      )
    end
  end

  desc "Build library"
  task :source do |task|
    print_task_title(task)

    puts "Copying files..."
    target_dir = BUILD_TARGET_PATH
    mkdir_p(target_dir)
    cp_r(Dir["source/*"], target_dir)

    puts "Updating metadata..."
    Dir["#{target_dir}/*.{cls,ltxml,xsl}"].each(&method(:update_meta))
  end

  desc "Build extra files"
  task :extra do |task|
    print_task_title(task)

    puts "Copying files..."
    target_dir = BUILD_TARGET_PATH
    mkdir_p(target_dir)
    cp_r(Dir["extra/README.md"], target_dir)
  end

  desc "Build all"
  task all: %i{manual:flatten manual:compile source extra}
end

TDS_MAP = {
  "tex/latex/metanorma/" => [
    "metanorma.cls",
    "metanorma.cls.ltxml",
    "metanorma.xsl",
  ],
  "doc/latex/metanorma/" => [
    "metanorma.pdf",
    "metanorma.adoc",
    "README.md",
  ],
}

namespace :dist do
  namespace :tds do
    desc "Prepare distributable package tree structure"
    task lay: %i{build:all} do |task|
      print_task_title(task)

      TDS_MAP.each do |target_subdir, source_filenames|
        target_fulldir = "dist/tds/#{target_subdir}"
        mkdir_p target_fulldir
        source_filenames.each do |source_filename|
          source_fulldir = "build/#{source_filename}"
          cp_r source_fulldir, target_fulldir
        end
      end
    end

    desc "Archive distributable package tree structure"
    task zip: %i{lay} do |task|
      print_task_title(task)
      Dir.chdir("dist/tds") do
        system("zip", "--recurse-paths", "../metanorma.tds.zip", ".")
      end
    end
  end

  namespace :pkg do
    desc "Prepare distributable package flat structure"
    task lay: %i{tds:lay tds:zip} do |task|
      print_task_title(task)
      source_dir = "dist/tds"
      target_dir = "dist/pkg/metanorma"
      mkdir_p target_dir

      # NOTE: we're just flattening the TDS
      cp_r Dir["#{source_dir}/**/*"].select { |f| File.file?(f) }, target_dir
      cp_r "dist/metanorma.tds.zip", "dist/pkg"
    end

    desc "Archive distributable package flat structure"
    task zip: %i{lay} do |task|
      print_task_title(task)
      Dir.chdir("dist/pkg") do
        system("zip", "--recurse-paths", "../metanorma.zip", ".")
      end
    end
  end
end

desc "Install package in your personal tree"
task install: %i{dist:tds:lay} do |task|
  print_task_title(task)
  basedir = `kpsewhich -var-value TEXMFHOME`.chomp
  cp_r "dist/tds/.", basedir
end

desc "Uninstall package from your personal tree"
task :uninstall do |task|
  print_task_title(task)
  basedir = `kpsewhich -var-value TEXMFHOME`.chomp
  subdirs = TDS_MAP.keys
  subdirs.each { |subdir| rm_rf "#{basedir}/#{subdir}" }
end

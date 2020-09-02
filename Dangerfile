def report_coverage
  report_path="coverage.txt"

  if File.exist?(report_path)
    report = File.open(report_path)
    markdown(report.read)
  else
    fail("Could not run report coverage, file coverage.txt doesn't exists")
  end
end

report_coverage()

active_files = (git.modified_files + git.added_files).uniq
markdowns = active_files.select { |file| file.include?('coverage.txt') }
markdowns.each do |filename|
  file = File.read(filename)
  lines = file.lines
  lines.each do |l|
      markdown(l) if l.include? "Development"
  end
end

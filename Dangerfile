report_path="coverage.txt"

def report_coverage
  if File.exist?(report_path)
    report = File.open(report_path)
    markdown(report)
  else
    fail("Could not run report coverage, file coverage.txt doesn't exists")
  end
end

report_coverage()

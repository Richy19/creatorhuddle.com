$debug_screenshot_number = 0
$debug_screenshot_timestamp = DateTime.now.to_i
$debug_screenshot_directory = File.join(Rails.root, "spec/tmp/spec_screenshots")
def screenshot(full=false)
  screenshot_path = "#{$debug_screenshot_directory}/#{$debug_screenshot_timestamp.to_s}-#{$debug_screenshot_number.to_s}.png"
  save_screenshot(screenshot_path, full: full)
  $debug_screenshot_number += 1
  puts "Saved screenshot to: #{screenshot_path}"
end

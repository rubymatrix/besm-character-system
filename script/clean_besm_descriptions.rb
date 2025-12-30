require 'json'
require 'pathname'

def clean_description(text)
  return text if text.nil? || text.empty?

  # 1. Remove garbage lines/artifacts
  # Remove "Greg Doachi..." watermarks
  text = text.gsub(/Greg Doachi\(.*?\)/, '')
  # Remove Page numbering like "---PAGE 158---" or "PAGE 156"
  text = text.gsub(/---PAGE \d+---/, '')
  text = text.gsub(/PAGE\s*\d+/, '')
  # Remove Header artifacts like "07: DEFECTS"
  text = text.gsub(/^\d+:\s+[A-Z &]+\s*$/, '')

  # 2. Split into lines to process paragraph logic
  lines = text.split("\n").map(&:strip).reject(&:empty?)

  new_text = ""
  current_paragraph = ""

  lines.each_with_index do |line, index|
    # If it's a header (ALL CAPS and significant length), treat as new section
    if line.match?(/^[A-Z0-9\s\W]{4,}$/) && !line.match?(/[a-z]/)
      # Flush current paragraph
      new_text += current_paragraph + "\n\n" unless current_paragraph.empty?
      current_paragraph = ""

      # Add header
      new_text += "## #{line.split.map(&:capitalize).join(' ')}\n\n"
      next
    end

    if current_paragraph.empty?
      current_paragraph = line
    else
      # Check if we should split paragraph
      # Heuristic: Previous line ended with punctuation, new line starts with Capital
      last_char = current_paragraph[-1]

      # Handle hyphenation at line end
      if last_char == '-'
         # If ends in hyphen, assume it splits a word (e.g. non- physical -> non-physical)
         # In many PDF extracts, 'non-\nphysical' -> 'non-physical'.
         # We keep the hyphen, removing the invisible newline is enough (done by not adding space).
         # But we need to ensure we don't add a space.

         # However, `text.split` lost the newline.
         # `current_paragraph` has the hyphen.
         # So we just append `line`.
         current_paragraph += line
      elsif [ '.', '!', '?', '"', "”" ].include?(last_char) && line.match?(/^[A-Z"“]/)
        # Likely a new paragraph
        new_text += current_paragraph + "\n\n"
        current_paragraph = line
      else
        # Continuation of same paragraph
        current_paragraph += " " + line
      end
    end
  end

  new_text += current_paragraph unless current_paragraph.empty?

  new_text.strip
end

files = Dir.glob('besm-attribute-viewer/besm_*.json')

files.each do |file_path|
  puts "Processing #{file_path}..."
  data = JSON.parse(File.read(file_path))

  data.each do |entry|
    if entry['description']
      entry['description'] = clean_description(entry['description'])
    end
  end

  File.write(file_path, JSON.pretty_generate(data))
end

puts "Done cleaning descriptions."

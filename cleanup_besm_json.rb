require 'json'

def clean_description(text)
  return text unless text.is_a?(String)

  # 1. First pass: Remove obvious PDF noise
  text.gsub!(/Greg Doachi\(e Odr2er \d+\)/, "")
  text.gsub!(/---PAGE \d+---/, "")
  text.gsub!(/PAGEPAGE\s+\d+/i, "")
  text.gsub!(/(ATTRIBUTES|DEFECTS|ENHANCEMENTS|LIMITERS)\s+\1/i, "\\1")
  
  # 2. Fix split words like "T unnelling" -> "Tunnelling"
  # Look for a single uppercase letter followed by space and then lowercase letters
  # But be careful not to catch "A character" or "I am"
  text.gsub!(/\b(?![AI]\b)([A-Z])\s+([a-z]{2,})\b/, "\\1\\2")

  # 3. Fix hyphens at end of lines
  text.gsub!(/(\w+)-\n\s*(\w+)/, "\\1-\\2")

  # 3b. Fix headers glued to end of sentences: "Weapon.HEADER"
  text.gsub!(/([a-z]\.)([A-Z\-\s]{4,})/, "\\1\n\\2")

  # 4. Join lines while detecting paragraphs
  text = text.gsub("\r\n", "\n")
  lines = text.split("\n").map(&:strip).reject(&:empty?)
  
  cleaned_text = ""
  lines.each_with_index do |line, i|
    if cleaned_text.empty?
      cleaned_text = line
    else
      previous_line = lines[i-1]
      
      # Header detection:
      # - ALL CAPS
      # - OR starts with "ANIMAL FORMS", "ELEMENTAL/CHEMICAL FORMS", etc.
      # - OR current line is very short and starts with uppercase
      is_all_caps = line == line.upcase && line.length > 3 && line !~ /[.!?]$/ && line !~ /^\d+$/
      is_short_caps = line =~ /^[A-Z][A-Z\s\-]+[A-Z]$/ && line.length < 50
      
      # Paragraph break heuristic:
      # - Current line is a header
      # - OR previous line ended in a period and current line starts with capital AND is reasonably long (new thought)
      #   Actually, PDF extraction is messy. Let's be conservative.
      
      should_break = is_all_caps || is_short_caps
      
      # If the previous line ended with a period and the text block is long, maybe it's a new paragraph.
      # In BESM books, new paragraphs often start on new lines.
      if !should_break && previous_line.match?(/[.!?]$/) && line.match?(/^[A-Z]/)
        # Check if it was a mid-sentence break or a real paragraph.
        # This is hard. Let's look for "If ", "The ", "A ", "When " etc. at start of line.
        if line.match?(/^(If|The|A|When|In|This|Each|To|Alternatively|Furthermore|Consequently)\b/)
           should_break = true
        end
      end
      
      if should_break
        header_text = (is_all_caps || is_short_caps) ? "**#{line}**" : line
        cleaned_text += "\n\n" + header_text
      else
        cleaned_text += " " + line
      end
    end
  end

  # 5. Clean up repeated phrases that occur when headers are caught multiple times
  # (e.g. "SAMPLE ALTERNATE FORMSAMPLE ALTERNATE FORM")
  2.times do
    cleaned_text.gsub!(/([A-Z\s]{8,})\1/, "\\1")
  end
  
  # Clean up repeated letters at start of bolded words (e.g. **SSAMPLE**)
  cleaned_text.gsub!(/\*\*([A-Z])([A-Z\s]{4,})\*\*/) do
    first = $1
    rest = $2
    if rest.start_with?(first)
       "**#{rest.strip}**"
    else
       "**#{first}#{rest}**"
    end
  end

  # Final cleanup
  cleaned_text.gsub!(/ +/, " ")
  cleaned_text.gsub!(/ \./, ".")
  
  cleaned_text.strip
end

files = [
  "besm-attribute-viewer/besm_attributes.json",
  "besm-attribute-viewer/besm_defects.json",
  "besm-attribute-viewer/besm_enhancements.json",
  "besm-attribute-viewer/besm_limiters.json",
  "besm-attribute-viewer/besm_weapon_enhancements.json",
  "besm-attribute-viewer/besm_weapon_limiters.json"
]

files.each do |file_path|
  full_path = File.expand_path(file_path, "/Users/joshuat/Projects/Rails Apps/besm")
  next unless File.exist?(full_path)
  
  puts "Processing #{file_path}..."
  data = JSON.parse(File.read(full_path))
  
  data.each do |item|
    item["description"] = clean_description(item["description"]) if item["description"]
    (item["level_effects"] || []).each do |effect|
      effect["text"] = clean_description(effect["text"]) if effect["text"]
    end
    (item["rank_effects"] || []).each do |effect|
      effect["text"] = clean_description(effect["text"]) if effect["text"]
    end
  end
  
  File.write(full_path, JSON.pretty_generate(data))
end

puts "Done!"

require 'json'

def clean_description(text)
  return text unless text.is_a?(String)

  # 1. First pass: Remove obvious PDF noise and strip existing bolding for idempotency
  text.gsub!(/\*\*+/, "") # Strip any bolding from previous runs
  
  # Watermarks and page numbers
  text.gsub!(/Greg Doachie Order \d+/, "")
  text.gsub!(/Greg Doachi\(e Odr2er \d+\)/, "")
  text.gsub!(/---PAGE \d+---/, "")
  text.gsub!(/PAGEPAGE\s+\d+/i, "")
  text.gsub!(/Page \d+/, "")
  
  # Noise patterns like "LLIMITERIMITER" or "AATTRIBUTETTRIBUTE"
  text.gsub!(/([A-Z])\1([A-Z]+)\2/, "\\1\\2")
  text.gsub!(/(ATTRIBUTES|DEFECTS|ENHANCEMENTS|LIMITERS|WEAPON ENHANCEMENTS|WEAPON LIMITERS)\s+\1/i, "\\1")
  
  # 2. Fix split words and hyphens
  text.gsub!(/\b(?![AI]\b)([A-Z])\s+([a-z]{2,})\b/, "\\1\\2")
  text.gsub!(/(\w+)-\s*\n\s*(\w+)/, "\\1-\\2")
  
  # 3. Handle headers glued to end of sentences
  # Use a more precise regex to split headers from the following sentence
  text.gsub!(/([a-z]\.|\))\s+([A-Z][A-Z\s\-]{3,}[A-Z])(?=\s+[a-z]|$)/, "\\1\n\\2\n")

  # 4. Join lines while detecting paragraphs
  text = text.gsub("\r\n", "\n")
  noise_headers = ["ATTRIBUTES", "DEFECTS", "ENHANCEMENTS", "LIMITERS", "WEAPON ENHANCEMENTS", "WEAPON LIMITERS"]
  
  lines = text.split("\n").map(&:strip).reject(&:empty?)
  
  cleaned_text = ""
  lines.each_with_index do |line, i|
    if cleaned_text.empty?
      cleaned_text = line
    else
      previous_line = lines[i-1]
      
      # Header detection:
      # - ALL CAPS
      # - OR specific known header patterns
      is_all_caps = line == line.upcase && line.length > 3 && line !~ /[.!?]$/ && line !~ /^\d+$/
      is_short_caps = line =~ /^[A-Z][A-Z\s\-]+[A-Z]$/ && line.length < 50 && line !~ /[.!?]$/
      
      is_noise = noise_headers.include?(line.upcase)
      should_break = (is_all_caps || is_short_caps) && !is_noise
      
      # Paragraph break heuristic:
      if !should_break && previous_line.match?(/[.!?]$/) && line.match?(/^[A-Z]/)
        if line.match?(/^(If|The|A|When|In|This|Each|To|Alternatively|Furthermore|Consequently|Additionally|Moreover|However|Specifically|Typically|For example)\b/)
           should_break = true
        end
      end
      
      if should_break
        prefix = (is_all_caps || is_short_caps) ? "\n\n**#{line}**\n\n" : "\n\n#{line}"
        cleaned_text += prefix
      elsif is_noise
        next
      else
        if cleaned_text.end_with?("\n")
          cleaned_text += line
        else
          cleaned_text += " " + line
        end
      end
    end
  end

  # 5. Clean up repeated phrases
  3.times do
    cleaned_text.gsub!(/([A-Z\s]{8,})\1/, "\\1")
  end
  
  # 6. Post-processing for space-based paragraph breaks
  starters = "If|The|A|When|In|This|Each|To|Alternatively|Furthermore|Consequently|Additionally|Moreover|However|Specifically|Typically|For example"
  cleaned_text.gsub!(/([.!?])\s+(#{starters})\b/, "\\1\n\n\\2")
  
  # Ensure block headers are properly handled if they were missed
  cleaned_text.gsub!(/\n\s*([A-Z][A-Z\s\-]{3,}[A-Z])\s*\n/) do |match|
    hdr = $1.strip
    if noise_headers.include?(hdr.upcase)
       " "
    else
       "\n\n**#{hdr}**\n\n"
    end
  end

  # Final cleanup
  cleaned_text.gsub!(/ +/, " ")
  cleaned_text.gsub!(/ \./, ".")
  cleaned_text.gsub!(/\s+\n/, "\n")
  cleaned_text.gsub!(/\n\s+/, "\n")
  cleaned_text.gsub!(/\n\n\n+/, "\n\n")
  
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

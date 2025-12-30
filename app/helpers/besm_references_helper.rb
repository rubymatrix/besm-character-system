module BesmReferencesHelper
  def render_besm_description(text)
    return "" if text.blank?

    blocks = text.split(/\n\n+/)

    html = blocks.map do |block|
      if block.strip.start_with?("##")
        content = block.strip.sub(/^##\s*/, "")
        content_tag(:h3, content, class: "text-lg font-bold mt-6 mb-2 text-gray-900 dark:text-gray-100")
      else
        safe_content = h(block).gsub("\n", "<br>")
        content_tag(:p, safe_content.html_safe, class: "mb-4 text-gray-700 dark:text-white")
      end
    end.join

    html.html_safe
  end
  def effects_table(effects, headers: [ "Assignments", "Effect" ], key_map: { val: "assignments", text: "text" })
    return unless effects.present? && effects.is_a?(Array)

    content_tag :div, class: "mt-6" do
      concat content_tag(:h4, "Effects", class: "text-sm font-medium text-gray-900 dark:text-gray-100 uppercase tracking-wider mb-3")
      concat(content_tag(:div, class: "overflow-x-auto") do
        content_tag(:table, class: "min-w-full divide-y divide-gray-300 dark:divide-zinc-700") do
          concat(content_tag(:thead, class: "bg-gray-50 dark:bg-zinc-800") do
            content_tag(:tr) do
              headers.each do |header|
                concat content_tag(:th, header, scope: "col", class: "py-2 first:pl-4 px-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider")
              end
            end
          end)
          concat(content_tag(:tbody, class: "divide-y divide-gray-200 dark:divide-zinc-700 bg-white dark:bg-zinc-900") do
            effects.each do |effect|
              concat(content_tag(:tr) do
                concat content_tag(:td, effect[key_map[:val]], class: "whitespace-nowrap py-2 pl-4 pr-3 text-sm font-medium text-gray-900 dark:text-white")
                concat content_tag(:td, effect[key_map[:text]], class: "px-3 py-2 text-sm text-gray-500 dark:text-white")
              end)
            end
          end)
        end
      end)
    end
  end
end

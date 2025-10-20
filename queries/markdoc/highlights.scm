; Headings
(atx_heading (atx_h1_marker) @markup.heading.marker)
(atx_heading (atx_h2_marker) @markup.heading.marker)
(atx_heading (atx_h3_marker) @markup.heading.marker)
(atx_heading (atx_h4_marker) @markup.heading.marker)
(atx_heading (atx_h5_marker) @markup.heading.marker)
(atx_heading (atx_h6_marker) @markup.heading.marker)
(atx_heading (heading_content) @markup.heading)

; Emphasis and Strong
(emphasis) @markup.italic
(strong_emphasis) @markup.bold

; Code
(code_span) @markup.raw.inline
(fenced_code_block (info_string) @attribute)
(fenced_code_block (code_fence_content) @markup.raw.block)

; Links and Images
(link (link_text) @markup.link.text)
(link (link_destination) @markup.link.url)
(image (link_text) @markup.link.text)
(image (link_destination) @markup.link.url)

; Lists
(list_marker_dot) @punctuation.special
(list_marker_minus) @punctuation.special
(list_marker_plus) @punctuation.special
(list_marker_star) @punctuation.special

; Blockquote
(block_quote_marker) @punctuation.special
(block_quote) @markup.quote

; Markdoc-specific (adjust based on actual grammar node names)
(tag_open) @keyword
(tag_close) @keyword
(tag_name) @tag
(attribute_name) @property
(attribute_value) @string
(variable) @variable

; HTML
(html_tag) @tag
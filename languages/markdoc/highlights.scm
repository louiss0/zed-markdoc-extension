; Basic text and identifiers
(text) @text
(identifier) @variable
(number) @number
(string) @string

; Headings (from grammar: heading, heading_marker, heading_text)
(heading_text) @title
(heading_marker) @punctuation.special

; Code blocks
(fenced_code_block) @text.literal
(code) @text.literal
(language) @attribute

; Markdoc tags
(tag_name) @tag
(attribute_name) @property

; Text formatting
(emphasis) @emphasis
(strong) @emphasis.strong
(inline_code) @string.special

; Links
(link_text) @link_text
(link_destination) @link_uri

; HTML
(html_comment) @comment

; Punctuation
"{%" @punctuation.delimiter
"%}" @punctuation.delimiter
"{{" @punctuation.delimiter
"}}" @punctuation.delimiter

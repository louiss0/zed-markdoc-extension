; Markdoc highlights for Zed.
; Keep queries aligned to grammars/markdoc/src/node-types.json and the capture
; set documented at zed.dev/docs/extensions/languages#syntax-highlighting.

; Headings
(heading_marker) @punctuation.special
(heading_text) @title

; Markdown blocks
(thematic_break) @punctuation.special
(comment_block) @comment
(html_comment) @comment
(frontmatter (yaml) @text.literal)

; Fenced code blocks
(code_fence_open) @punctuation.bracket
(code_fence_close) @punctuation.bracket
(language) @label
(info_string (attributes) @attribute)
(code) @text.literal
(inline_code) @text.literal

; Lists
(unordered_list_marker) @punctuation.list_marker
(ordered_list_marker) @punctuation.list_marker

; Inline formatting
(emphasis) @emphasis
(strong) @emphasis.strong

; Links and images
(link
  "[" @punctuation.bracket
  "]" @punctuation.bracket
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(link_text) @link_text
(link_destination) @link_uri

(image
  "![" @punctuation.bracket
  "]" @punctuation.bracket
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(image_alt) @link_text
(image_destination) @link_uri

; HTML token blocks
(html_block) @text.literal
(html_inline) @text.literal

; Markdoc tags and delimiters
(tag_open) @punctuation.bracket
(tag_close_start) @punctuation.bracket
(tag_close) @punctuation.bracket
(tag_self_close_delimiter) @punctuation.bracket
(inline_expression_close) @punctuation.bracket
(tag_name) @tag

; Markdoc control-flow tags
[
  (if_keyword)
  (else_keyword)
] @keyword

; Markdoc attributes and shorthand attributes
(attribute_name) @attribute
(attribute "=" @operator)
(id_shorthand (shorthand_id) @attribute)
(class_shorthand (shorthand_class) @attribute)

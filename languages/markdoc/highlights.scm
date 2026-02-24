; Markdoc highlights for Zed.
; Keep queries aligned to grammars/markdoc/src/node-types.json and the capture
; set documented at zed.dev/docs/extensions/languages#syntax-highlighting.

; Headings
(heading_marker) @punctuation.special
(heading_text) @title

; Markdown blocks
(thematic_break) @punctuation.special
(blockquote) @comment
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
(tag_open_delimiter) @punctuation.bracket
(tag_block_close) @punctuation.bracket
(tag_self_close_delimiter) @punctuation.bracket
(inline_expression_close) @punctuation.bracket
(tag_close "/" @punctuation.delimiter)
(tag_name) @tag

; Markdoc control-flow tags
[
  (tag_open (tag_name))
  (tag_close (tag_name))
  (tag_self_close (tag_name))
] @keyword
(#match? @keyword "^(if|else)$")

; Tag attributes
(attribute_name) @attribute
(attribute "=" @operator)
(attribute_value (variable_value) @embedded)
(attribute_value (call_expression) @embedded)

; Inline expression body
(inline_expression content: (_) @embedded)

; Variables and references
(variable "$" @punctuation.special)
(variable (identifier) @variable)

(special_variable "@" @punctuation.special)
(special_variable (identifier) @variable.special)

(variable_reference "." @punctuation.delimiter)
(variable_reference (identifier) @property)

(special_variable_reference "." @punctuation.delimiter)
(special_variable_reference (identifier) @property)

; Subscripts and calls
(array_subscript
  "[" @punctuation.bracket
  "]" @punctuation.bracket)

(call_expression function: (identifier) @function)
(call_expression
  "(" @punctuation.bracket
  ")" @punctuation.bracket)
(call_expression "," @punctuation.delimiter)

; Literals and structures
(string) @string
(number) @number
(boolean) @boolean
(null) @constant.builtin

(array_literal
  "[" @punctuation.bracket
  "]" @punctuation.bracket)
(array_literal "," @punctuation.delimiter)

(object_literal
  "{" @punctuation.bracket
  "}" @punctuation.bracket)
(object_literal "," @punctuation.delimiter)

(pair ":" @punctuation.delimiter)
(pair key: (identifier) @property)
(pair key: (string) @property)

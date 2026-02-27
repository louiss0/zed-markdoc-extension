; Markdoc highlights for Zed.
; Keep queries aligned to grammars/markdoc/src/node-types.json and the capture
; set documented at zed.dev/docs/extensions/languages#syntax-highlighting.

; Headings
(heading_marker) @punctuation.special
(heading_text) @title

; Markdown blocks
(thematic_break) @punctuation.special
(blockquote_marker) @punctuation.special
(blockquote_content (list_paragraph) @title)
(comment_block) @comment
(html_comment) @comment
(frontmatter (yaml) @text.literal)

; Fenced code blocks
(code_fence_open) @punctuation.delimiter
(code_fence_close) @punctuation.delimiter
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
(tag_name) @tag

; Ensure open/close/self-close tag names are all captured as tags
(tag_open_block (tag_name) @tag)
(tag_end (tag_name) @tag)
(inline_tag (tag_name) @tag)

; Markdoc control-flow tags
[
  (if_keyword)
  (else_keyword)
] @keyword

; Inline expression delimiters: {% ... %}
(inline_expression
  (inline_expression_open) @punctuation.special
  (inline_expression_close) @punctuation.special)

; Markdoc attributes and shorthand attributes
(attribute_name) @property
(attribute "=" @operator)
(id_shorthand (shorthand_id) @attribute)
(class_shorthand (shorthand_class) @attribute)

; Annotation delimiters: {% ... %}
(annotation_block
  (inline_expression_open) @punctuation.delimiter
  (inline_expression_close) @punctuation.delimiter)

; Annotation key/value highlighting (e.g. {% colspan=2 %})
(annotation_name) @property
(annotation_block "=" @operator)
(annotation_value (identifier) @variable)

; Variable and expression highlighting
(variable "$" @punctuation.special)
(variable (identifier) @variable)

(special_variable "@" @punctuation.special)
(special_variable (identifier) @variable.special)

(variable_reference "." @punctuation.delimiter)
(variable_reference (identifier) @property)

(special_variable_reference "." @punctuation.delimiter)
(special_variable_reference (identifier) @property)

(subscript_reference
  (array_subscript
    "[" @punctuation.bracket
    "]" @punctuation.bracket))

(call_expression function: (identifier) @function)
(inline_call_expression function: (function_identifier) @function)

(string) @string
(number) @number
(boolean) @boolean
(null) @constant.builtin

(pair key: (identifier) @property)
(pair key: (string) @property)
(pair ":" @punctuation.delimiter)

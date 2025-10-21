; Frontmatter
(frontmatter) @text.literal
(yaml) @text.literal

; Headings
(heading_text) @title
(heading_marker) @punctuation.special

; Code blocks
(fenced_code_block) @text.literal
(code_fence_open) @punctuation.delimiter
(code_fence_close) @punctuation.delimiter
(code) @text.literal
(info_string) @attribute
(language) @attribute
(attributes) @attribute

; Markdoc tags
(tag_open) @punctuation.delimiter
(tag_close) @punctuation.delimiter
(tag_self_close) @punctuation.delimiter
(tag_name) @tag

; Tag attributes
(attribute_name) @property
(attribute_value) @string

; Expressions and variables
(inline_expression) @embedded
(identifier) @variable
(number) @number
(string) @string
(call_expression) @function
(member_expression) @variable
(array_access) @variable
(array_literal) @punctuation.bracket
(object_literal) @punctuation.bracket
(arguments) @punctuation.bracket

; Text formatting
(emphasis) @emphasis
(strong) @emphasis.strong
(inline_code) @string.special

; Links and Images
(link_text) @link_text
(link_destination) @link_uri
(image_alt) @link_text
(image_destination) @link_uri

; Lists
(list_marker) @punctuation.list_marker

; HTML
(html_comment) @comment
(html_block) @embedded
(html_inline) @embedded

; Text
(text) @text

; Punctuation
"{{" @punctuation.delimiter
"}}" @punctuation.delimiter
"{%" @punctuation.delimiter
"%}" @punctuation.delimiter
"/%}" @punctuation.delimiter
"[" @punctuation.bracket
"]" @punctuation.bracket
"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"=" @operator
"." @operator
"," @punctuation.delimiter
":" @punctuation.delimiter

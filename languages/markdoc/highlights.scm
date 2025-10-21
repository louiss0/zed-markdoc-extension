; Basic text and identifiers
(text) @text
(identifier) @variable
(number) @number
(string) @string
(boolean) @boolean
(null) @constant

; Variables (with $ prefix)
(variable) @variable.special

; Inline expressions ({{ ... }})
(inline_expression) @embedded

; Headings
(heading_text) @title
(heading_marker) @punctuation.special

; Code blocks
(fenced_code_block) @text.literal
(code) @text.literal
(language) @attribute
(attributes) @attribute

; Lists
(list_item
  marker: (_ ) @punctuation.list_marker)
(list) @text

; Markdoc tags
(tag_name) @tag
(attribute_name) @property
(attribute_value) @string
(inline_tag) @tag

; Text formatting
(emphasis) @emphasis
(strong) @emphasis.strong
(inline_code) @string.special

; Links and images
(link) @text
(link_text) @link_text
(link_destination) @link_uri
(image) @text
(image_alt) @link_text
(image_destination) @link_uri

; HTML
(html_comment) @comment
(html_block) @embedded
(html_inline) @embedded

; Expressions
(call_expression) @function
(member_expression) @variable
(array_access) @variable
(array_literal) @punctuation.bracket
(object_literal) @punctuation.bracket

; Operators
(binary_add) @operator
(binary_subtract) @operator
(binary_multiply) @operator
(binary_divide) @operator
(binary_equal) @operator
(binary_not_equal) @operator
(binary_and) @operator
(binary_or) @operator
(unary_not) @operator
(unary_minus) @operator
(unary_plus) @operator

; Punctuation
"{%" @punctuation.delimiter
"%}" @punctuation.delimiter
"{{" @punctuation.delimiter
"}}" @punctuation.delimiter
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

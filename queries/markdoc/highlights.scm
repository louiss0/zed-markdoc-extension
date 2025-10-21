; Frontmatter
(frontmatter) @markup.raw.block
(yaml) @markup.raw.block

; Headings
(heading) @markup.heading
(heading_marker) @markup.heading.marker
(heading_text) @markup.heading

; Code blocks
(fenced_code_block) @markup.raw.block
(code_fence_open) @punctuation.delimiter
(code_fence_close) @punctuation.delimiter
(code) @markup.raw.block
(info_string) @attribute
(language) @attribute
(attributes) @attribute

; Markdoc tags
(markdoc_tag) @markup.raw.block
(tag_open) @punctuation.delimiter
(tag_close) @punctuation.delimiter
(tag_self_close) @punctuation.delimiter
(tag_name) @function.call

; Tag attributes
(attribute) @variable
(attribute_name) @property
(attribute_value) @string

; Expressions and variables
(inline_expression) @markup.raw.inline
(expression) @variable
(call_expression) @function.call
(member_expression) @variable.member
(array_access) @variable.member
(array_literal) @punctuation.bracket
(object_literal) @punctuation.bracket
(identifier) @variable
(number) @constant.numeric
(string) @string
(arguments) @punctuation.bracket

; Text formatting
(emphasis) @markup.italic
(strong) @markup.bold
(inline_code) @markup.raw.inline

; Links and Images
(link) @markup.link
(link_text) @markup.link.text
(link_destination) @markup.link.url
(image) @markup.link
(image_alt) @markup.link.text
(image_destination) @markup.link.url

; Lists
(list) @markup.list
(list_item) @markup.list.item
(list_marker) @punctuation.special

; HTML
(html_comment) @comment
(html_block) @markup.raw.block
(html_inline) @markup.raw.inline

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

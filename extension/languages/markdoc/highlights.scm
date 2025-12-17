; ============================================================================
; Tree-sitter Syntax Highlighting Queries for Markdoc
; ============================================================================
; This file defines syntax highlighting patterns for the Markdoc language,
; which extends Markdown with custom tags and expressions.
;
; Capture naming follows Tree-sitter conventions for cross-editor compatibility:
; - Neovim (nvim-treesitter)
; - Helix
; - Zed
; ============================================================================

; ============================================================================
; FRONTMATTER
; ============================================================================

(frontmatter) @markup.raw.block

; ============================================================================
; HEADINGS
; ============================================================================

; Heading markers (#, ##, ###, etc.)
(heading_marker) @markup.heading.marker

; Heading text content
(heading_text) @markup.heading

; ============================================================================
; THEMATIC BREAKS (HORIZONTAL RULES)
; ============================================================================

(thematic_break) @punctuation.special

; ============================================================================
; BLOCKQUOTES
; ============================================================================

(blockquote ">" @markup.quote)

; ============================================================================
; CODE BLOCKS (FENCED)
; ============================================================================

; Code fence delimiters (``` or ~~~)
(code_fence_open) @punctuation.bracket
(code_fence_close) @punctuation.bracket

; Language identifier (e.g., javascript, python, go)
(language) @label

; Attributes in info string (e.g., {1-5})
(info_string (attributes) @attribute)

; Code content
(code) @markup.raw.block

; ============================================================================
; LISTS
; ============================================================================

; List markers (-, *, +, 1., 2., etc.)
(list_marker) @markup.list

; Bullet markers in regular lists
(list (list_item (list_marker) @markup.list.bullet)
  (#match? @markup.list.bullet "^[*+-][ \t]+$"))

; Numbered list markers in regular lists
(list (list_item (list_marker) @markup.list.numbered)
  (#match? @markup.list.numbered "^[0-9]+\.[ \t]+$"))

; List item annotations: {% type %}
(list_item_annotation
  "{%" @punctuation.bracket
  "%}" @punctuation.bracket)
(list_item_annotation type: (annotation_type) @attribute)
(list_item_annotation (attribute) @attribute)


; ============================================================================
; INLINE FORMATTING
; ============================================================================

; Emphasis (italic) - *text* or _text_
(emphasis) @markup.italic

; Strong (bold) - **text** or __text__
(strong) @markup.bold

; Inline code - `code`
(inline_code) @markup.raw.inline

; ============================================================================
; LINKS AND IMAGES
; ============================================================================

; Link structure: [text](url)
(link
  "[" @punctuation.bracket
  "]" @punctuation.bracket
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(link_text) @markup.link.label
(link_destination) @markup.link.url

; Image structure: ![alt](url)
(image
  "![" @punctuation.bracket
  "]" @punctuation.bracket
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(image_alt) @markup.link.label
(image_destination) @markup.link.url

; ============================================================================
; HTML
; ============================================================================

; HTML blocks (block-level tags)
(html_block) @markup.raw.block

; HTML inline (inline tags)
(html_inline) @markup.raw.inline

; HTML comments <!-- comment -->
(html_comment) @comment

; ============================================================================
; MARKDOWN TABLES
; ============================================================================

; Table pipes
(markdown_table_header "|" @punctuation.bracket)
(markdown_table_separator "|" @punctuation.bracket)
(markdown_table_row "|" @punctuation.bracket)

; Separator cells (---)
(markdown_table_sep_cell) @punctuation.special

; Header cell content emphasized
(markdown_table_header (markdown_table_cell) @markup.bold)

; Body row cell content
(markdown_table_row (markdown_table_cell) @none)

; ============================================================================
; MARKDOC TABLES
; ============================================================================

; Markdoc table open/close tags
(markdoc_table_open
  "{%" @punctuation.bracket
  "%}" @punctuation.bracket)
(markdoc_table_close
  "{%" @punctuation.bracket
  "%}" @punctuation.bracket)

; Markdoc table separators (---)
(markdoc_table_separator) @punctuation.special

; Markdoc table cell list markers
(markdoc_table_cell marker: (list_marker) @markup.list)

; Markdoc table header cells - emphasize like markdown table headers
(markdoc_table_header (markdoc_table_cell) @markup.bold)

; Markdoc table cell annotations: {% colspan=2 %}
(markdoc_table_cell_annotation
  "{%" @punctuation.bracket
  "%}" @punctuation.bracket)
(markdoc_table_cell_annotation (annotation_name) @attribute)
(markdoc_table_cell_annotation (annotation_value) @number)
(markdoc_table_cell_annotation "=" @operator)

; ============================================================================
; MARKDOC TAGS
; ============================================================================

; Tag delimiters: {% and %} and /%}
("{%" @punctuation.bracket)
("%}" @punctuation.bracket)
("/%}" @punctuation.bracket)

; Tag names (e.g., callout, table, partial)
(tag_name) @tag

; Table tag specifically (built-in)
(markdoc_table_open (tag_name) @tag.builtin)
(markdoc_table_close (tag_name) @tag.builtin)

; Common built-in tag names
(tag_open (tag_name) @tag.builtin
  (#match? @tag.builtin "^(callout|code|link|note|if|else|include)$"))
(tag_close (tag_name) @tag.builtin
  (#match? @tag.builtin "^(callout|code|link|note|if|else|include)$"))
(tag_self_close (tag_name) @tag.builtin
  (#match? @tag.builtin "^(callout|code|link|note|if|else|include)$"))
(inline_tag (tag_name) @tag.builtin
  (#match? @tag.builtin "^(callout|code|link|note|if|else|include)$"))

; Closing tag slash
("/" @punctuation.delimiter)

; Comment blocks: {% comment %}...{% /comment %}
(comment_block) @comment

; ============================================================================
; IF/ELSE CONDITIONAL TAGS
; ============================================================================

; If tag keywords
(if_tag_open "if" @keyword.control.conditional)
(if_tag_close "if" @keyword.control.conditional)
(else_tag "else" @keyword.control.conditional)

; If tag condition
(if_tag_open condition: (expression) @embedded)
(else_tag condition: (expression) @embedded)



; ============================================================================
; TAG ATTRIBUTES
; ============================================================================

; Attribute name (e.g., type, id, class)
(attribute_name) @attribute

; Shorthand id and class
(id_shorthand (shorthand_id) @attribute)
(class_shorthand (shorthand_class) @attribute)

; Assignment operator
(attribute ("=" @operator))

; Attribute values
(attribute_value (string) @string)
; Expressions are injected; still give them a subtle scope
(attribute_value (expression) @embedded)

; ============================================================================
; INLINE EXPRESSIONS {{ ... }}
; ============================================================================

; Expression delimiters
(inline_expression
  "{{" @punctuation.bracket
  "}}" @punctuation.bracket)

; ============================================================================
; EXPRESSIONS AND OPERATORS
; ============================================================================

; Variables with $ prefix
(variable "$" @punctuation.special)
(variable (identifier) @variable)

; Identifiers (function names, object keys, etc.)
(identifier) @variable

; Member expressions: object.property
(member_expression
  "." @punctuation.delimiter
  property: (identifier) @property)

; Array access: array[index]
(array_access
  "[" @punctuation.bracket
  "]" @punctuation.bracket)

; Function calls: func() or obj.method()
; Highlight identifier as function in direct calls
(call_expression
  (identifier) @function)

; Highlight property as function in member expression calls
(call_expression
  (member_expression
    property: (identifier) @function))

; Arrow functions: () => expr
(arrow_function
  "(" @punctuation.bracket
  ")" @punctuation.bracket
  "=>" @keyword.operator)

; Arrow function parameters
(arrow_function (identifier) @variable.parameter)

; ============================================================================
; OPERATORS
; ============================================================================

; Binary arithmetic operators
(binary_add) @operator
(binary_subtract) @operator
(binary_multiply) @operator
(binary_divide) @operator
(binary_modulo) @operator

; Binary comparison operators
(binary_equal) @operator
(binary_not_equal) @operator
(binary_less_than) @operator
(binary_greater_than) @operator
(binary_less_equal) @operator
(binary_greater_equal) @operator

; Binary logical operators
(binary_and) @operator
(binary_or) @operator

; Unary operators
(unary_not) @operator
(unary_minus) @operator
(unary_plus) @operator

; ============================================================================
; LITERALS
; ============================================================================

; Strings: "string" or 'string'
(string) @string

; Numbers: 42, 3.14, -10
(number) @number

; Booleans: true, false
(boolean) @boolean

; Null
(null) @constant.builtin

; ============================================================================
; DATA STRUCTURES
; ============================================================================

; Array literals: [1, 2, 3]
(array_literal
  "[" @punctuation.bracket
  "]" @punctuation.bracket)

; Object literals: { key: value }
(object_literal
  "{" @punctuation.bracket
  "}" @punctuation.bracket)

; Object pairs - key: value
; First child is the key (identifier)
(pair
  (identifier) @property
  ":" @punctuation.delimiter)

; Commas in arrays and objects
(array_literal "," @punctuation.delimiter)
(object_literal "," @punctuation.delimiter)
(call_expression "," @punctuation.delimiter)

; ============================================================================
; TEXT CONTENT
; ============================================================================

; Plain text in paragraphs and lists
(text) @none
(list_paragraph (text) @none)

; ============================================================================
; PARENTHESES AND BRACKETS (GENERIC)
; ============================================================================

; Function call parentheses
(call_expression
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

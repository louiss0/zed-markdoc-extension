; Inject languages into fenced code blocks
((fenced_code_block
  (code_fence_open (info_string (language) @injection.language))
  (code) @injection.content)
 (#set! injection.include-children))

; Inject YAML for frontmatter blocks
((frontmatter) @injection.content
 (#set! injection.language "yaml"))

; Inject HTML for HTML blocks and inline HTML
((html_block) @injection.content
 (#set! injection.language "html")
 (#set! injection.include-children))

((html_inline) @injection.content
 (#set! injection.language "html"))

; Inject JavaScript-like expressions inside {{ ... }}
((inline_expression
   content: (expression) @injection.content)
 (#set! injection.language "javascript"))

; Inject expressions used as attribute values in tags
((attribute_value (expression) @injection.content)
 (#set! injection.language "javascript"))

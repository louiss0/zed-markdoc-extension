; Fenced code block language injections.
((fenced_code_block
  (code_fence_open (info_string (language) @injection.language))
  (code) @injection.content)
 (#set! injection.include-children))

; Frontmatter body as YAML.
((frontmatter
  (yaml) @injection.content)
 (#set! injection.language "yaml"))

; HTML snippets.
((html_block) @injection.content
 (#set! injection.language "html"))

((html_inline) @injection.content
 (#set! injection.language "html"))

; Markdoc expression language (JS-like syntax).
((inline_expression
  content: (_) @injection.content)
 (#set! injection.language "javascript"))

((attribute_value
  (variable_value) @injection.content)
 (#set! injection.language "javascript"))

((attribute_value
  (call_expression) @injection.content)
 (#set! injection.language "javascript"))

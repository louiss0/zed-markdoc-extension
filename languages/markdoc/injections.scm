; Inject languages into fenced code blocks
((fenced_code_block
  (code_fence_open (info_string (language) @injection.language))
  (code) @injection.content)
 (#set! injection.include-children))

; Inject YAML into frontmatter
((frontmatter
  (yaml) @injection.content)
 (#set! injection.language "yaml")
 (#set! injection.include-children))

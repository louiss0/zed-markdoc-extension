; Inject languages into fenced code blocks
((fenced_code_block
  (info_string) @injection.language
  (code_fence_content) @injection.content)
 (#set! injection.include-children))
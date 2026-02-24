; Indent Markdoc blocks that have explicit closers.
(fenced_code_block
  (code_fence_close) @end) @indent

(markdoc_tag
  (tag_close) @end) @indent

; Indent list item content.
(unordered_list_item) @indent
(ordered_list_item) @indent

; Expression literals in attributes/tags.
(array_literal "]" @end) @indent
(object_literal "}" @end) @indent
(call_expression ")" @end) @indent

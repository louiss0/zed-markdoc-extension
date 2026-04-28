; Outline headings in Markdoc documents.
(heading
  heading_text: (heading_text) @name) @item

; Outline blockquote content.
(blockquote_content
  (list_paragraph) @name) @item

; Outline opening non-self-closing tags.
(tag_open_block
  (tag_name) @name) @item

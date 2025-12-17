; Parameters in arrow functions are local definitions
(arrow_function (identifier) @definition.parameter)

; Variable references
(variable (identifier) @reference)

; Property references in member access
(member_expression property: (identifier) @reference)

; Object being accessed is a reference too
(member_expression object: (identifier) @reference)

; Called identifiers as references (best-effort)
(call_expression (identifier) @reference)

; Object literal field definitions
(pair (identifier) @definition.field)

; Tag attribute names as field definitions
(attribute (attribute_name) @definition.field)

; Variable references
(variable (identifier) @reference)
(special_variable (identifier) @reference)

(variable_reference (identifier) @reference)
(special_variable_reference (identifier) @reference)

; Called identifiers
(call_expression function: (identifier) @reference.call)

; Field-like names
(pair key: (identifier) @definition.field)
(attribute (attribute_name) @definition.field)

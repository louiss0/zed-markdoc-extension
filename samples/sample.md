<!-- This .md file is NOT associated by default -->
 <!--Users must opt-in via Zed settings to use Markdoc for .md files -->

# Markdoc in .md file

This demonstrates Markdoc syntax in a .md file.

{% note %}
This tag won't highlight unless user configures Zed to treat .md as Markdoc.
{% /note %}

## Standard Markdown

This file shows that standard **.md** files are not hijacked by the Markdoc extension.

- Regular markdown works normally
- Only opt-in files get Markdoc highlighting

```python
# This code block works in regular markdown
def hello():
    print("Hello World")
```

### Markdoc Variables (won't highlight by default)

User: {{ $user.name }}

{% callout type="warning" %}
To enable Markdoc highlighting for .md files, add file type configuration to Zed settings.
{% /callout %}

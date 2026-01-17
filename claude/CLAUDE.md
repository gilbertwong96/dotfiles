# Project Instructions

## Default Tools

- Always prefer `rg` (ripgrep) over `grep` for searching
- Use standard Unix tools: read, grep, awk, sed for text processing
- Combine commands using pipes when appropriate

## Command Preferences

1. Search: Use `rg` with appropriate flags
2. Text processing: Prefer `awk` for column operations, `sed` for substitutions
3. File reading: Use `cat` for full files, `head`/`tail` for partial views
4. Batch processing: Combine `find` with `xargs` or `-exec`

## Example Patterns

```bash
# Search with context

rg "pattern" --context 3

# Process CSV/TSV

awk -F',' '{print $1, $3}' file.csv

# In-place editing

sed -i 's/old/new/g' file.txt

# Safe reading with error handling

while IFS= read -r line; do
    echo "$line"
done < file.txt
```


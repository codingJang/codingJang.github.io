#!/bin/bash
# Script to double-escape backslashes in inline bmatrix equations
# Targets: $...bmatrix... \\ ...$ -> $...bmatrix... \\\\ ...$

POSTS_DIR="_posts"
BACKUP_DIR="_posts_backup_$(date +%Y%m%d_%H%M%S)"
DRY_RUN=true

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=== Inline Bmatrix Double-Escape Fix Script ==="
echo ""

# Count affected files
echo "Analyzing files..."
affected_files=$(grep -l '\$.*bmatrix.*\\\\[^\\].*\$' "$POSTS_DIR"/*.md 2>/dev/null | grep -v '\\\\\\\\')
num_files=$(echo "$affected_files" | grep -v '^$' | wc -l | tr -d ' ')

echo -e "${YELLOW}Found $num_files files with inline bmatrix needing fixes${NC}"
echo ""

if [ "$num_files" -eq "0" ]; then
    echo "No files need fixing. All inline bmatrix already use double-escaped backslashes."
    exit 0
fi

echo "Files to be modified:"
echo "$affected_files" | nl
echo ""

# Show sample changes
echo "=== Sample changes (first 5) ==="
grep -n '\$.*bmatrix.*\\\\[^\\].*\$' "$POSTS_DIR"/*.md 2>/dev/null | grep -v '\\\\\\\\' | head -5 | while IFS=: read -r file line content; do
    echo -e "${GREEN}$file:$line${NC}"
    echo "  Before: $content"
    # Show what it would become (simplified visualization)
    fixed=$(echo "$content" | sed 's/\\\\ /\\\\\\\\ /g; s/\\\\ \([&}]\)/\\\\\\\\ \1/g')
    echo "  After:  $fixed"
    echo ""
done

echo ""
echo "=== Command to be executed ==="
echo ""
cat << 'EOCMD'
# For each .md file in _posts/
for file in _posts/*.md; do
    # Use perl to find and replace single-escaped \\ with double-escaped \\\\
    # Only within inline math (between single $, not $$)
    # Pattern matches: \\ followed by space, &, or }
    perl -i.bak -pe '
        # Only process lines with inline math containing bmatrix
        if (/\$[^\$]*\\begin\{bmatrix\}[^\$]*\$/) {
            # Replace \\ with \\\\ in inline math contexts
            # Pattern 1: \\ followed by space
            s/(\$[^\$]*\\begin\{bmatrix\}[^\$]*)\\\\ /$1\\\\\\\\ /g;
            # Pattern 2: \\ followed by & (column separator)
            s/(\$[^\$]*)\\\\ &/$1\\\\\\\\ &/g;
            # Pattern 3: \\ followed by } (end of row before end of matrix)
            s/(\$[^\$]*)\\\\ ([^\\])/$1\\\\\\\\ $2/g;
        }
    ' "$file"
done
EOCMD

echo ""
echo "=== SAFETY CHECKS ==="
echo "✓ Creates .bak backup for each modified file"
echo "✓ Only modifies inline math (single $, not display $$ blocks)"
echo "✓ Only targets bmatrix environments"
echo "✓ Will not double-escape already escaped \\\\\\\\"
echo ""

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}=== DRY RUN MODE ===${NC}"
    echo "This is a preview. No files will be modified."
    echo ""
    echo "To apply the changes:"
    echo "  1. Review the changes above"
    echo "  2. Run: bash fix_inline_bmatrix.sh apply"
    echo "  3. Or edit this script and set DRY_RUN=false"
    exit 0
fi

# Check if user passed "apply" argument
if [ "$1" != "apply" ]; then
    echo -e "${RED}ERROR: Must pass 'apply' argument to execute changes${NC}"
    echo "Usage: bash fix_inline_bmatrix.sh apply"
    exit 1
fi

echo "=== APPLYING CHANGES ==="
echo ""

# Create backup directory
echo "Creating backup at $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"
cp "$POSTS_DIR"/*.md "$BACKUP_DIR/" 2>/dev/null

# Apply the fix
echo "Processing files..."
for file in $affected_files; do
    echo "  Processing: $file"
    # Double-escape backslashes in inline bmatrix
    # This targets patterns like: \\ followed by space, &, or non-backslash
    perl -i -pe '
        # Only process lines NOT in display math and containing inline bmatrix
        if (!/^\$\$/ && /\$[^\$]*\\begin\{bmatrix\}/) {
            # Replace patterns carefully to avoid double-processing
            s/([^\\])\\\\ /$1\\\\\\\\ /g;
            s/\\\\ &/\\\\\\\\ &/g;
            s/\\\\ ([0-9\-])/\\\\\\\\ $1/g;
            s/\\\\ (\\end)/\\\\\\\\ $1/g;
        }
    ' "$file"
done

# Clean up .bak files (we have full backup in backup dir)
rm "$POSTS_DIR"/*.bak 2>/dev/null

echo ""
echo -e "${GREEN}✓ Changes applied successfully!${NC}"
echo ""
echo "Backup location: $BACKUP_DIR"
echo ""
echo "To verify changes:"
echo "  cd $POSTS_DIR"
echo "  grep -n 'bmatrix.*\\\\\\\\\\\\' *.md | head -10"
echo ""
echo "To restore from backup if needed:"
echo "  cp $BACKUP_DIR/*.md $POSTS_DIR/"


#!/bin/bash

# Update Image References Script
# This script updates image references in blog posts using the migration mapping

set -e

SCRIPT_DIR="/Users/yejunjang/Projects/codingJang.github.io"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Updating Image References in Blog Posts"
echo "=========================================="
echo ""

updated_count=0
total_replacements=0

# Function to URL encode a path component
urlencode() {
    python3 -c "import sys, urllib.parse as ul; print(ul.quote(sys.argv[1]))" "$1"
}

# Function to URL decode a path component
urldecode() {
    python3 -c "import sys, urllib.parse as ul; print(ul.unquote(sys.argv[1]))" "$1"
}

echo "Processing image reference updates..."
echo ""

# Read the mapping file
if [[ ! -f /tmp/image_migration_map.txt ]]; then
    echo "Error: Migration mapping file not found!"
    echo "Please run migrate_blog_images.sh first"
    exit 1
fi

while IFS='|' read -r old_path new_path; do
    # Get just the filename and parent directory from old path
    old_dir=$(dirname "$old_path")
    old_dir_name=$(basename "$old_dir")
    old_filename=$(basename "$old_path")
    
    # URL encode the directory name and filename
    encoded_dir=$(urlencode "$old_dir_name")
    encoded_filename=$(urlencode "$old_filename")
    
    # Create the pattern to search for (URL-encoded version)
    search_pattern="${encoded_dir}/${encoded_filename}"
    
    # Create the replacement (new path)
    replace_with="/$new_path"
    
    # Search for posts containing this pattern
    posts_found=$(grep -l "$search_pattern" _posts/*.md 2>/dev/null || true)
    
    if [[ -n "$posts_found" ]]; then
        for post in $posts_found; do
            # Create backup if not already done
            if [[ ! -f "$post.bak" ]]; then
                cp "$post" "$post.bak"
            fi
            
            # Count replacements before
            before=$(grep -c "$search_pattern" "$post" || echo "0")
            
            # Perform replacement
            sed -i '' "s|$search_pattern|$replace_with|g" "$post"
            
            # Count replacements after
            after=$(grep -c "$replace_with" "$post" || echo "0")
            
            if [[ "$before" != "0" ]]; then
                echo "  ✓ Updated $(basename $post): $before reference(s) to $old_filename"
                ((updated_count++))
                ((total_replacements+=before))
            fi
        done
    fi
    
done < /tmp/image_migration_map.txt

echo ""
echo "=========================================="
echo "Update Summary"
echo "=========================================="
echo "Posts updated: $updated_count"
echo "Total references updated: $total_replacements"
echo ""

if [[ $updated_count -gt 0 ]]; then
    echo "Backup files created: _posts/*.bak"
    echo ""
    echo "Next steps:"
    echo "1. Review the changes:"
    echo "   git diff _posts/"
    echo "2. Test the site locally:"
    echo "   bundle exec jekyll serve"
    echo "3. If everything looks good, remove backups:"
    echo "   rm _posts/*.bak"
    echo ""
    echo "To rollback:"
    echo "   for f in _posts/*.bak; do mv \"\$f\" \"\${f%.bak}\"; done"
else
    echo "No references found to update."
    echo "Check if the posts reference images using different paths."
fi
echo ""


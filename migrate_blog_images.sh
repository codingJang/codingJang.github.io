#!/bin/bash

# Blog Image Migration Script
# This script migrates images from assets/blog/ to assets/img/blog/
# and updates all references in blog posts

set -e  # Exit on error

SCRIPT_DIR="/Users/yejunjang/Projects/codingJang.github.io"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Blog Image Migration Script"
echo "=========================================="
echo ""

# Create target directories
echo "Creating target directories..."
mkdir -p assets/img/blog/deep-learning
mkdir -p assets/img/blog/reinforcement-learning
mkdir -p assets/img/blog/tutoring
mkdir -p assets/img/blog/qubit
mkdir -p assets/img/blog/other

# Counter for tracking
total_images=0
migrated_images=0

# Function to sanitize filename (remove special chars, spaces, etc.)
sanitize_filename() {
    echo "$1" | sed 's/[^a-zA-Z0-9._-]/_/g' | sed 's/__*/_/g' | tr '[:upper:]' '[:lower:]'
}

# Function to get target directory based on source path
get_target_dir() {
    local source_path="$1"
    
    if [[ "$source_path" == *"deep-learning-basics"* ]]; then
        echo "assets/img/blog/deep-learning"
    elif [[ "$source_path" == *"reinforcement-learning-basics"* ]]; then
        echo "assets/img/blog/reinforcement-learning"
    elif [[ "$source_path" == *"tutoring-materials"* ]]; then
        echo "assets/img/blog/tutoring"
    elif [[ "$source_path" == *"qubit"* ]]; then
        echo "assets/img/blog/qubit"
    else
        echo "assets/img/blog/other"
    fi
}

echo ""
echo "Phase 1: Discovering and copying images..."
echo "=========================================="

# Find and copy all images
while IFS= read -r img_path; do
    ((total_images++))
    
    # Get the filename
    filename=$(basename "$img_path")
    
    # Get parent directory name for context
    parent_dir=$(basename "$(dirname "$img_path")")
    
    # Sanitize the filename
    sanitized_name=$(sanitize_filename "$filename")
    
    # Get target directory
    target_dir=$(get_target_dir "$img_path")
    
    # Create a unique filename with context if needed
    target_path="$target_dir/$sanitized_name"
    
    # If file exists, append parent directory context
    if [[ -f "$target_path" ]]; then
        name="${sanitized_name%.*}"
        ext="${sanitized_name##*.}"
        sanitized_parent=$(sanitize_filename "$parent_dir" | cut -c1-30)
        target_path="$target_dir/${name}_${sanitized_parent}.${ext}"
    fi
    
    # Copy the file
    if cp "$img_path" "$target_path"; then
        ((migrated_images++))
        echo "✓ Copied: $filename -> $target_path"
        
        # Store mapping for later reference updates
        echo "$img_path|$target_path" >> /tmp/image_migration_map.txt
    else
        echo "✗ Failed to copy: $img_path"
    fi
    
done < <(find assets/blog -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.svg" -o -iname "*.webp" \))

echo ""
echo "Phase 1 Complete: $migrated_images of $total_images images copied"
echo ""

echo "Phase 2: Updating references in blog posts..."
echo "=========================================="

updated_posts=0

# Read the mapping file and update references in posts
if [[ -f /tmp/image_migration_map.txt ]]; then
    while IFS='|' read -r old_path new_path; do
        # Extract just the relative path from assets/blog/...
        old_rel_path="${old_path#assets/blog/}"
        
        # Get the new path relative to site root
        new_rel_path="/$new_path"
        
        # Find all markdown files that might reference this image
        # Look for various reference patterns
        posts_with_ref=$(grep -l -r "$old_rel_path" _posts/ 2>/dev/null || true)
        
        if [[ -n "$posts_with_ref" ]]; then
            for post in $posts_with_ref; do
                # Create backup
                cp "$post" "$post.bak"
                
                # Update the reference (handle various markdown image formats)
                sed -i '' "s|$old_rel_path|$new_rel_path|g" "$post"
                
                echo "  ✓ Updated references in: $post"
                ((updated_posts++))
            done
        fi
        
    done < /tmp/image_migration_map.txt
fi

echo ""
echo "Phase 2 Complete: Updated references in $updated_posts post files"
echo ""

echo "=========================================="
echo "Migration Summary"
echo "=========================================="
echo "Total images found: $total_images"
echo "Images migrated: $migrated_images"
echo "Blog posts updated: $updated_posts"
echo ""
echo "Backup files created: _posts/*.bak (remove after verification)"
echo "Mapping file: /tmp/image_migration_map.txt"
echo ""
echo "Next steps:"
echo "1. Review the changes in _posts/"
echo "2. Test the site locally: bundle exec jekyll serve"
echo "3. If everything looks good, remove backup files:"
echo "   rm _posts/*.bak"
echo "4. Commit the changes"
echo ""
echo "To rollback, restore from backup files:"
echo "   for f in _posts/*.bak; do mv \"\$f\" \"\${f%.bak}\"; done"
echo ""


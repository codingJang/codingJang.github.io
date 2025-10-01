#!/bin/bash

# Fix remaining image references that were missed

set -e

cd "/Users/yejunjang/Projects/codingJang.github.io"

echo "=========================================="
echo "Fixing Remaining Image References"
echo "=========================================="
echo ""

# Fix gradient descent post
echo "Fixing gradient descent post..."

if grep -q "Day%208" _posts/2024-01-28-gradient-descent.md; then
    cp _posts/2024-01-28-gradient-descent.md _posts/2024-01-28-gradient-descent.md.bak2
    
    # Replace the relative path references with new paths
    sed -i '' 's|../Day%208%20%EC%9D%BC%EB%B3%80%EC%88%98%20%EC%B5%9C%EC%A0%81%ED%99%94%20%EB%AC%B8%EC%A0%9C%EC%99%80%20%EA%B2%BD%EC%82%AC%ED%95%98%EA%B0%95%EB%B2%95%20161f0f24f9318032a355d6c77b9562e5/Untitled.jpeg|/assets/img/blog/deep-learning/untitled.jpeg|g' _posts/2024-01-28-gradient-descent.md
    
    sed -i '' 's|../Day%209%20%EA%B5%AD%EC%86%8C%20%EC%B5%9C%EC%86%8C%EC%A0%90%EA%B3%BC%20%EC%A0%84%EC%97%AD%20%EC%B5%9C%EC%86%8C%EC%A0%90%20161f0f24f931802a97f3e1b6d06aea24/Untitled.png|/assets/img/blog/deep-learning/untitled_day_9_161f0f24f931802a97f3e1b6.png|g' _posts/2024-01-28-gradient-descent.md
    
    echo "  ✓ Fixed gradient-descent.md"
else
    echo "  ✓ gradient-descent.md already fixed"
fi

# Check English intro post for any remaining issues
echo ""
echo "Checking English intro post..."

if grep -q "Introduction%20to%20Deep%20Learning" _posts/2024-01-01-deep-learning-intro-en.md; then
    cp _posts/2024-01-01-deep-learning-intro-en.md _posts/2024-01-01-deep-learning-intro-en.md.bak2
    
    # Fix any remaining encoded paths
    sed -i '' 's|Introduction%20to%20Deep%20Learning%20957e35bcecd448278c201480cee70fab/Untitled.png|/assets/img/blog/deep-learning/untitled_introduction_to_deep_learning_.png|g' _posts/2024-01-01-deep-learning-intro-en.md
    
    sed -i '' 's|Introduction%20to%20Deep%20Learning%20957e35bcecd448278c201480cee70fab/Untitled%201.png|/assets/img/blog/deep-learning/untitled_1_introduction_to_deep_learning_.png|g' _posts/2024-01-01-deep-learning-intro-en.md
    
    echo "  ✓ Fixed deep-learning-intro-en.md"
else
    echo "  ✓ deep-learning-intro-en.md already fixed"
fi

echo ""
echo "Searching for any remaining broken image references..."
echo ""

# Find any remaining old-style references
broken_refs=$(grep -r "Day%20\|Introduction%20to%20Deep%20Learning%20\|Tutoring%20\|Optical%20Quantum%20Gates%20\|DeepMind%20X%20UCL" _posts/*.md 2>/dev/null | grep "!\[" || true)

if [[ -n "$broken_refs" ]]; then
    echo "⚠️  Found potentially broken references:"
    echo "$broken_refs"
else
    echo "✓ No obvious broken references found!"
fi

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo "Fixed posts backed up with .bak2 extension"
echo ""
echo "Next: Fix baseurl in _config.yml"
echo "  Change: baseurl: ."
echo "  To:     baseurl: ''"
echo ""


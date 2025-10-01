#!/bin/bash

set -e
cd "/Users/yejunjang/Projects/codingJang.github.io"

echo "Fixing all remaining broken image references..."
echo ""

# Day 8 - Gradient descent
if grep -q "Day%208" _posts/2024-01-09-dl-day8-day-8-day-8.md 2>/dev/null; then
    cp _posts/2024-01-09-dl-day8-day-8-day-8.md _posts/2024-01-09-dl-day8-day-8-day-8.md.bak2
    sed -i '' 's|Day%208%20%EC%9D%BC%EB%B3%80%EC%88%98%20%EC%B5%9C%EC%A0%81%ED%99%94%20%EB%AC%B8%EC%A0%9C%EC%99%80%20%EA%B2%BD%EC%82%AC%ED%95%98%EA%B0%95%EB%B2%95%20161f0f24f9318032a355d6c77b9562e5/Untitled.jpeg|/assets/img/blog/deep-learning/untitled.jpeg|g' _posts/2024-01-09-dl-day8-day-8-day-8.md
    echo "✓ Fixed dl-day8"
fi

# Day 9 - Local and global minima
if grep -q "Day%209" _posts/2024-01-10-dl-day9-day-9-day-9.md 2>/dev/null; then
    cp _posts/2024-01-10-dl-day9-day-9-day-9.md _posts/2024-01-10-dl-day9-day-9-day-9.md.bak2
    sed -i '' 's|Day%209%20%EA%B5%AD%EC%86%8C%20%EC%B5%9C%EC%86%8C%EC%A0%90%EA%B3%BC%20%EC%A0%84%EC%97%AD%20%EC%B5%9C%EC%86%8C%EC%A0%90%20161f0f24f931802a97f3e1b6d06aea24/Untitled.png|/assets/img/blog/deep-learning/untitled_day_9_161f0f24f931802a97f3e1b6.png|g' _posts/2024-01-10-dl-day9-day-9-day-9.md
    echo "✓ Fixed dl-day9"
fi

# Day 10 - Multivariate neural networks
if grep -q "Day%2010" _posts/2024-01-11-dl-day10-day-10-day-10.md 2>/dev/null; then
    cp _posts/2024-01-11-dl-day10-day-10-day-10.md _posts/2024-01-11-dl-day10-day-10-day-10.md.bak2
    sed -i '' 's|Day%2010%20%EB%8B%A4%EB%B3%80%EC%88%98%EB%A1%9C%EC%9D%98%20%ED%99%95%EC%9E%A5%EA%B3%BC%20%EC%9D%B8%EA%B3%B5%EC%8B%A0%EA%B2%BD%EB%A7%9D%20161f0f24f9318072b790d52afd98d2a8/Untitled.png|/assets/img/blog/deep-learning/untitled.png|g' _posts/2024-01-11-dl-day10-day-10-day-10.md
    sed -i '' 's|Day%2010%20%EB%8B%A4%EB%B3%80%EC%88%98%EB%A1%9C%EC%9D%98%20%ED%99%95%EC%9E%A5%EA%B3%BC%20%EC%9D%B8%EA%B3%B5%EC%8B%A0%EA%B2%BD%EB%A7%9D%20161f0f24f9318072b790d52afd98d2a8/Untitled%201.png|/assets/img/blog/deep-learning/untitled_1.png|g' _posts/2024-01-11-dl-day10-day-10-day-10.md
    sed -i '' 's|Day%2010%20%EB%8B%A4%EB%B3%80%EC%88%98%EB%A1%9C%EC%9D%98%20%ED%99%95%EC%9E%A5%EA%B3%BC%20%EC%9D%B8%EA%B3%B5%EC%8B%A0%EA%B2%BD%EB%A7%9D%20161f0f24f9318072b790d52afd98d2a8/Untitled%202.png|/assets/img/blog/deep-learning/untitled_2.png|g' _posts/2024-01-11-dl-day10-day-10-day-10.md
    sed -i '' 's|Day%2010%20%EB%8B%A4%EB%B3%80%EC%88%98%EB%A1%9C%EC%9D%98%20%ED%99%95%EC%9E%A5%EA%B3%BC%20%EC%9D%B8%EA%B3%B5%EC%8B%A0%EA%B2%BD%EB%A7%9D%20161f0f24f9318072b790d52afd98d2a8/Untitled%203.png|/assets/img/blog/deep-learning/untitled_3.png|g' _posts/2024-01-11-dl-day10-day-10-day-10.md
    echo "✓ Fixed dl-day10"
fi

# Day 13 - Backpropagation calculation
if grep -q "Day%2013" _posts/2024-01-14-dl-day13-day-13-day-13.md 2>/dev/null; then
    cp _posts/2024-01-14-dl-day13-day-13-day-13.md _posts/2024-01-14-dl-day13-day-13-day-13.md.bak2
    sed -i '' 's|Day%2013%20%EC%97%AD%EC%A0%84%ED%8C%8C%EC%9D%98%20%EA%B3%84%EC%82%B0%20161f0f24f93180a4a025d44fc5edf9a8/Untitled.png|/assets/img/blog/deep-learning/untitled_day_13_161f0f24f93180a4a025d44.png|g' _posts/2024-01-14-dl-day13-day-13-day-13.md
    echo "✓ Fixed dl-day13"
fi

echo ""
echo "All image references fixed!"
echo ""
echo "Verifying..."
broken=$(grep -r "Day%20\|Day%2[08]\|Introduction%20to%20Deep" _posts/*.md 2>/dev/null | grep "!\[" || echo "")
if [[ -z "$broken" ]]; then
    echo "✅ No broken references found!"
else
    echo "⚠️  Still some issues:"
    echo "$broken"
fi

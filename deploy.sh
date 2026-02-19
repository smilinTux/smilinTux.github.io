#!/bin/bash
set -e

# Simple deploy script for SMILinTux Hugo site
# Usage: ./deploy.sh

echo "🚀 Building Hugo site..."
cd "$(dirname "$0")"

# Ensure Hugo 0.128+ is installed
HUGO_VERSION=$(hugo version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
REQUIRED_VERSION="0.128.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$HUGO_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "⚠️  Hugo $REQUIRED_VERSION+ required (have $HUGO_VERSION)"
    echo "Download from: https://github.com/gohugoio/hugo/releases"
    exit 1
fi

# Build site
echo "📦 Generating static site..."
rm -rf public
hugo --minify

# Check SKSecurity was generated
if [ ! -d "public/SKSecurity" ]; then
    echo "❌ Error: SKSecurity page not generated!"
    exit 1
fi

echo "✅ SKSecurity page generated successfully"
echo "   Pages: $(find public -name '*.html' | wc -l)"
echo "   SKSecurity: $(wc -c < public/SKSecurity/index.html) bytes"

# Stage and commit
echo "📝 Committing changes..."
git add -A
git commit -m "Update site - $(date '+%Y-%m-%d %H:%M')" || echo "No changes to commit"

# Push to trigger GitHub Pages
echo "🚀 Pushing to trigger GitHub Pages..."
git push origin main

echo ""
echo "✅ Deploy initiated! GitHub Actions will build and publish to smilintux.github.io"
echo "🌐 Site will be available at: https://smilintux.org/SKSecurity/"

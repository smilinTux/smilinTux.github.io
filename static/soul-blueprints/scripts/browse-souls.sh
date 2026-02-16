#!/bin/bash
# Soul Blueprints - Browse Marketplace
# Display available souls with ratings and descriptions

SOUL_DIR="${HOME}/.config/soul-blueprints"
REGISTRY_FILE="$SOUL_DIR/registry.json"

if [ ! -f "$REGISTRY_FILE" ]; then
    echo "❌ Marketplace not initialized. Run ./setup-marketplace.sh first."
    exit 1
fi

echo "🎭 Soul Blueprints Marketplace"
echo "============================="
echo ""

# Display featured souls
echo "🌟 Featured Personalities:"
echo ""

jq -r '.featured_souls[] | 
"🎭 \(.title)
   \(.description)
   Category: \(.category | ascii_upcase) | Rating: \(.rating)/5.0 ⭐ | Downloads: \(.downloads)
   Tags: \(.tags | join(", "))
   Preview: \(.preview)
   Install: ./install-soul.sh \(.name)
"' "$REGISTRY_FILE"

echo ""
echo "📚 Categories:"
echo ""

jq -r '.categories | to_entries[] | "• \(.key | ascii_upcase): \(.value)"' "$REGISTRY_FILE"

echo ""
echo "🔍 Search & Filter:"
echo "   ./search-souls.sh \"business wisdom\"    - Search by keywords"
echo "   ./browse-souls.sh --category business   - Filter by category" 
echo "   ./browse-souls.sh --top-rated          - Show highest rated"
echo ""

# Handle category filtering
if [ "$1" = "--category" ] && [ -n "$2" ]; then
    CATEGORY="$2"
    echo "🎯 Souls in category: $CATEGORY"
    echo "=========================="
    
    jq -r --arg cat "$CATEGORY" '.featured_souls[] | select(.category == $cat) | 
    "🎭 \(.title) - Rating: \(.rating)/5.0 ⭐
       \(.description)
       Install: ./install-soul.sh \(.name)
    "' "$REGISTRY_FILE"
    
elif [ "$1" = "--top-rated" ]; then
    echo "🏆 Top Rated Souls"
    echo "=================="
    
    jq -r '.featured_souls | sort_by(.rating) | reverse[] |
    "🎭 \(.title) - \(.rating)/5.0 ⭐ (\(.downloads) downloads)
       \(.description)
       Install: ./install-soul.sh \(.name)
    "' "$REGISTRY_FILE"
fi

echo "💡 Tips:"
echo "   • Use ./preview-soul.sh <name> to try before installing"
echo "   • All souls are backed up automatically"
echo "   • Switch personalities anytime with ./switch-soul.sh <name>"
echo ""
echo "🎭 Ready to end corporate AI robotics? Pick a soul and give your AI real personality!"
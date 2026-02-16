#!/bin/bash
# Soul Blueprints - Switch Soul
# Switch between installed soul personalities

SOUL_NAME="$1"
if [ -z "$SOUL_NAME" ]; then
    echo "Usage: $0 <soul_name>"
    echo ""
    echo "Installed souls:"
    
    INSTALLED_FILE="${HOME}/.config/soul-blueprints/installed.json"
    if [ -f "$INSTALLED_FILE" ]; then
        jq -r '.installed_souls[]? | "   • \(.name) - \(.title)"' "$INSTALLED_FILE" 2>/dev/null
        
        CURRENT=$(jq -r '.current_soul // "none"' "$INSTALLED_FILE" 2>/dev/null)
        echo ""
        echo "Current: $CURRENT"
    fi
    
    echo ""
    echo "Install new souls: ./browse-souls.sh"
    exit 1
fi

SOUL_DIR="${HOME}/.config/soul-blueprints"
INSTALLED_FILE="$SOUL_DIR/installed.json"
WORKSPACE_SOUL="${HOME}/clawd/SOUL.md"

if [ ! -f "$INSTALLED_FILE" ]; then
    echo "❌ Soul system not initialized. Run ./setup-marketplace.sh first."
    exit 1
fi

echo "🔄 Switching to Soul: $SOUL_NAME"
echo "==============================="

# Check if soul is installed
SOUL_INFO=$(jq -r --arg name "$SOUL_NAME" '.installed_souls[] | select(.name == $name)' "$INSTALLED_FILE")

if [ -z "$SOUL_INFO" ] || [ "$SOUL_INFO" = "null" ]; then
    echo "❌ Soul '$SOUL_NAME' is not installed."
    echo ""
    echo "Installed souls:"
    jq -r '.installed_souls[]? | "   • \(.name) - \(.title)"' "$INSTALLED_FILE"
    echo ""
    echo "Install it first: ./install-soul.sh $SOUL_NAME"
    exit 1
fi

SOUL_TITLE=$(echo "$SOUL_INFO" | jq -r '.title')
SOUL_LOCAL_DIR="$SOUL_DIR/souls/$SOUL_NAME"
SOUL_FILE="$SOUL_LOCAL_DIR/SOUL.md"

# Check if soul file exists
if [ ! -f "$SOUL_FILE" ]; then
    echo "❌ Soul file not found: $SOUL_FILE"
    echo "Try reinstalling: ./install-soul.sh $SOUL_NAME"
    exit 1
fi

# Backup current SOUL.md
CURRENT_SOUL=$(jq -r '.current_soul // "unknown"' "$INSTALLED_FILE")
if [ -f "$WORKSPACE_SOUL" ]; then
    BACKUP_NAME="switch-from-$CURRENT_SOUL-$(date +%Y%m%d-%H%M%S)"
    cp "$WORKSPACE_SOUL" "$SOUL_DIR/backups/$BACKUP_NAME.md"
    
    jq --arg name "$BACKUP_NAME" --arg desc "Backup before switching to $SOUL_NAME" \
       '.backups += [{"name": $name, "created": (now | strftime("%Y-%m-%dT%H:%M:%SZ")), "description": $desc}]' \
       "$INSTALLED_FILE" > "${INSTALLED_FILE}.tmp" && mv "${INSTALLED_FILE}.tmp" "$INSTALLED_FILE"
    
    echo "📦 Current personality backed up as '$BACKUP_NAME'"
fi

# Switch to new soul
cp "$SOUL_FILE" "$WORKSPACE_SOUL"

# Update current soul tracker
jq --arg name "$SOUL_NAME" '.current_soul = $name' "$INSTALLED_FILE" > "${INSTALLED_FILE}.tmp" && mv "${INSTALLED_FILE}.tmp" "$INSTALLED_FILE"

echo "🎭 Switched to: $SOUL_TITLE"
echo ""
echo "🎉 Personality Switch Complete!"
echo "   Previous: $CURRENT_SOUL"
echo "   Current: $SOUL_NAME ($SOUL_TITLE)"
echo "   Backup: $BACKUP_NAME"
echo ""
echo "💬 Try talking to your AI - the personality should be completely different!"
echo ""
echo "🔄 Switch again: ./switch-soul.sh <name>"
echo "📋 Browse souls: ./browse-souls.sh"

# Show current personality info
echo ""
echo "📋 Current Soul Preview:"
if command -v head >/dev/null; then
    echo "---"
    head -10 "$WORKSPACE_SOUL" | grep -E "^(#|##|\*\*|Name:|Vibe:|Philosophy:)" | head -5
    echo "---"
fi
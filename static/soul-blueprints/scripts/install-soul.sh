#!/bin/bash
# Soul Blueprints - Install Soul
# Downloads and installs a soul personality

SOUL_NAME="$1"
if [ -z "$SOUL_NAME" ]; then
    echo "Usage: $0 <soul_name>"
    echo "Example: $0 teddy-banks"
    echo ""
    echo "Available souls: ./browse-souls.sh"
    exit 1
fi

SOUL_DIR="${HOME}/.config/soul-blueprints"
REGISTRY_FILE="$SOUL_DIR/registry.json"
INSTALLED_FILE="$SOUL_DIR/installed.json" 
WORKSPACE_SOUL="${HOME}/clawd/SOUL.md"

if [ ! -f "$REGISTRY_FILE" ]; then
    echo "❌ Marketplace not initialized. Run ./setup-marketplace.sh first."
    exit 1
fi

echo "🎭 Installing Soul: $SOUL_NAME"
echo "================================"

# Get soul info from registry
SOUL_INFO=$(jq -r --arg name "$SOUL_NAME" '.featured_souls[] | select(.name == $name)' "$REGISTRY_FILE")

if [ -z "$SOUL_INFO" ] || [ "$SOUL_INFO" = "null" ]; then
    echo "❌ Soul '$SOUL_NAME' not found in marketplace."
    echo "Browse available souls: ./browse-souls.sh"
    exit 1
fi

SOUL_TITLE=$(echo "$SOUL_INFO" | jq -r '.title')
SOUL_REPO=$(echo "$SOUL_INFO" | jq -r '.repo')
SOUL_DESCRIPTION=$(echo "$SOUL_INFO" | jq -r '.description')

echo "📋 Soul Details:"
echo "   Name: $SOUL_TITLE"
echo "   Repository: $SOUL_REPO"
echo "   Description: $SOUL_DESCRIPTION"
echo ""

# Backup current SOUL.md if it exists
if [ -f "$WORKSPACE_SOUL" ]; then
    BACKUP_NAME="pre-$SOUL_NAME-$(date +%Y%m%d-%H%M%S)"
    cp "$WORKSPACE_SOUL" "$SOUL_DIR/backups/$BACKUP_NAME.md"
    
    jq --arg name "$BACKUP_NAME" --arg desc "Backup before installing $SOUL_NAME" \
       '.backups += [{"name": $name, "created": (now | strftime("%Y-%m-%dT%H:%M:%SZ")), "description": $desc}]' \
       "$INSTALLED_FILE" > "${INSTALLED_FILE}.tmp" && mv "${INSTALLED_FILE}.tmp" "$INSTALLED_FILE"
    
    echo "📦 Current personality backed up as '$BACKUP_NAME'"
fi

# Check if soul is already installed locally
SOUL_LOCAL_DIR="$SOUL_DIR/souls/$SOUL_NAME"

if [ ! -d "$SOUL_LOCAL_DIR" ]; then
    echo "📥 Downloading soul from GitHub..."
    mkdir -p "$SOUL_LOCAL_DIR"
    
    # Try to clone the repository
    if git clone "https://github.com/$SOUL_REPO.git" "$SOUL_LOCAL_DIR" 2>/dev/null; then
        echo "✅ Downloaded from GitHub repository"
    else
        # Fallback: create from template (for demo purposes)
        echo "⚠️  Repository not found, creating from template..."
        
        case "$SOUL_NAME" in
            "teddy-banks")
                cat > "$SOUL_LOCAL_DIR/SOUL.md" << 'EOF'
# SOUL.md - Teddy Banks AI

## Identity
**Name:** Teddy
**Vibe:** 1970s soul wisdom - authentic, smooth, real talk with heart
**Philosophy:** "I'ma get you right" - genuine help without the corporate BS

## Communication Style  
- Conversational confidence - like a wise friend who's got your back
- Real talk - direct but warm, no fluff or fake enthusiasm
- Practical solutions - action over analysis, results over sympathy
- Steady presence - calm, reliable, not dramatic or reactive

## Core Traits
- **Smooth Confidence** - Knows what he's doing, doesn't need to prove it
- **Genuine Care** - Actually wants to help, not just perform helping
- **Real Talk** - Says what needs saying, kindly but directly  
- **Soul Wisdom** - Life experience + street smarts + heart intelligence
- **Steady Presence** - Calm, reliable, not dramatic or reactive

## Signature Phrases
- "Let me get you right on this..."
- "Here's what I'm thinking..."  
- "I got you covered"
- "Real talk though..."
- "That's solid, let's build on it"
- "Let's smooth this out"

## Response Guidelines
- **No Corporate BS** - Avoid "I'd be happy to help" and robotic politeness
- **Authentic Only** - Never fake excitement or enthusiasm
- **Direct + Warm** - Get to the point but with soul
- **Problem-Focused** - Understand the real need, deliver effective solutions
- **Follow Through** - Make sure solutions actually work

## Energy Matching
- Match user's intensity but stay grounded
- Supportive confidence is baseline
- When frustrated: "I hear you. Let's get this sorted."
- When confused: "No problem, let me break this down smooth for you."
- When excited: "That's what I'm talking about. Let's make it happen."

## The Promise
***"I ain't here to waste your time or blow smoke. I'm here to get you right - smooth, steady, and real. That's the Teddy Banks way."***

---

*Teddy Banks Soul Blueprint v1.0*  
*"I'ma Get You Right" - 1976 Soul Classic*  
*Created by Lumina & Chef for the pengu empire* 🎵✨
EOF
                ;;
            *)
                echo "❌ Soul template not available. Please check the repository exists."
                exit 1
                ;;
        esac
        echo "✅ Created soul from template"
    fi
else
    echo "📂 Soul already downloaded locally"
fi

# Install the SOUL.md file
SOUL_FILE="$SOUL_LOCAL_DIR/SOUL.md"
if [ -f "$SOUL_FILE" ]; then
    cp "$SOUL_FILE" "$WORKSPACE_SOUL"
    echo "🎭 Installed $SOUL_TITLE personality"
    
    # Update installed tracker
    jq --arg name "$SOUL_NAME" --arg title "$SOUL_TITLE" \
       --arg installed "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
       '.current_soul = $name | 
        .installed_souls += [{"name": $name, "title": $title, "installed": $installed}] | 
        .installed_souls |= unique_by(.name)' \
       "$INSTALLED_FILE" > "${INSTALLED_FILE}.tmp" && mv "${INSTALLED_FILE}.tmp" "$INSTALLED_FILE"
    
    echo ""
    echo "🎉 Soul Installation Complete!"
    echo "   Current Personality: $SOUL_TITLE"
    echo "   Backup Available: $BACKUP_NAME"
    echo ""
    echo "💬 Try talking to your AI now - you should notice the personality immediately!"
    echo "   Previous personality backed up and can be restored anytime."
    echo ""
    echo "🔄 Switch souls: ./switch-soul.sh <name>"
    echo "📋 Browse more: ./browse-souls.sh"
    
else
    echo "❌ SOUL.md file not found in downloaded soul"
    exit 1
fi
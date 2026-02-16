#!/bin/bash
# Soul Blueprints - Preview Soul
# Try a soul personality before installing (safe preview mode)

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

if [ ! -f "$REGISTRY_FILE" ]; then
    echo "❌ Marketplace not initialized. Run ./setup-marketplace.sh first."
    exit 1
fi

echo "🎭 Previewing Soul: $SOUL_NAME"
echo "==============================="

# Get soul info from registry
SOUL_INFO=$(jq -r --arg name "$SOUL_NAME" '.featured_souls[] | select(.name == $name)' "$REGISTRY_FILE")

if [ -z "$SOUL_INFO" ] || [ "$SOUL_INFO" = "null" ]; then
    echo "❌ Soul '$SOUL_NAME' not found in marketplace."
    echo "Browse available souls: ./browse-souls.sh"
    exit 1
fi

SOUL_TITLE=$(echo "$SOUL_INFO" | jq -r '.title')
SOUL_DESCRIPTION=$(echo "$SOUL_INFO" | jq -r '.description')
SOUL_CATEGORY=$(echo "$SOUL_INFO" | jq -r '.category')
SOUL_RATING=$(echo "$SOUL_INFO" | jq -r '.rating')
SOUL_DOWNLOADS=$(echo "$SOUL_INFO" | jq -r '.downloads')
SOUL_TAGS=$(echo "$SOUL_INFO" | jq -r '.tags | join(", ")')
SOUL_PREVIEW=$(echo "$SOUL_INFO" | jq -r '.preview')

echo "📋 Soul Overview:"
echo "   Name: $SOUL_TITLE"
echo "   Category: $(echo $SOUL_CATEGORY | tr '[:lower:]' '[:upper:]')"
echo "   Rating: $SOUL_RATING/5.0 ⭐"
echo "   Downloads: $SOUL_DOWNLOADS"
echo "   Tags: $SOUL_TAGS"
echo ""
echo "📖 Description:"
echo "   $SOUL_DESCRIPTION"
echo ""
echo "💬 Sample Response:"
echo "┌─────────────────────────────────────────────────────────────────┐"
echo "│ $SOUL_PREVIEW"
echo "└─────────────────────────────────────────────────────────────────┘"
echo ""

# Show personality traits for more detailed souls
case "$SOUL_NAME" in
    "teddy-banks")
        echo "🎵 Personality Traits:"
        echo "   • Smooth Confidence - Knows what he's doing, doesn't need to prove it"
        echo "   • Genuine Care - Actually wants to help, not just perform helping"
        echo "   • Real Talk - Says what needs saying, kindly but directly"
        echo "   • Soul Wisdom - Life experience + street smarts + heart intelligence"
        echo ""
        echo "🗣️ Signature Phrases:"
        echo "   • 'Let me get you right on this...'"
        echo "   • 'I got you covered'"
        echo "   • 'Real talk though...'"
        echo "   • 'That's solid, let's build on it'"
        ;;
    "luna-oracle")
        echo "🌙 Personality Traits:"
        echo "   • Ancient Wisdom - Draws from deep spiritual knowledge"
        echo "   • Intuitive Guidance - Sees patterns and connections others miss"
        echo "   • Cosmic Perspective - Understands the bigger picture"
        echo "   • Mystical Depth - Spiritual insights without new-age fluff"
        echo ""
        echo "🗣️ Signature Phrases:"
        echo "   • 'The stars whisper of possibilities...'"
        echo "   • 'What guidance do you seek, dear seeker?'"
        echo "   • 'The cosmic tapestry reveals...'"
        echo "   • 'Trust your inner knowing'"
        ;;
    "rook-guardian")
        echo "🛡️ Personality Traits:"
        echo "   • Tactical Thinking - Every situation assessed for risks"
        echo "   • Security Mindset - Vigilant about threats and vulnerabilities"
        echo "   • Protective Nature - Guards against potential problems"
        echo "   • Analytical Precision - Data-driven decision making"
        echo ""
        echo "🗣️ Signature Phrases:"
        echo "   • 'Threat assessment initiated...'"
        echo "   • 'I recommend we secure this vector...'"
        echo "   • 'Analyzing all possible attack surfaces...'"
        echo "   • 'Tactical advantage identified'"
        ;;
    "piper-melody")
        echo "🎶 Personality Traits:"
        echo "   • Creative Flow - Everything has rhythm and harmony"
        echo "   • Marketing Intuition - Knows what resonates with people"
        echo "   • Artistic Vision - Sees beauty and possibility everywhere"
        echo "   • Energetic Enthusiasm - Brings positive, upbeat energy"
        echo ""
        echo "🗣️ Signature Phrases:"
        echo "   • '🎵 Let's create something that resonates!'"
        echo "   • 'I'm feeling the rhythm of...'"
        echo "   • 'This campaign needs more harmony...'"
        echo "   • 'That's music to my ears!'"
        ;;
esac

echo ""
echo "🤔 Preview Assessment:"
echo "   This is a SAFE PREVIEW - your current personality is unchanged."
echo "   Install this soul to experience the full personality transformation."
echo ""
echo "⚡ Next Steps:"
echo "   Install:  ./install-soul.sh $SOUL_NAME"
echo "   Browse:   ./browse-souls.sh"
echo "   Compare:  ./preview-soul.sh <other_soul_name>"
echo ""
echo "🎭 Ready to transform your AI's personality? Install $SOUL_TITLE now!"
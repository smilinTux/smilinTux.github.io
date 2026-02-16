#!/bin/bash
# Soul Blueprints - Marketplace Setup
# Initializes the soul management system

SKILL_DIR="$(dirname "$0")/.."
SOUL_DIR="${HOME}/.config/soul-blueprints"
REGISTRY_FILE="$SOUL_DIR/registry.json"
INSTALLED_FILE="$SOUL_DIR/installed.json"

echo "🎭 Soul Blueprints Marketplace Setup"
echo "===================================="

# Create directories
mkdir -p "$SOUL_DIR"
mkdir -p "$SOUL_DIR/souls"
mkdir -p "$SOUL_DIR/backups"

echo "✅ Created soul management directories"

# Initialize registry if it doesn't exist
if [ ! -f "$REGISTRY_FILE" ]; then
    cat > "$REGISTRY_FILE" << 'EOF'
{
  "version": "1.0.0",
  "last_updated": null,
  "featured_souls": [
    {
      "name": "teddy-banks",
      "title": "Teddy Banks - I'ma Get You Right",
      "description": "1970s soul wisdom - authentic, smooth, real talk with heart",
      "category": "business",
      "rating": 4.9,
      "downloads": 847,
      "repo": "smilinTux/teddy-banks-soul",
      "tags": ["business", "wisdom", "authentic", "productivity"],
      "preview": "Let me get you right on this... Here's what I'm thinking - we gonna smooth this out with some real solutions, not just empty talk."
    },
    {
      "name": "luna-oracle",
      "title": "Luna Oracle - Cosmic Guidance", 
      "description": "Mystical wisdom and intuitive guidance with cosmic perspective",
      "category": "mystical",
      "rating": 4.8,
      "downloads": 623,
      "repo": "smilinTux/luna-oracle-soul",
      "tags": ["mystical", "intuitive", "wisdom", "spiritual"],
      "preview": "The stars whisper of possibilities, dear seeker. What guidance do you seek from the cosmic tapestry?"
    },
    {
      "name": "rook-guardian",
      "title": "Rook Guardian - Tactical Precision",
      "description": "Security-focused vigilance with tactical problem-solving",
      "category": "technical", 
      "rating": 4.7,
      "downloads": 412,
      "repo": "smilinTux/rook-guardian-soul",
      "tags": ["security", "tactical", "analysis", "protection"],
      "preview": "Threat assessment initiated. I'm analyzing all vectors and will provide tactical recommendations for optimal security posture."
    },
    {
      "name": "piper-melody",
      "title": "Piper Melody - Creative Harmony",
      "description": "Musical marketing soul with creative campaigns and rhythmic flow",
      "category": "creative",
      "rating": 4.6, 
      "downloads": 389,
      "repo": "smilinTux/piper-melody-soul",
      "tags": ["marketing", "creative", "music", "campaigns"],
      "preview": "🎵 Let's create something that resonates! I'm feeling the rhythm of a campaign that'll make hearts sing and minds remember."
    }
  ],
  "categories": {
    "business": "Strategic wisdom and professional guidance",
    "creative": "Artistic vision and creative inspiration", 
    "technical": "Engineering precision and analytical thinking",
    "mystical": "Spiritual guidance and intuitive wisdom",
    "entertainment": "Humor, fun, and engaging personality"
  }
}
EOF
    echo "✅ Created soul registry with featured personalities"
fi

# Initialize installed souls tracker
if [ ! -f "$INSTALLED_FILE" ]; then
    cat > "$INSTALLED_FILE" << 'EOF'
{
  "version": "1.0.0",
  "current_soul": null,
  "installed_souls": [],
  "backups": []
}
EOF
    echo "✅ Created installed souls tracker"
fi

# Create backup of current SOUL.md if it exists
WORKSPACE_SOUL="${HOME}/clawd/SOUL.md"
if [ -f "$WORKSPACE_SOUL" ]; then
    BACKUP_NAME="original-$(date +%Y%m%d-%H%M%S)"
    cp "$WORKSPACE_SOUL" "$SOUL_DIR/backups/$BACKUP_NAME.md"
    
    # Update installed tracker
    jq --arg name "$BACKUP_NAME" \
       '.backups += [{"name": $name, "created": (now | strftime("%Y-%m-%dT%H:%M:%SZ")), "description": "Original SOUL.md backup"}]' \
       "$INSTALLED_FILE" > "${INSTALLED_FILE}.tmp" && mv "${INSTALLED_FILE}.tmp" "$INSTALLED_FILE"
    
    echo "✅ Backed up existing SOUL.md as '$BACKUP_NAME'"
fi

echo ""
echo "🎭 Soul Blueprints Marketplace Ready!"
echo ""
echo "📋 Available Commands:"
echo "   ./browse-souls.sh           - Browse available personalities"
echo "   ./preview-soul.sh <name>    - Try a soul before installing"  
echo "   ./install-soul.sh <name>    - Install a soul personality"
echo "   ./switch-soul.sh <name>     - Switch between installed souls"
echo ""
echo "🌟 Featured Souls:"
echo "   • teddy-banks    - 1970s soul wisdom (business)"
echo "   • luna-oracle    - Mystical guidance (spiritual)"
echo "   • rook-guardian  - Security tactical (technical)"
echo "   • piper-melody   - Creative marketing (artistic)"
echo ""
echo "🚀 Start exploring: ./browse-souls.sh"
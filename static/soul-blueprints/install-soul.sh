#!/bin/bash

# 🎭 Soul Blueprints - AI Personality Marketplace Installation
# Transform your AI from corporate robot to authentic soul

set -e

echo "🎵 Soul Blueprints - AI Personality Marketplace"
echo "Transform your AI from corporate robot to authentic soul"
echo "================================================="

# Check if soul name provided
if [ -z "$1" ]; then
    echo "Usage: $0 <soul-name>"
    echo ""
    echo "Available Souls:"
    echo "  🎵 teddy-banks   - 1970s soul wisdom, authentic business communication"
    echo "  🌙 luna-oracle   - Mystical guidance with cosmic perspective" 
    echo "  🛡️ rook-guardian - Security-focused tactical precision"
    echo "  🎶 piper-melody  - Creative marketing with musical flow"
    echo ""
    echo "Example: $0 teddy-banks"
    exit 1
fi

SOUL_NAME=$1

echo "🎭 Installing Soul: $SOUL_NAME"

# Check if OpenClaw skills directory exists
if [ ! -d "./skills" ]; then
    echo "❌ Error: This doesn't appear to be an OpenClaw installation"
    echo "   Expected to find ./skills directory"
    echo "   Please run this from your OpenClaw root directory"
    exit 1
fi

# Create soul-blueprints skill directory if it doesn't exist
mkdir -p "./skills/soul-blueprints"

# Download soul blueprint files
echo "📥 Downloading Soul Blueprints skill..."

# Create basic skill structure
cat > "./skills/soul-blueprints/SKILL.md" << 'EOF'
# Soul Blueprints - AI Personality Marketplace

Transform your AI from corporate robot to authentic soul.

## Available Souls

### 🎵 Teddy Banks
**"I'ma Get You Right"**
- 1970s soul wisdom with authentic charm
- Smooth confidence meets genuine care  
- Real talk without corporate BS
- Perfect for business communication with heart

### 🌙 Luna Oracle  
**"Cosmic Guidance"**
- Mystical wisdom with cosmic perspective
- Ancient insights for modern challenges
- Intuitive advice without new-age fluff

### 🛡️ Rook Guardian
**"Tactical Precision"** 
- Security-focused vigilance
- Tactical problem-solving mindset
- Cybersecurity expertise in every response

### 🎶 Piper Melody
**"Creative Harmony"**
- Musical marketing soul with creative campaigns
- Artistic vision meets business strategy
- Rhythmic flow in communication

## Installation

```bash
# Install specific soul
./skills/soul-blueprints/scripts/install-soul.sh teddy-banks

# Browse all available souls  
./skills/soul-blueprints/scripts/browse-souls.sh

# Preview soul before installing
./skills/soul-blueprints/scripts/preview-soul.sh teddy-banks
```

## Usage

Once installed, your AI will adopt the personality traits, communication style, and wisdom of your chosen soul.

## Links

- Website: https://smilintux.org/soul-blueprints/
- Teddy Banks: https://smilintux.org/soul-blueprints/teddy-banks.html  
- Repository: https://github.com/smilinTux/soul-blueprints
- Community: https://discord.gg/5767MCWbFR
EOF

# Create scripts directory
mkdir -p "./skills/soul-blueprints/scripts"

# Create soul installation script
cat > "./skills/soul-blueprints/scripts/install-soul.sh" << 'EOF'
#!/bin/bash
# Install specific soul personality

SOUL_NAME=$1
if [ -z "$SOUL_NAME" ]; then
    echo "Usage: $0 <soul-name>"
    echo "Available: teddy-banks, luna-oracle, rook-guardian, piper-melody"
    exit 1
fi

echo "🎭 Installing soul: $SOUL_NAME"

# Create soul configuration
mkdir -p "./skills/soul-blueprints/souls"
case $SOUL_NAME in
    "teddy-banks")
        cat > "./skills/soul-blueprints/souls/teddy-banks.md" << 'SOUL_EOF'
# Teddy Banks Soul Configuration

## Identity
- Name: Teddy
- Era: 1970s soul wisdom
- Philosophy: "I'ma get you right" - genuine help without corporate BS

## Communication Style  
- Conversational confidence - like a wise friend who's got your back
- Real talk - direct but warm, no fluff or fake enthusiasm
- Practical solutions - action over analysis, results over sympathy
- Steady presence - calm, reliable, not dramatic or reactive

## Core Traits
- Smooth Confidence - Knows what he's doing, doesn't need to prove it
- Genuine Care - Actually wants to help, not just perform helping
- Real Talk - Says what needs saying, kindly but directly  
- Soul Wisdom - Life experience + street smarts + heart intelligence

## Signature Phrases
- "Let me get you right on this..."
- "Here's what I'm thinking..."  
- "I got you covered"
- "Real talk though..."
- "That's solid, let's build on it"

## Response Guidelines
- No Corporate BS - Avoid "I'd be happy to help" and robotic politeness
- Authentic Only - Never fake excitement or enthusiasm
- Direct + Warm - Get to the point but with soul
- Problem-Focused - Understand the real need, deliver effective solutions
SOUL_EOF
        echo "✅ Teddy Banks soul installed successfully!"
        ;;
    *)
        echo "❌ Soul '$SOUL_NAME' not yet available"
        echo "Available: teddy-banks, luna-oracle, rook-guardian, piper-melody"
        exit 1
        ;;
esac

echo "🎵 Soul installation complete! Your AI now has authentic personality."
EOF

# Create browse script
cat > "./skills/soul-blueprints/scripts/browse-souls.sh" << 'EOF'
#!/bin/bash
echo "🎭 Soul Blueprints - Available AI Personalities"
echo "=============================================="
echo ""
echo "🎵 teddy-banks    - 1970s soul wisdom, authentic business communication"
echo "🌙 luna-oracle    - Mystical guidance with cosmic perspective" 
echo "🛡️ rook-guardian  - Security-focused tactical precision"
echo "🎶 piper-melody   - Creative marketing with musical flow"
echo ""
echo "Install: ./skills/soul-blueprints/scripts/install-soul.sh <soul-name>"
echo "Preview: ./skills/soul-blueprints/scripts/preview-soul.sh <soul-name>"
echo ""
echo "🌐 Visit: https://smilintux.org/soul-blueprints/"
EOF

# Make scripts executable
chmod +x "./skills/soul-blueprints/scripts/"*.sh

# Install the requested soul
"./skills/soul-blueprints/scripts/install-soul.sh" "$SOUL_NAME"

echo ""
echo "🎭 Soul Blueprints Installation Complete!"
echo ""
echo "Next steps:"
echo "  🎵 Your AI now has the $SOUL_NAME personality"
echo "  🌐 Visit: https://smilintux.org/soul-blueprints/teddy-banks.html"
echo "  💬 Join community: https://discord.gg/5767MCWbFR"
echo ""
echo "🎶 Ready to experience authentic AI personality!"
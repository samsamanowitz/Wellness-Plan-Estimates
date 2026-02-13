#!/bin/bash

# Wellness Plans Data Repository - Quick Setup Script
# This script helps you quickly initialize and push the repository to GitHub

set -e  # Exit on error

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Wellness Plans Data Repository Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    echo "Please install git first: https://git-scm.com/downloads"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "plans.json" ] || [ ! -f "admin.html" ]; then
    echo "❌ Error: This script must be run from the wellness-plans-data directory"
    echo "Current directory: $(pwd)"
    echo "Expected files: plans.json, admin.html"
    exit 1
fi

# Get GitHub username
echo "📝 Step 1: Configuration"
echo ""
read -p "Enter your GitHub username or organization name: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ Error: GitHub username cannot be empty"
    exit 1
fi

echo ""
echo "✓ GitHub username: $GITHUB_USERNAME"
echo ""

# Update admin.html with GitHub username
echo "📝 Step 2: Configuring admin.html..."
echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/YOUR-GITHUB-USERNAME/$GITHUB_USERNAME/g" admin.html
else
    # Linux
    sed -i "s/YOUR-GITHUB-USERNAME/$GITHUB_USERNAME/g" admin.html
fi

echo "✓ admin.html configured with your GitHub username"
echo ""

# Initialize git repository
echo "📝 Step 3: Initializing Git repository..."
echo ""

if [ -d ".git" ]; then
    echo "⚠️  Git repository already initialized"
else
    git init
    echo "✓ Git repository initialized"
fi

git checkout -b main 2>/dev/null || git checkout main
echo "✓ On branch: main"
echo ""

# Add files
echo "📝 Step 4: Adding files to Git..."
echo ""

git add plans.json admin.html README.md .gitignore
git status
echo ""

# Commit
echo "📝 Step 5: Creating initial commit..."
echo ""

git commit -m "Initial commit: wellness plans data and admin interface" || echo "⚠️  Files already committed"
echo ""

# Set up remote
echo "📝 Step 6: Setting up GitHub remote..."
echo ""

REPO_URL="https://github.com/$GITHUB_USERNAME/wellness-plans-data.git"
echo "Repository URL: $REPO_URL"
echo ""

if git remote get-url origin &> /dev/null; then
    echo "⚠️  Remote 'origin' already exists"
    read -p "Do you want to update it? (y/n): " UPDATE_REMOTE
    if [ "$UPDATE_REMOTE" = "y" ]; then
        git remote set-url origin "$REPO_URL"
        echo "✓ Remote updated"
    fi
else
    git remote add origin "$REPO_URL"
    echo "✓ Remote added"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🎉 Repository Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Create the repository on GitHub:"
echo "   https://github.com/new"
echo "   Repository name: wellness-plans-data"
echo "   (Leave 'Initialize with README' unchecked)"
echo ""
echo "2. Push your code:"
echo "   git push -u origin main"
echo ""
echo "3. Enable GitHub Pages:"
echo "   Go to: https://github.com/$GITHUB_USERNAME/wellness-plans-data/settings/pages"
echo "   Source: main branch, / (root) folder"
echo ""
echo "4. Your admin interface will be at:"
echo "   https://$GITHUB_USERNAME.github.io/wellness-plans-data/admin.html"
echo ""
echo "5. Your plans data will be at:"
echo "   https://$GITHUB_USERNAME.github.io/wellness-plans-data/plans.json"
echo ""
echo "📚 Full instructions: See DEPLOYMENT_GUIDE.md"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

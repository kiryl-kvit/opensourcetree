#!/bin/bash
#
# Setup script for OpenSourceTree development environment
# Run this after cloning the repository: ./setup-dev.sh
#

set -e

echo "🔧 Setting up OpenSourceTree development environment..."
echo ""

# Install git hooks
echo "📌 Installing git hooks..."
if [ -f .githooks/pre-commit ]; then
    cp .githooks/pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✅ Pre-commit hook installed"
else
    echo "⚠️  Warning: .githooks/pre-commit not found"
fi

echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "The pre-commit hook will now:"
echo "  • Format code automatically"
echo "  • Run analyzers on every commit"
echo "  • Block commits if build fails"
echo ""

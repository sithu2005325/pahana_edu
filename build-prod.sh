#!/bin/bash

# Production Build Script for Bookshop Frontend
echo "🚀 Starting production build..."

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf dist
rm -rf node_modules/.cache

# Install dependencies
echo "📦 Installing dependencies..."
npm ci --production=false

# Run tests (if available)
echo "🧪 Running tests..."
npm test --if-present

# Build for production
echo "🔨 Building for production..."
npm run build

# Check build success
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📊 Build statistics:"
    du -sh dist/
    
    # Create deployment package
    echo "📦 Creating deployment package..."
    tar -czf bookshop-frontend-$(date +%Y%m%d-%H%M%S).tar.gz dist/
    
    echo "🎉 Production build completed successfully!"
    echo "📁 Build output: dist/"
    echo "📦 Deployment package: bookshop-frontend-*.tar.gz"
else
    echo "❌ Build failed!"
    exit 1
fi

#!/bin/bash

# EchoForge iOS App Setup Script
# This script helps set up the iOS app with Firebase integration

echo "🎙️ EchoForge iOS App Setup"
echo "=========================="
echo

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode is not installed. Please install Xcode from the Mac App Store."
    exit 1
fi

echo "✅ Xcode found"

# Check if we're in the right directory
if [ ! -d "EchoForge.xcodeproj" ]; then
    echo "❌ Please run this script from the ios-app directory"
    exit 1
fi

echo "✅ Project directory found"

# Check if Firebase configuration exists
if [ ! -f "EchoForge/GoogleService-Info.plist" ] || grep -q "YOUR_PROJECT_ID_HERE" "EchoForge/GoogleService-Info.plist"; then
    echo "⚠️  Firebase configuration needed"
    echo
    echo "To complete setup:"
    echo "1. Create a Firebase project at https://console.firebase.google.com"
    echo "2. Enable Vertex AI API in Google Cloud Console"
    echo "3. Add an iOS app with bundle ID: com.echoforge.app"
    echo "4. Download GoogleService-Info.plist"
    echo "5. Replace EchoForge/GoogleService-Info.plist with your downloaded file"
    echo
    echo "Then run this script again."
    exit 1
fi

echo "✅ Firebase configuration found"

# Try to build the project
echo "🔨 Building project..."
if xcodebuild -project EchoForge.xcodeproj -scheme EchoForge -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 15' build > /dev/null 2>&1; then
    echo "✅ Project builds successfully"
else
    echo "⚠️  Build issues detected. You may need to:"
    echo "   • Update Firebase dependencies in Xcode"
    echo "   • Check code signing settings"
    echo "   • Resolve any dependency conflicts"
fi

echo
echo "🎉 Setup complete!"
echo
echo "Next steps:"
echo "1. Open EchoForge.xcodeproj in Xcode"
echo "2. Select a simulator or device"
echo "3. Build and run the app"
echo
echo "For detailed instructions, see README.md"
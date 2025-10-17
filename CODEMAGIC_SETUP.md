# Nayafits iOS Build Setup for Codemagic

## 🚀 Quick Start Guide

### 1. **Sign up for Codemagic**
- Go to [codemagic.io](https://codemagic.io)
- Sign up with your GitHub account
- Connect your repository

### 2. **Configure Your App**
- **Bundle ID**: `com.nayafits.app` (or your preferred bundle ID)
- **App Name**: Nayafits
- **Version**: 1.0.0

### 3. **Required Apple Developer Account Setup**

#### **A. App Store Connect**
1. **Create an App Store Connect account** ($99/year)
2. **Create a new app** in App Store Connect:
   - Bundle ID: `com.nayafits.app`
   - App Name: Nayafits
   - Primary Language: English

#### **B. Certificates and Provisioning Profiles**
1. **Create a Distribution Certificate**:
   - Go to Apple Developer Portal
   - Certificates, Identifiers & Profiles
   - Create iOS Distribution Certificate

2. **Create App Store Provisioning Profile**:
   - Create new provisioning profile
   - Select your app bundle ID
   - Select your distribution certificate

#### **C. App Store Connect API Key**
1. **Generate API Key**:
   - Go to App Store Connect
   - Users and Access > Keys
   - Create new API key with App Manager role

### 4. **Codemagic Configuration**

#### **A. Environment Variables**
Add these encrypted variables in Codemagic:

```
APP_STORE_CONNECT_ISSUER_ID: your_issuer_id
APP_STORE_CONNECT_KEY_IDENTIFIER: your_key_id
APP_STORE_CONNECT_PRIVATE_KEY: your_private_key_content
CERTIFICATE_PRIVATE_KEY: your_certificate_private_key
BUNDLE_ID: com.nayafits.app
APP_STORE_CONNECT_PASSWORD: your_app_store_connect_password
APP_STORE_CONNECT_USERNAME: your_app_store_connect_username
```

#### **B. Build Configuration**
- **Flutter Version**: stable
- **Xcode Version**: latest
- **Build Type**: iOS App Store

### 5. **Build Process**

#### **What happens during build:**
1. ✅ **Setup**: Keychain and certificates
2. ✅ **Dependencies**: Flutter packages and CocoaPods
3. ✅ **Testing**: Flutter analyze and unit tests
4. ✅ **Build**: iOS IPA file creation
5. ✅ **Distribution**: Upload to TestFlight

#### **Build Artifacts:**
- `build/ios/ipa/*.ipa` - Your iOS app file
- Build logs and reports

### 6. **Testing Your App**

#### **A. TestFlight (Recommended)**
1. **Build completes** → Automatically uploaded to TestFlight
2. **Add beta testers** in App Store Connect
3. **Install TestFlight** on your iPhone
4. **Test the app** with your beta testers

#### **B. Direct Installation**
1. **Download IPA** from Codemagic
2. **Use tools like**:
   - Apple Configurator 2
   - Xcode (if you have a Mac)
   - Third-party tools like AltStore

### 7. **App Store Submission**

#### **When ready for App Store:**
1. **Complete app metadata** in App Store Connect
2. **Add screenshots** and app description
3. **Submit for review** through App Store Connect
4. **Wait for Apple review** (1-7 days typically)

## 📱 **App Features Included**

Your Nayafits app includes:
- ✅ **Cross-platform UI** (iOS/Android compatible)
- ✅ **Product browsing** with real images
- ✅ **Shopping cart** functionality
- ✅ **User profile** management
- ✅ **Notifications** system
- ✅ **External links** (nayafits.com checkout)
- ✅ **Image picker** for profile photos
- ✅ **Local notifications**

## 🔧 **Troubleshooting**

### **Common Issues:**

#### **Build Fails:**
- Check bundle ID matches App Store Connect
- Verify certificates are valid
- Ensure all environment variables are set

#### **App Crashes:**
- Check iOS version compatibility
- Verify all permissions are granted
- Test on different iOS devices

#### **TestFlight Issues:**
- Ensure app is properly signed
- Check provisioning profile includes your device
- Verify App Store Connect configuration

## 📞 **Support**

- **Codemagic Docs**: [docs.codemagic.io](https://docs.codemagic.io)
- **Flutter iOS**: [flutter.dev/docs/deployment/ios](https://flutter.dev/docs/deployment/ios)
- **Apple Developer**: [developer.apple.com](https://developer.apple.com)

## 🎯 **Next Steps**

1. **Set up Apple Developer Account**
2. **Configure Codemagic**
3. **Run your first build**
4. **Test on TestFlight**
5. **Submit to App Store**

---

**Good luck with your Nayafits iOS app! 🚀📱**

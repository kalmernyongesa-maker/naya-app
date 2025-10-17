# Nayafits iOS Build Setup for Bitrise

## 🚀 Quick Start Guide (No GitHub Required)

### 1. **Sign up for Bitrise**
- Go to [bitrise.io](https://bitrise.io)
- **Sign up with your email** (no GitHub required)
- **Verify your email** address

### 2. **Create New App**
1. **Click "Add new app"**
2. **Choose "Private"** (since you're not using GitHub)
3. **Select "I want to add my app manually"**
4. **Fill in app details**:
   - App name: Nayafits
   - Bundle ID: com.nayafits.app
   - Platform: iOS

### 3. **Upload Your Project**

#### **Option A: Upload ZIP File**
1. **Create a ZIP** of your project:
   ```bash
   cd /home/evans-on2004/Documents/shalomfits/shalomfits
   zip -r nayafits-app.zip flutter_app/
   ```
2. **Upload the ZIP** to Bitrise
3. **Extract and configure** in Bitrise dashboard

#### **Option B: Use Git (Alternative Repository)**
1. **Create account on GitLab** or **Bitbucket**
2. **Push your code** there
3. **Connect to Bitrise**

### 4. **Configure iOS Build**

#### **A. Set Environment Variables**
In Bitrise dashboard, add these variables:
```
FLUTTER_PROJECT_LOCATION: flutter_app
BUNDLE_ID: com.nayafits.app
```

#### **B. Configure Workflow**
1. **Go to Workflow Editor**
2. **Use the provided `bitrise.yml`** configuration
3. **Set up iOS code signing**

### 5. **iOS Code Signing Setup**

#### **A. Apple Developer Account Required**
- **Cost**: $99/year
- **Required for**: App Store distribution

#### **B. Certificates and Provisioning Profiles**
1. **Create Distribution Certificate** in Apple Developer Portal
2. **Create App Store Provisioning Profile**
3. **Upload to Bitrise** in Code Signing section

### 6. **Build Process**

#### **What happens during build:**
1. ✅ **Setup**: Flutter environment
2. ✅ **Dependencies**: Flutter packages
3. ✅ **Testing**: Flutter analyze and test
4. ✅ **Build**: iOS archive creation
5. ✅ **Distribution**: Download IPA file

### 7. **Testing Your App**

#### **A. Download IPA**
1. **Build completes** → Download IPA from Bitrise
2. **Install on iPhone** using:
   - **Apple Configurator 2** (if you have a Mac)
   - **Third-party tools** like AltStore
   - **TestFlight** (if you have Apple Developer account)

#### **B. TestFlight (Recommended)**
1. **Upload IPA** to App Store Connect
2. **Create TestFlight build**
3. **Add beta testers**
4. **Install via TestFlight app**

## 📱 **Alternative: Manual Build Process**

### **If you want to build manually:**

#### **Option 1: Cloud Mac Service**
1. **MacStadium** or **MacinCloud** ($20-50/month)
2. **Remote desktop** to Mac
3. **Install Xcode** and build locally
4. **Download IPA** file

#### **Option 2: Local Mac (if available)**
1. **Copy project** to Mac
2. **Install Xcode** from App Store
3. **Run build**:
   ```bash
   flutter build ios
   ```

## 🔧 **Troubleshooting**

### **Common Issues:**

#### **Build Fails:**
- Check Flutter version compatibility
- Verify iOS deployment target
- Ensure all dependencies are compatible

#### **Code Signing Issues:**
- Verify certificates are valid
- Check provisioning profile matches bundle ID
- Ensure Apple Developer account is active

#### **App Installation Issues:**
- Check iOS version compatibility
- Verify device is registered in provisioning profile
- Use proper installation method

## 📞 **Support Resources**

- **Bitrise Docs**: [devcenter.bitrise.io](https://devcenter.bitrise.io)
- **Flutter iOS**: [flutter.dev/docs/deployment/ios](https://flutter.dev/docs/deployment/ios)
- **Apple Developer**: [developer.apple.com](https://developer.apple.com)

## 🎯 **Next Steps**

1. **Sign up for Bitrise**
2. **Upload your project**
3. **Configure iOS build**
4. **Run your first build**
5. **Test on iOS device**

---

**Your Nayafits app will be running on iOS soon! 🚀📱**

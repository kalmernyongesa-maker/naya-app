# ManuelThrifts Flutter App

A beautiful Flutter e-commerce application that mirrors the ManuelThrifts web interface, featuring premium thrift fashion shopping with modern UI/UX design.

## 🎨 Features

### Design System
- **Pink Theme**: Consistent with web version using primary pink (#F9A8D4) color scheme
- **Typography**: Figtree font family for modern, clean text
- **Components**: Custom elevate cards, liquid buttons, and search bars
- **Animations**: Smooth transitions, hover effects, and micro-interactions

### Core Features
- **Homepage**: Hero section with animated particles and floating elements
- **Product Catalog**: Grid layout with elevate cards showing product details
- **Search & Filter**: Advanced search with suggestions and filtering options
- **Shopping Cart**: Persistent cart with quantity controls and order summary
- **Wishlist**: Save favorite products for later
- **User Profile**: Account management and order history
- **Responsive Design**: Optimized for mobile, tablet, and desktop

### UI Components
- **ElevateCard**: Product cards with hover animations and wishlist functionality
- **LiquidButton**: Animated buttons with liquid fill effects and floating particles
- **SearchBar**: Smart search with live suggestions and recent searches
- **BottomNavigation**: Tab-based navigation with badge counters
- **HeroSection**: Immersive landing section with animated background

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart          # Color palette
│   │   ├── app_theme.dart           # Light/dark themes
│   │   ├── app_text_styles.dart     # Typography styles
│   │   └── app_dimensions.dart      # Spacing, sizes, breakpoints
│   └── widgets/
│       ├── elevate_card.dart        # Product card component
│       ├── liquid_button.dart       # Animated button component
│       ├── search_bar.dart          # Search input component
│       └── bottom_navigation.dart   # Navigation component
├── features/
│   ├── home/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── home_page.dart
│   │       └── widgets/
│   │           ├── hero_section.dart
│   │           ├── category_section.dart
│   │           ├── featured_products_section.dart
│   │           └── new_arrivals_section.dart
│   ├── shop/
│   │   └── presentation/
│   │       └── pages/
│   │           └── shop_page.dart
│   ├── cart/
│   │   └── presentation/
│   │       └── pages/
│   │           └── cart_page.dart
│   ├── wishlist/
│   │   └── presentation/
│   │       └── pages/
│   │           └── wishlist_page.dart
│   ├── profile/
│   │   └── presentation/
│   │       └── pages/
│   │           └── profile_page.dart
│   └── navigation/
│       └── presentation/
│           └── pages/
│               └── main_navigation_page.dart
└── main.dart
```

## 🎯 Key Components

### ElevateCard
Product cards with sophisticated hover animations:
- Scale and elevation effects on hover
- Wishlist button that appears on hover
- Add to cart button with slide-up animation
- Badge system for new, sale, and trending items
- Star ratings and review counts

### LiquidButton
Animated buttons with liquid fill effects:
- Smooth fill animation on hover
- Floating particle effects
- Multiple variants (primary/secondary)
- Loading states and disabled states

### SearchBar
Smart search component with:
- Live search suggestions
- Recent searches with clear option
- Keyboard navigation support
- Different suggestion types (products, brands, categories)

### HeroSection
Immersive landing section featuring:
- Animated background particles
- Floating clothing icons
- Grid pattern overlay
- Smooth text animations
- Call-to-action buttons

## 🎨 Design System

### Colors
- **Primary**: Pink (#F9A8D4, #EC4899)
- **Secondary**: Purple (#8B5CF6), Yellow (#FBBF24), Green (#10B981)
- **Neutrals**: Gray scale from 50 to 900
- **Status**: Success, Warning, Error, Info colors

### Typography
- **Font Family**: Figtree (Google Fonts)
- **Weights**: 300, 400, 500, 600, 700
- **Styles**: Display, Headline, Title, Body, Label variants

### Spacing
- **XS**: 4px, **S**: 8px, **M**: 16px, **L**: 24px, **XL**: 32px, **XXL**: 48px
- **Border Radius**: 4px to 50px with round and circle variants
- **Elevation**: 1px to 24px for shadows and depth

## 📱 Responsive Design

The app is designed to work seamlessly across different screen sizes:

- **Mobile**: < 480px - Single column layout, touch-optimized
- **Tablet**: 768px - Two-column grids, larger touch targets
- **Desktop**: > 1024px - Multi-column layouts, hover effects

## 🔧 State Management

Using **Riverpod** for state management:
- Provider-based architecture
- Reactive state updates
- Dependency injection
- Easy testing and debugging

## 🎭 Animations

Comprehensive animation system:
- **Duration**: 200ms (fast) to 800ms (slow)
- **Curves**: Ease, bounce, cubic-bezier variants
- **Types**: Scale, translate, fade, rotation
- **Triggers**: Hover, tap, scroll, page transitions

## 🚀 Future Enhancements

### Planned Features
- [ ] Product detail pages with image galleries
- [ ] Checkout flow with payment integration
- [ ] User authentication and registration
- [ ] Order tracking and history
- [ ] Push notifications
- [ ] Dark mode support
- [ ] Offline functionality
- [ ] Product reviews and ratings
- [ ] Wishlist sharing
- [ ] Advanced filtering and sorting

### API Integration
- [ ] Laravel backend integration
- [ ] Product catalog API
- [ ] User authentication API
- [ ] Cart and wishlist API
- [ ] Order management API
- [ ] Payment processing API

## 🛠️ Development

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent indentation (2 spaces)

### Testing
```bash
# Run unit tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Building
```bash
# Build APK
flutter build apk

# Build iOS
flutter build ios

# Build web
flutter build web
```

## 📄 License

This project is part of the ManuelThrifts e-commerce platform.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Support

For support and questions, please contact the development team.

---

**ManuelThrifts Flutter App** - Premium Thrift Fashion at Your Fingertips 🛍️


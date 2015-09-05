
// To check if a library is compiled with CocoaPods you
// can use the `COCOAPODS` macro definition which is
// defined in the xcconfigs so it is available in
// headers also when they are imported in the client
// project.


// Cartography
#define COCOAPODS_POD_AVAILABLE_Cartography
#define COCOAPODS_VERSION_MAJOR_Cartography 0
#define COCOAPODS_VERSION_MINOR_Cartography 5
#define COCOAPODS_VERSION_PATCH_Cartography 0

// JTHamburgerButton
#define COCOAPODS_POD_AVAILABLE_JTHamburgerButton
#define COCOAPODS_VERSION_MAJOR_JTHamburgerButton 1
#define COCOAPODS_VERSION_MINOR_JTHamburgerButton 0
#define COCOAPODS_VERSION_PATCH_JTHamburgerButton 5

// TZStackView
#define COCOAPODS_POD_AVAILABLE_TZStackView
#define COCOAPODS_VERSION_MAJOR_TZStackView 1
#define COCOAPODS_VERSION_MINOR_TZStackView 0
#define COCOAPODS_VERSION_PATCH_TZStackView 4

// pop
#define COCOAPODS_POD_AVAILABLE_pop
#define COCOAPODS_VERSION_MAJOR_pop 1
#define COCOAPODS_VERSION_MINOR_pop 0
#define COCOAPODS_VERSION_PATCH_pop 7

// Debug build configuration
#ifdef DEBUG

  // Reveal-iOS-SDK
  #define COCOAPODS_POD_AVAILABLE_Reveal_iOS_SDK
  #define COCOAPODS_VERSION_MAJOR_Reveal_iOS_SDK 1
  #define COCOAPODS_VERSION_MINOR_Reveal_iOS_SDK 5
  #define COCOAPODS_VERSION_PATCH_Reveal_iOS_SDK 1

#endif

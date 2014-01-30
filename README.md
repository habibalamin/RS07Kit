#RS07Kit
---
##A framework for building Old School Runescape applications
---

###Currently implemented
- RS07Hiscores
- RS07Prices (with Zybez 2007 Price Checker API)

###TODO
- RS07Bestiary
- RS07Calculators

###Installation

1. Drag the framework into your Xcode project.
2. Add ```@loader_path/../Frameworks``` to your target's "Runpath Search Paths" build settings
3. Add a "Copy Files" build phase to your project, change the "Destination" to "Frameworks" and drag RS07Kit.framework into the build phase.
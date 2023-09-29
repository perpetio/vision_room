# Vision Room

[![N|Solid](https://github.com/perpetio/vision_room/blob/main/Screenshots/cover.png)](https://github.com/perpetio/vision_room)

The Vision Room project is built for placing objects and interacting with them in your apartment using an Apple Vision Pro device.

## Features

- Furniture Library
- Furniture Selection/Placement/Rotation
- Show and manipulate multiple objects at the same time

## Tech Stack

- Swift 5.9
- SwiftUI
- VisionOS SDK
- RealityKit SDK

## Required Devices and Apps
- Mac computer with macOS Ventura or later
- Apple Vision Pro (or Vision Pro simulator)
- Xcode 15 or later

## iOS App

**Library**

The Library screen shows a list of categories (types of furniture) on the left side and related to the selected category of furniture on the right. All your selections are stored in the Recently Viewed category.

By selecting a specific item in the Library, the app starts loading USDZ model content to the memory to allow the user to manipulate it in the virtual space.

![]((https://github.com/perpetio/vision_room/blob/main/Screenshots/library-screen.png))
<img src="https://github.com/perpetio/vision_room/blob/main/Screenshots/library-screen.png" width="800" height="600">

**Object Placement and Rotation**

To move the object inside your room you need to tap and hold a specific object in the Library and walk in the direction where you want to place it. When you are ready, please take your finger off and the object will be placed at these coordinates.

By using the pinch operation, you can rotate the object as you wish like in the animated image below.

![]((https://github.com/perpetio/vision_room/blob/main/Screenshots/object-placement.gif))
<img src="https://github.com/perpetio/vision_room/blob/main/Screenshots/object-placement.gif" width="800" height="600">

**Visible Furniture**

The app also allows you to place multiple objects in your room at the same time. 

From this screen, you can change the position of the already visible objects, rotate them, and delete them from the virtual space if needed.

![]((https://github.com/perpetio/vision_room/blob/main/Screenshots/visible-furniture-screen.png))
<img src="https://github.com/perpetio/vision_room/blob/main/Screenshots/visible-furniture-screen.png" width="800" height="600">

## Installation

1. Download the repository
2. Open FurniturePlacementApp.xcodeproj file
3. Wait until all project dependencies are installed
4. Run the app on the simulator or real device
5. Enjoy it!

## License

MIT

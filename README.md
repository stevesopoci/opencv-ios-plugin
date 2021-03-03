# opencv-ios-plugin

`OpenCViOSPlugin` is an iOS static library written in Objective-C++ that detects and retrieves red laser coordinates via `opencv2.framework`, and it is intended to be used as a native plugin for the Unity project [LaserDetectionUnity](https://github.com/stevesopoci/laser-detection-unity).

<h2> Usage </h2>

1. Open `OpenCViOSPlugin` in Xcode and download the [OpenCV - 2.4.13 iOS pack](https://sourceforge.net/projects/opencvlibrary/files/opencv-ios/2.4.13/opencv2.framework.zip/download).
2. Drag and drop the downloaded `opencv2.framework` into the frameworks folder, and ensure the boxes for `Copy items if needed`, `Create groups`, and `OpenCViOSPlugin` are checked.
3. Build the project to `Any iOS Device (arm64)`.
4. Download and open the [LaserDetectionUnity](https://github.com/stevesopoci/laser-detection-unity) Unity project.
5. Drag and drop the output file `libOpenCViOSPlugin.a` into _**Assets > Plugins > iOS**_.
6. Click on the `libOpenCViOSPlugin.a` file in the Unity Editor and uncheck all of the platforms except for iOS.
7. Ensure the box for `Load on startup` is checked.
8. Build the project to the iOS platform and save the build in _**Builds > iOS**_.
9. Open the build in Xcode and repeat Step number 2 from above.
10. Add `AssetsLibrary.framework` to the frameworks folder.
11. Deploy to an iOS device to test.

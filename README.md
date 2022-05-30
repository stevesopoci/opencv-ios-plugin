# opencv-ios-plugin

`OpenCViOSPlugin` is an **iOS** static library written in Objective-C++ that detects and retrieves red laser pointer coordinates via **opencv2.framework**, and it is intended to be used as a native plugin for the Unity project [LaserDetectionUnity](https://github.com/stevesopoci/laser-detection-unity).

<h2> Setup </h2>

1. Clone and open `OpenCViOSPlugin` in **Xcode** and download the [OpenCV - 2.4.13 iOS pack](https://sourceforge.net/projects/opencvlibrary/files/opencv-ios/2.4.13/opencv2.framework.zip/download).
2. Drag and drop the downloaded **opencv2.framework** into the frameworks folder, and ensure the boxes for `Copy items if needed`, `Create groups`, and `OpenCViOSPlugin` are checked.
3. Follow the instructions found in the README.md of [LaserDetectionUnity](https://github.com/stevesopoci/laser-detection-unity).
4. Build the project to `Any iOS Device (arm64)`.
5. Drag and drop the output file **libOpenCViOSPlugin.a** into _**Assets > Plugins > iOS**_.
6. Select the **libOpenCViOSPlugin.a** file in the **Unity Editor** and uncheck all of the platforms except for **iOS**.
7. Ensure the box for `Load on startup` is checked.
8. In order to test the project on a physical **iOS** device, `Build` the project to the **iOS** platform and save the build in _**Builds > iOS**_.
9. Open the build in **Xcode** and repeat the second step above.
10. Add **AssetsLibrary.framework** to the frameworks folder.
11. Deploy to an **iOS** device to test.

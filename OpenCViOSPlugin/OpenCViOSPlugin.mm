//
//  OpenCViOSPlugin.mm
//  OpenCViOSPlugin
//
//  Created by Steve Sopoci on 12/8/20.
//

#import "OpenCViOSPlugin.h"

// Use the following lines to allow mixing of C++ with Objective-C code.
#include <stdlib.h>
using namespace std;
using namespace cv;

int laserCoordinateX;
int laserCoordinateY;

bool laserDetected;

CGRect screenBounds;
CGFloat screenScale;
CGSize screenSize;

static OpenCViOSPlugin *instance;

@interface OpenCViOSPlugin (){
    
    // Use OpenCV wrapper class to get camera access through AVFoundation.
    CvVideoCamera *videoCamera;
}
@end


@implementation OpenCViOSPlugin

+(void)load{
    
    instance = [[OpenCViOSPlugin alloc] init];
                [instance setUpCamera];
    
    laserDetected = false;

    NSLog(@"[Override on iOS load.]");
}

-(void)setUpCamera{
    
    videoCamera = [[CvVideoCamera alloc] init];
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    videoCamera.defaultFPS = 100;
    videoCamera.delegate = self;
    self->videoCamera.rotateVideo = YES;
    
    [videoCamera start];
}

- (void)processImage:(cv::Mat &)image;{
    
    // Scale the processed image to the size of the device's screen in order to pass accurate coordinates to Unity.
    screenBounds = [[UIScreen mainScreen] bounds];
    screenScale = [[UIScreen mainScreen] scale];
    screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    
    UIImage* tempImage = MatToUIImage(image);
    
    UIGraphicsBeginImageContext(screenSize);
    [tempImage drawInRect:CGRectMake(0,0,screenSize.width,screenSize.height)];
    tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageToMat(tempImage, image, false);
    
    // Convert frame from camera to HSV.
    Mat hsvImage;
    cvtColor(image, hsvImage, COLOR_BGR2HSV);

    // Threshold the HSV image and keep only the red pixels.
    Mat lowerRedHueRange;
    Mat upperRedHueRange;
    inRange(hsvImage, Scalar(0, 100, 100), Scalar(0, 255, 255), lowerRedHueRange);
    inRange(hsvImage, Scalar(150, 100, 100), Scalar(180, 255, 255), upperRedHueRange);

    // Combine the two threshold images.
    Mat redHueImage;
    addWeighted(lowerRedHueRange, 1.0, upperRedHueRange, 1.0, 0.0, redHueImage);

    // Smooth threshold image by reducing the noise.
    GaussianBlur(redHueImage, redHueImage, cv::Size(9, 9), 2, 2);
    dilate(redHueImage, redHueImage, 0);
    erode(redHueImage, redHueImage, 0);

    // Detect circles in the combined threshold image.
    vector<Vec3f> circles;
    HoughCircles(redHueImage, circles, CV_HOUGH_GRADIENT, 1, redHueImage.rows/8, 100, 20, 0, 0);

    // Loop over all detected circles and outline them on the original image.
    for(size_t current_circle = 0; current_circle < circles.size(); ++current_circle) {

        cv::Point center(round(circles[current_circle][0]), round(circles[current_circle][1]));

        int radius = round(circles[current_circle][2]);

        circle(image, center, radius, cv::Scalar(255, 0, 100), 5);

        laserCoordinateX = center.x;
        laserCoordinateY = screenSize.height - center.y;
        
        laserDetected = true;
    }
}
@end


// Export the folowing functions for use in Unity.
extern "C"
{
    int getCoordinateX(){
        return laserCoordinateX;
    }

    int getCoordinateY(){
        return laserCoordinateY;
    }

    bool didDetectLaser(){
        return laserDetected;
    }

    void resetDetectedLaser(){
        laserDetected = false;
    }
}

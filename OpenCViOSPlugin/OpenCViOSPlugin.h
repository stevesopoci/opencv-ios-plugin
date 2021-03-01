//
//  OpenCViOSPlugin.h
//  OpenCViOSPlugin
//
//  Created by Steve Sopoci on 12/8/20.
//

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#endif

@interface OpenCViOSPlugin : NSObject<CvVideoCameraDelegate>

@end

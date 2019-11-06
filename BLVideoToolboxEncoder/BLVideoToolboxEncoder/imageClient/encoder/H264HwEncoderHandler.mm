//
//  H264HwEncoderHandler.m
//  BLVideoToolboxEncoder
//
//  Created by luowailin on 2019/10/30.
//  Copyright © 2019 luowailin. All rights reserved.
//

#import "H264HwEncoderHandler.h"
#include <stdio.h>
#include <sys/time.h>
#include <math.h>

 
#define HEAD_NALU_SEI [NSData dataWithBytes:"\x06" length:1]
#define HEAD_NALU_I [NSData dataWithBytes:"\x25" length:1]

@implementation H264HwEncoderHandler
{
    NSFileHandle *fileHandle;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *mp4File = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"preview.h264"];
        //[[NSBundle mainBundle] pathForResource:@"preview"
                                                            //ofType:@"h264"];
        NSLog(@"%@", mp4File);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:mp4File
                                error:nil];
        if (![fileManager createFileAtPath:mp4File
                                 contents:nil
                               attributes:nil]) {
            NSLog(@"创建文件失败");
        }
        
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:mp4File];
    }
    return self;
}

#pragma mark -- H264HwEncoderImplDelegate

- (void)gotSpsPps:(NSData *)sps pps:(NSData *)pps timestramp:(Float64)miliseconds fromEncoder:(H264HwEncoderImpl *)encoder{
    const char bytesHeader[] = "\x00\x00\x00\x01";
    size_t headerLength = 4;
    size_t length = 2 * headerLength + sps.length + pps.length;
    unsigned char *bytesBuffer = new unsigned char[length];
    memcpy(bytesBuffer, bytesHeader, headerLength);
    memcpy(bytesBuffer + headerLength, (unsigned char *)[sps bytes], sps.length);
    memcpy(bytesBuffer + headerLength + sps.length, bytesHeader, headerLength);
    memcpy(bytesBuffer + headerLength * 2 + sps.length, (unsigned char *)[pps bytes], pps.length);
    NSData *bytesData = [NSData dataWithBytes:bytesBuffer length:length];
    [fileHandle writeData:bytesData];
    delete [] bytesBuffer;
}

- (void)gotEncodedData:(NSData *)data isKeyFrame:(BOOL)isKeyFrame timestramp:(Float64)miliseconds pts:(int64_t)pts dts:(int64_t)dts fromEncoder:(H264HwEncoderImpl *)encoder{
    const char bytesHeader[] = "\x00\x00\x00\x01";
    size_t headerLength = 4;
    size_t length = headerLength + data.length;
    unsigned char *bytesBuffer = new unsigned char[length];
    memcpy(bytesBuffer, bytesHeader, headerLength);
    memcpy(bytesBuffer + headerLength, (unsigned char *)[data bytes], data.length);
    NSData *bytesData = [NSData dataWithBytes:bytesBuffer length:length];
    [fileHandle writeData:bytesData];
    delete [] bytesBuffer;
}


- (void)dealloc{
    [fileHandle closeFile];
    fileHandle = NULL;
}


@end

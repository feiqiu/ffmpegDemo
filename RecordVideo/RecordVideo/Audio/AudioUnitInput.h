//
//  AudioInput.h
//  RecordVideo
//
//  Created by luowailin on 2019/11/14.
//  Copyright © 2019 luowailin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioUnitInput : NSObject

- (instancetype)initWithpath:(NSString *)path accompanyPath:(NSString *)accompanyPath;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END

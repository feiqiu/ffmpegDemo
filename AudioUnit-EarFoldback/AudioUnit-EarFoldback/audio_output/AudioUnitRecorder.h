//
//  AudioUnitRecorder.h
//  AudioUnit-EarFoldback
//
//  Created by luowailin on 2019/10/17.
//  Copyright © 2019 luowailin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioUnitRecorder : NSObject

- (instancetype)initWithPath:(NSString *)path;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END

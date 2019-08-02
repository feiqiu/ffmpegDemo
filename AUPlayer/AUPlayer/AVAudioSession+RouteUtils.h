//
//  AVAudioSession+RouteUtils.h
//  AUPlayer
//
//  Created by luowailin on 2019/8/2.
//  Copyright © 2019 luowailin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAudioSession (RouteUtils)

- (BOOL)usingBlueTooth;
- (BOOL)usingWiredMicrophone;
- (BOOL)shouldShowEarphoneAlert;

@end

NS_ASSUME_NONNULL_END

//
//  ParallaxManager.h
//  Cocos2dParallax
//
//  Created by Sauvik Dolui on 10/8/14.
//  Copyright 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxManager : CCNode {
    CGSize viewSize;
}

+(instancetype)sharedManager;
-(void) applyParallaxOnScreenSprite:(CCSprite*) sprite withDuration:(float) parallaxDuration;
-(void) applyParallaxOnLayer:(CCSprite*) layer withDuration:(float)parallaxDuration leftSize:(BOOL)leftSide;

@end

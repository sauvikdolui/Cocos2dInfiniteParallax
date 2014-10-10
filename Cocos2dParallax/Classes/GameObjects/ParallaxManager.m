//
//  ParallaxManager.m
//  Cocos2dParallax
//
//  Created by Sauvik Dolui on 10/8/14.
//  Copyright 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "ParallaxManager.h"


@implementation ParallaxManager

+(instancetype)sharedManager
{
    static ParallaxManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    
    return manager;
}

-(instancetype)init
{
    if (self = [super init]) {
        // Initialization Code
        viewSize = [CCDirector sharedDirector].viewSize;
    }
    
    return self;
}
-(void) applyParallaxOnScreenSprite:(CCSprite*) sprite withDuration:(float) parallaxDuration
{
    // Move and repositioning functions
    
    // 1. Initial move to the left edge of the window
    CCActionMoveBy *initialMove = [CCActionMoveBy actionWithDuration:parallaxDuration
                                                            position:ccp(-(sprite.contentSize.width/2 + sprite.position.x),0.0f)];
    
    // 2. Defining the complex parallax effect by two actions
    //      a. Repositioning the sprite at just outside of the right edge of the game scene after completing the initial move action.
    //      b. Repeatative execution of the sequence of these two following sub-actions
    //          i. Moving to the left side of the game window, so that the sprite is just out side of the screen.
    //         ii. Repositiong the sprite so that it comes just out side of the screen.
    
    CCActionCallBlock *parallaxEffectAction = [CCActionCallBlock actionWithBlock:^{
        
        // 2.a.
        // After completing the move to the left side edge of the window repositioning
        // sprite so that it is just out side the right edge of the screen
        sprite.position = ccp(viewSize.width + sprite.contentSize.width/2, sprite.position.y);
        
        // Calculating the speed of the sprite
        float pixelSpeed = (sprite.contentSize.width + sprite.position.x) / parallaxDuration;
        // 2.b.i.
        CCActionMoveBy *spriteMove = [CCActionMoveBy actionWithDuration:(viewSize.width + sprite.contentSize.width *2)/pixelSpeed
                                                               position:ccp(-(viewSize.width + sprite.contentSize.width),0.0f)];
        // 2.b.ii.
        CCActionCallBlock *repositionSprite = [CCActionCallBlock actionWithBlock:^{
            sprite.position = ccp(viewSize.width + sprite.contentSize.width / 2 , sprite.position.y);
        }];
        
        // Making sequence of actions 2.b.1. and 2.b.ii.
        CCActionSequence *moveAndReposition = [CCActionSequence actionOne:spriteMove two:repositionSprite];
        
        // Repeatative execution of the move and reposition actions
        [sprite runAction:[CCActionRepeatForever  actionWithAction:moveAndReposition]];
    }];
    
    // Execution of two primary actions 1. Initial move to the left side of the window and 2. Parallax action
    [sprite runAction:[CCActionSequence actionOne:initialMove two:parallaxEffectAction]];
}

-(void) applyParallaxOnLayer:(CCSprite*) layer withDuration:(float)parallaxDuration leftSize:(BOOL)leftSide
{
    CGPoint initialPosition = layer.position;
    
    float moveDistance = 0.0f;
    if (leftSide) {
        moveDistance = - (layer.contentSize.width - viewSize.width );
    }
    else{
        moveDistance = (layer.contentSize.width - viewSize.width);
    }
    
    // Move and repositioning function
    
    // 1. Move to the edge of the window
    CCActionMoveBy *move = [CCActionMoveBy actionWithDuration:parallaxDuration position:ccp(moveDistance ,0.0f)];
    
    // 2. Repositioning again preparing it for the next move
    CCActionCallBlock *reposition = [CCActionCallBlock actionWithBlock:^{
        layer.position = initialPosition;
    }];
    
    // Scequence of move and reposition actions
    CCActionSequence *moveAndReposition = [CCActionSequence actionOne:move two:reposition];
    
    // Repeatative execution of the move and reposition action
    [layer runAction:[CCActionRepeatForever  actionWithAction:moveAndReposition]];
}
@end

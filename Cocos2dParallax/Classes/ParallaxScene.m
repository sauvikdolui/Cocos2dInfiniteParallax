//
//  ParallaxScene.m
//  Cocos2dParallax
//
//  Created by Sauvik Dolui on 10/8/14.
//  Copyright 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "ParallaxScene.h"
#import "ParallaxManager.h"

#define Z_ORDER_SKY      (-5)
#define Z_ORDER_CLOUD    (-4)
#define Z_ORDER_MOUNTAIN (-3)
#define Z_ORDER_TREES    (-2)
#define Z_ORDER_GRASS    (-1)

@implementation ParallaxScene
+(CCScene*)scene{
    return [[self alloc]init];
}

-(instancetype)init{
    if (self = [super init]) {
        
        viewSize                         = [CCDirector sharedDirector].viewSize;

        // 1. Adding the sky as the scene background
        NSString *skyFileName            = @"sky";
        if (IS_IPHONE5) {
        skyFileName                      = [skyFileName stringByAppendingString:@"Wide"];
        }
        CCSprite *sky                    = [CCSprite spriteWithImageNamed:[skyFileName stringByAppendingString:@".png"]];
        sky.positionType                 = CCPositionTypeNormalized;
        sky.position                     = ccp(0.5,0.5);
        [self addChild:sky z:Z_ORDER_SKY];

        // Lets create the singleton parallax manager
        ParallaxManager *parallaxManager = [ParallaxManager sharedManager];

        // 2. Adding some clouds
        // Cloud 1
        CCSprite *cloud1                 = [CCSprite spriteWithImageNamed:@"cloud1.png"];
        cloud1.position                  = ccp(viewSize.width * 0.5f, viewSize.height * 0.85f); // Initial Position
        [self addChild:cloud1 z:Z_ORDER_CLOUD];

         // Cloud 2
        CCSprite *cloud2                 = [CCSprite spriteWithImageNamed:@"cloud2.png"];
        cloud2.position                  = ccp(viewSize.width * 0.2f, viewSize.height * 0.58f); // Initial Position
        [self addChild:cloud2 z:Z_ORDER_CLOUD];
        
         // Cloud 3
        CCSprite *cloud3                 = [CCSprite spriteWithImageNamed:@"cloud3.png"];
        cloud3.position                  = ccp(viewSize.width * 0.4f, viewSize.height * 0.75f); // Initial Position
        [self addChild:cloud3 z:Z_ORDER_CLOUD];
        
        // Lets try to add parallax efffect on the three clouds
        [parallaxManager applyParallaxOnScreenSprite:cloud1 withDuration:40.0]; // Applying parallax
        [parallaxManager applyParallaxOnScreenSprite:cloud2 withDuration:37.0]; // Applying parallax
        [parallaxManager applyParallaxOnScreenSprite:cloud3 withDuration:33.0]; // Applying parallax
        
        
        // Adding mountain
        CCSprite *mountain = [CCSprite spriteWithImageNamed:@"mountain.png"];
        mountain.anchorPoint = ccp(0.0f,0.0f);
        mountain.position = ccp(0.0,0.04 * viewSize.height); // Initial Position
        [parallaxManager applyParallaxOnLayer:mountain withDuration:130.0 leftSize:YES]; // Applying parallax
        [self addChild:mountain z:Z_ORDER_MOUNTAIN];

        // What about adding some avenue like trees with parallax effect?
        // 3. Trees
        CCSprite *trees   = [CCSprite spriteWithImageNamed:@"trees.png"];
        trees.anchorPoint = ccp(0.0,0.0f);
        trees.position    = ccp(0.0f,0.03 * viewSize.height); // Initial Position
        [parallaxManager applyParallaxOnLayer:trees withDuration:55.0 leftSize:YES]; // Applying parallax
        [self addChild:trees z:Z_ORDER_TREES];
        
        // Adding some grass layer
        CCSprite *grass   = [CCSprite spriteWithImageNamed:@"grass.png"];
        grass.anchorPoint = ccp(0.0,0.0f); // Initial Position
        grass.position    = ccp(0.0f,0.0f);
        [parallaxManager applyParallaxOnLayer:grass withDuration:30.0 leftSize:YES]; // Applying parallax
        [self addChild:grass z:Z_ORDER_GRASS];        
        
        
        
    }
    
    return self;
}
@end

//
//  TFAnimator.h
//  TFAnimator
//
//  Created by Cyril Le Pottier on 02/08/2014.
//  Copyright (c) 2014 Cyril Le Pottier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRTweenTimingFunctions.h"

// ------------------- //

typedef void(^TFAnimationBlock)(CGFloat normalizedValue);
typedef void(^TFCompletionBlock)();

// ------------------- //

@interface TFAnimator : NSObject

//
// @name Animation property
//

@property (nonatomic, readonly) TimingFunction timingFunction;
@property (nonatomic, readonly) double startTime;
@property (nonatomic, readonly) double duration;
@property (nonatomic, readonly, copy) TFAnimationBlock animationBlock;
@property (nonatomic, readonly, copy) TFCompletionBlock completionBlock;

@property (nonatomic, readonly) BOOL isAnimating;

//
// @name Object methods animation
//

/** Call the animationBlock every time the screen is redraw (many frames per second) with a normalized value as parameter.
 * The normalized value will go from 0 to 1 following the timing function and duration specifications.
 * Use this block to animate whatever you like.
 * @param function The timing function of the animation.
 * @param duration  The total duration of the animations, measured in seconds.
 * @param delay
 * @param animationBlock  A block object to be executed every time the screen is redraw (many frames per second). This block should use the input normalized value in order to perfom the animation. This parameter must not be NULL.
 * @param completionBlock  A block object to be executed when the animation sequence ends.
 */
- (void)animateWithTimingFunction:(TimingFunction)function duration:(double)duration delay:(double)delay animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock;

/** @see animateWithTimingFunction:duration:delay:animation:completion.
 * Animation performed without any delay.
 */
- (void)animateWithTimingFunction:(TimingFunction)function duration:(double)duration animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock;

/** Cancel the animation.
 */
- (void)stopAnimation;

//
// @name Class methods animation
//

/** @see animateWithTimingFunction:duration:delay:animation:completion.
 * The animation can't be cancelled.
 */
+ (void)animateWithTimingFunction:(TimingFunction)function duration:(double)duration delay:(double)delay animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock;

/** @see animateWithTimingFunction:duration:delay:animation:completion.
 * Animation performed without any delay.
 * The animation can't be cancelled.
 */
+ (void)animateWithTimingFunction:(TimingFunction)function duration:(double)duration animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock;

@end

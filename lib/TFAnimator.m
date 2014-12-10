//
//  TFAnimator.m
//  TFAnimator
//
//  Created by Cyril Le Pottier on 02/08/2014.
//  Copyright (c) 2014 Cyril Le Pottier. All rights reserved.
//

#import "TFAnimator.h"
#import <QuartzCore/QuartzCore.h>

// ------------------- //

#pragma mark -
#pragma mark TFAnimatorManager
#pragma mark -

/** TFAnimatorManager is a private singleton responsible of keeping the reference of the TFAnimator objects while they are still animating.
 * This singleton allow use to use TFAnimator with class methods.
 */
@interface TFAnimatorManager : NSObject

+ (TFAnimatorManager*)sharedManager;
- (void)addAnimator:(TFAnimator*)animator;

@property (nonatomic) NSMutableArray *animators;

@end

@implementation TFAnimatorManager

#pragma mark - Singleton

+ (TFAnimatorManager *)sharedManager
{
    static TFAnimatorManager *_manager;
    static dispatch_once_t _once;
    dispatch_once(&_once, ^{
        _manager = [[TFAnimatorManager alloc] initPrivate];
    });
    return _manager;
}

- (id)init
{
    return nil;
}

- (id)initPrivate
{
    self = [super init];
    if (self)
    {
        self.animators = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -  KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isAnimating"]) {
        TFAnimator *animator = (TFAnimator*)object;
        if (!animator.isAnimating) {
            [animator removeObserver:self forKeyPath:@"isAnimating"];
            [self.animators removeObject:animator];
        }
    }
}

#pragma mark -  Public

- (void)addAnimator:(TFAnimator *)animator
{
    if (animator)
    {
        [animator addObserver:self forKeyPath:@"isAnimating" options:NSKeyValueObservingOptionNew context:nil];
        [self.animators addObject:animator];
    }
}

@end

// ------------------- //

#pragma mark -
#pragma mark TFAnimator
#pragma mark -

@interface TFAnimator()

@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic, readwrite) BOOL isAnimating;

@end

// ------------------- //

@implementation TFAnimator

#pragma mark - Constructor method

- (void)dealloc
{
    if (_displayLink)
    {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}


- (id)init
{
    return [super init];
}


#pragma mark - Private

/** Fire the CADisplayLink if not already running.
 */
- (void)fireDisplayLink
{
    if (!_displayLink)
    {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkHandler)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [CATransaction commit];
    }
}

/**
 */
- (void)stopDisplayLink
{
    [_displayLink invalidate];
    _displayLink = nil;
}

/** Called every time the frame is redraw (See CADisplayLink Apple doc for more information).
 */
-(void) displayLinkHandler
{
    double currentTime = CACurrentMediaTime();
    if (currentTime >= _startTime)
    {
        if (!self.isAnimating) {
            self.isAnimating = YES;
        }
        
        if (currentTime <= _startTime + _duration)
        {
            //Animation through the block
            CGFloat normalizedPosition = _timingFunction(currentTime - _startTime, 0, 1, _duration);
            _animationBlock(normalizedPosition);
        }
        else
        {
            //Don't need to refresh the display anymore
            [self stopDisplayLink];
            
            _animationBlock(1.0);
            if (_completionBlock) {
                _completionBlock();
            }
            
            self.isAnimating = NO;
        }
    }
}

#pragma mark -  Public

- (void) animateWithTimingFunction:(TimingFunction)function duration:(double)duration delay:(double)delay animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock
{
    _timingFunction = function;
    _startTime = CACurrentMediaTime() + delay;
    _duration = duration;
    _animationBlock = animationBlock;
    _completionBlock = completionBlock;
    self.isAnimating = NO;
    
    [self fireDisplayLink];
}

- (void) animateWithTimingFunction:(TimingFunction)function duration:(double)duration animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock
{
    [self animateWithTimingFunction:function duration:duration delay:.0f animation:animationBlock completion:completionBlock];
}

- (void)stopAnimation
{
    if (_displayLink)
    {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

#pragma mark -  Public - static

+ (void)animateWithTimingFunction:(TimingFunction)function duration:(double)duration delay:(double)delay animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock
{
    TFAnimator *animator = [[TFAnimator alloc] init];
    [[TFAnimatorManager sharedManager] addAnimator:animator];
    [animator animateWithTimingFunction:function duration:duration delay:delay animation:animationBlock completion:completionBlock];
    
}

+ (void)animateWithTimingFunction:(TimingFunction)function duration:(double)duration animation:(TFAnimationBlock)animationBlock completion:(TFCompletionBlock)completionBlock
{
    [self animateWithTimingFunction:function duration:duration delay:0.0 animation:animationBlock completion:completionBlock];
}


@end

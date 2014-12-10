TFAnimator
===

TFAnimator, for Timing Function Animator, is a library allowing you to animate any UI component of your application using any Timing Function. 


Usage
===

Moving a view with an Elastic animation

```objective-c
    CGFloat xS = self.xSource;
    CGFloat yS = self.ySource;
    CGFloat wS = self.wSource;
    CGFloat hS = self.hSource;
    CGFloat xDelta = self.xFinal - self.xSource;
    CGFloat yDelta = self.yFinal - self.ySource;
    CGFloat wDelta = self.wFinal - self.wSource;
    CGFloat hDelta = self.hFinal - self.hSource
    [TFAnimator animateWithTimingFunction:PRTweenTimingFunctionElasticOut
                                 duration:05.f
                                animation:^(CGFloat normalizedValue) {
                                    CGFloat x = xS + xDelta*normalizedValue;
                                    CGFloat y = yS + yDelta*normalizedValue;
                                    CGFloat w = wS + wDelta*normalizedValue;
                                    CGFloat h = hS + hDelta*normalizedValue;
                                    view.frame = CGRectMake(x, y, w, h);
                                }
                               completion:nil];
```

Changing the colour within an animation:

```objective-c
CGFloat r = self.redSource;
CGFloat g = self.greenSource;
CGFloat b = self.blueSource;
CGFloat rDelta = (self.redFinal - self.redSource)/255.f;
CGFloat gDelta = (self.greenFinal - self.greenSource)/255.f;
CGFloat bDelta = (self.blueFinal - self.blueSource)/255.f;

[TFAnimator animateWithTimingFunction:PRTweenTimingFunctionLinear
                             duration:1.f
                            animation:^(CGFloat normalizedValue) {
                                    CGFloat newR = fmin(fmax(r+rDelta*normalizedValue, 0), 1);
                                    CGFloat newG = fmin(fmax(g+gDelta*normalizedValue, 0), 1);
                                    CGFloat newB = fmin(fmax(b+bDelta*normalizedValue, 0), 1);
                                    view.backgroundColor = [UIColor colorWithRed:newR green:newG blue:newB alpha:1.0f];
                                }
                           completion:nil];
```

Changing the Label text within an animation:

```objective-c
	double start = 0;
    double final = 100000000;
    
    [TFAnimator animateWithTimingFunction:PRTweenTimingFunctionExpoOut
                                 duration:.3f
                                animation:^(CGFloat normalizedValue) {
                                    double newValue = final*normalizedValue;
                                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                                    label.text = [NSString stringWithFormat:@"%.2f", newValue];
                                }
                               completion:^{}];
```

Check the example folder for more.

Dependency
===

TFAnimator does this amazing animations thanks to the PRTween Timing Functions.
PRTween is not only timing functions, this is also a library allowing you to perform animation.
Check out: https://github.com/domhofmann/PRTween/

License
===

BSD


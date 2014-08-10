/*
 * Copyright (c) 2014 Cyril Le Pottier.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by Cyril Le Pottier. The name of the
 * Cyril Le Pottuer may not be used to endorse or promote products derived
 * from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#import <Foundation/Foundation.h>
#import "PRTweenTimingFunctions.h"

@interface TFFunction : NSObject

//
// @name Time Function object properties
//

@property (nonatomic) TimingFunction timingFunction;
@property (nonatomic) NSString *title;

//
// @name Constructors
//

- (instancetype)initWithFunction:(TimingFunction)function title:(NSString*)title;

@end

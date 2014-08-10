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

#pragma mark - Log

static inline void CGRectLog(CGRect r)
{
    NSLog(@"{x:%f, y:%f, w:%f, h:%f}", r.origin.x, r.origin.y, r.size.width, r.size.height);
}

#pragma mark - Get

static inline CGPoint CGRectGetMidPoint(CGRect r)
{
    return CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));
}

#pragma mark - Set

static inline CGRect CGRectSetX(CGRect r, CGFloat x)
{
    return CGRectMake(x, r.origin.y, r.size.width, r.size.height);
}

static inline CGRect CGRectSetY(CGRect r, CGFloat y)
{
    return CGRectMake(r.origin.x, y, r.size.width, r.size.height);
}

static inline CGRect CGRectSetW(CGRect r, CGFloat w)
{
    return CGRectMake(r.origin.x, r.origin.y, w, r.size.height);
}

static inline CGRect CGRectSetH(CGRect r, CGFloat h)
{
    return CGRectMake(r.origin.x, r.origin.y, r.size.width, h);
}

static inline CGRect CGRectSetOrigin(CGRect r, CGPoint p)
{
    return CGRectMake(p.x, p.y, r.size.width, r.size.height);
}

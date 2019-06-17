//
//  MyView.h
//  Game of Life
//
//  Created by Hans van Riet on 5/8/14.
//  Copyright (c) 2014 Hans van Riet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GOLAppDelegate.h"



@interface MyView : NSView

-(void)paintBoard:(NSPoint)locationInView;

@end

//
//  MyView.m
//  Game of Life
//
//  Created by Hans van Riet on 5/8/14.
//  Copyright (c) 2014 Hans van Riet. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];

    return self;
}

#pragma mark - Mouse Event Methods

/*
 Override two of NSResponder's mouse handling methods to respond to the events we want.
 */

// Start drawing on mouse down.
- (void)mouseDown:(NSEvent *)event {
    
	// Convert from the window's coordinate system to this view's coordinates.
    NSPoint locationInView = [self convertPoint:event.locationInWindow fromView:nil];
    
    [self paintBoard:locationInView];
    
    [self setNeedsDisplay:YES];
}

// Draw points on mouse drag.
- (void)mouseDragged:(NSEvent *)event {
    
	// Convert from the window's coordinate system to this view's coordinates.
    NSPoint locationInView = [self convertPoint:event.locationInWindow
                                       fromView:nil];
    
    [self paintBoard:locationInView];
    
    [self setNeedsDisplay:YES];
}

#pragma mark - Paint methods

/*
 First fill the array with a 1 for white and a 0 for black
 Then draw the array to the View
 */

// Helper method to fill the array
-(void)paintBoard:(NSPoint)locationInView
{
     board[(int)locationInView.y / PIXSIZE][(int)locationInView.x / PIXSIZE] = 1;
    
}

// Helper method to do the actual drawing
- (void)drawRect:(NSRect)rect
{
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    
    // Draw game board
    for (int row = 0; row < ROWS; row++) {
        for (int col = 0; col < COLS; col++) {
            if (board[row][col] == 0)
            {
                CGContextSetRGBFillColor (myContext, 0, 0, 0, 1);
            }
            else
            {
                CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
            }
            CGContextFillRect (myContext, CGRectMake (col*PIXSIZE, row*PIXSIZE, PIXSIZE, PIXSIZE ));
        }
    }
    
    
}

@end

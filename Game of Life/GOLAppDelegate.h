//
//  GOLAppDelegate.h
//  Game of Life
//
//  Created by Hans van Riet on 5/8/14.
//  Copyright (c) 2014 Hans van Riet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define TIME_INTERVAL .1
#define WIDTH 800
#define HEIGHT 600
#define PIXSIZE 5
#define ROWS 140 // HEIGHT / PIXSIZE
#define COLS 160 // WIDTH / PIXSIZE
int board[ROWS][COLS];
int boardCopy[ROWS][COLS];
int lifes;
bool gameStarted;

@interface GOLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textField;

- (IBAction)startGame:(NSButton *)sender;
- (IBAction)stopGame:(NSButton *)sender;
- (IBAction)randomBoard:(NSButton *)sender;
- (IBAction)clearBoard:(NSButton *)sender;
- (void)updateLabel:(int)lifes;

@end

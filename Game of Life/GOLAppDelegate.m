//
//  GOLAppDelegate.m
//  Game of Life
//
//  Created by Hans van Riet on 5/8/14.
//  Copyright (c) 2014 Hans van Riet. All rights reserved.
//

#import "GOLAppDelegate.h"

@implementation GOLAppDelegate


#pragma mark - Standard Objective C Methods

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(void)awakeFromNib
{
    lifes = 0;
    gameStarted = FALSE;

    NSTimer *updateTimer __attribute__((unused)) = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERVAL
                                                                                    target:self
                                                                                  selector:@selector(updateBoard)
                                                                                  userInfo:nil
                                                                                   repeats:YES];
}

#pragma mark - Game Implementation

// Method with all the game logic
-(void)updateBoard
{
    int counter = 0;
    
    if (gameStarted) {
        
        // copy our game board
        memcpy(boardCopy, board, sizeof board);
        
        // Now apply our life rules with our copy as a guide
        for (int row = 0; row < ROWS; row++)
            {
            for (int col = 0; col < COLS; col++)
            {
                counter = 0;
                for (int i = row - 1 ; i < row + 2 ; i++)
                {
                    for (int j = col - 1; j < col + 2; j++)
                    {
                        if (!(i == row && j == col))
                        {
                           if (i >= 0 && i < ROWS && j >= 0 && j < COLS) counter +=  boardCopy[i][j];
                        }
                    }
                }
                switch (counter)
                {
                    case 2:
                        board[row][col] = boardCopy[row][col];
                        break;
                    case 3:
                        board[row][col] = 1;
                        break;
                    default:
                        board[row][col] = 0;
                        break;
                }
            }
        }
        lifes++;
        
        [self updateLabel:lifes];
        [[_window contentView] setNeedsDisplay:YES];
    }
}

// Generate Random Pattern
-(IBAction)randomBoard:(NSButton *)sender
{
    // Clear the board first
    [self clearBoard:NULL];
    
    int numRows = (rand() % (ROWS - 1)) + 1;
    int numCols = (rand() % (COLS - 1)) + 1;
    int startRow = (ROWS - numRows) / 2;
    int startCol = (COLS - numCols) / 2;
    
    // Initialize array with a random pattern
    for (int row = startRow ; row <startRow + numRows; row++)
    {
        for (int col = startCol ; col < startCol + numCols; col++)
        {
            board[row][col] = rand() % 2;
        }
    }
    gameStarted = TRUE;
    [[_window contentView] setNeedsDisplay:YES];
    
}

// Clear the game board
-(IBAction)clearBoard:(NSButton *)sender
{
    
    // Initialize array with a random pattern
    for (int row = 0; row < ROWS; row++)
    {
        for (int col = 0; col < COLS; col++)
        {
            board[row][col] = 0;
        }
    }
    gameStarted = FALSE;
    lifes = 0;
    [self updateLabel:lifes];
    [[_window contentView] setNeedsDisplay:YES];
}

// Update the lifes counter TextField
-(void)updateLabel:(int)lifes
{
    NSString *lifeString = [NSString stringWithFormat:@"Lifecycles: %d", lifes];
    NSDictionary *attributes = @{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:13]};
    NSSize labelSize = [lifeString sizeWithAttributes:attributes];
    labelSize.width += 6;
    [_textField setFrameSize:labelSize];
    [_textField setStringValue:lifeString];  
}

#pragma mark - Button Actions

// Start game.
- (IBAction)startGame:(NSButton *)sender
{
    gameStarted = TRUE;
}

// Stop game.
- (IBAction)stopGame:(NSButton *)sender
{
    gameStarted = FALSE;
}

@end

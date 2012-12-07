//
//  PrintingLayoutController.h
//  PrintingLayout
//
//  Created by Benoit Deville on 21.08.12.
//
//

#import <Cocoa/Cocoa.h>
#import "PLDocumentView.h"
#import "PLLayoutView.h"
#import "PLUtils.h"

@interface PLWindowController : NSWindowController
{
//    IBOutlet NSWindow *mainWindow;
//    IBOutlet NSToolbar *toolbar;
    
    IBOutlet NSPopUpButton *layoutChoiceButton;
//    IBOutlet NSButton *clearViewsButton;
//    IBOutlet NSMatrix *toolsMatrix;
//    IBOutlet NSToolbarItem *toolMatrix;
    
    IBOutlet NSTextField *widthTextField;
    IBOutlet NSTextField *heightTextField;
    IBOutlet NSStepper *widthValueAdjuster;
    IBOutlet NSStepper *heightValueAdjuster;
    NSUInteger heightValue;
    NSUInteger widthValue;
    
    IBOutlet NSScrollView *scrollView;
    IBOutlet PLDocumentView *fullDocumentView;
    paperSize scrollViewFormat;
    NSLayoutConstraint *ratioConstraint;
    int currentPage;
}

@property NSUInteger heightValue, widthValue;
@property paperSize scrollViewFormat;
@property int currentPage;

- (IBAction)addPage:(id)sender;
- (IBAction)updateViewRatio:(id)sender;
- (IBAction)updateGridLayoutFromButton:(id)sender;
- (IBAction)displayModeChanged:(id)sender;
- (IBAction)clearViewsInLayout:(id)sender;
- (IBAction)exportViewToDicom:(id)sender;
- (IBAction)changeTool:(id)sender;
- (IBAction)adjustLayoutWidth:(id)sender;
- (IBAction)adjustLayoutHeight:(id)sender;
- (void)updateHeight;
- (void)updateWidth;
- (void)layoutMatrixUpdated;
- (void)updateWindowTitle;
- (void)currentPageUpdated;

@end
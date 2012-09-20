//
//  WorklistsPreferencesController.m
//  Worklists
//
//  Created by Alessandro Volz on 09/11/2012.
//  Copyright 2012 OsiriX Team. All rights reserved.
//

#import "WorklistsPreferencesController.h"
#import "WorklistsPlugin.h"
#import "Worklist.h"


@interface WorklistsPreferencesController ()

- (void)adjustRefreshDelays;

@end


@implementation WorklistsPreferencesController

@synthesize worklistsTable = _worklistsTable;
@synthesize refreshButton = _refreshButton;
@synthesize autoretrieveButton = _autoretrieveButton;

- (void)awakeFromNib {
    [self.worklists addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionInitial context:[self class]];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if (context != [self class])
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    [self performSelector:@selector(adjustRefreshDelays) withObject:nil afterDelay:0.01]; // wait a moment to make sure the bindings affect the views...
}

- (void)dealloc {
    [self.worklists removeObserver:self forKeyPath:@"content"];
    [super dealloc];
}

- (NSArrayController*)worklists {
    return [[WorklistsPlugin instance] worklists];
}

+ (NSString*)stringWithUUID {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
}

- (IBAction)add:(id)caller {
    NSString* uid = [[self class] stringWithUUID];
    
    NSMutableDictionary* dic = [[[[self.worklists objectClass] alloc] init] autorelease];
    [dic setObject:uid forKey:WorklistIDKey];
    
    [self.worklists addObject:dic];
    
    [self.worklists setSelectedObjects:[NSArray arrayWithObject:dic]];
    [self.worklistsTable editColumn:0 row:[self.worklists.arrangedObjects indexOfObject:dic] withEvent:nil select:YES];
}

- (void)tableViewTextDidEndEditing:(NSNotification*)n {
    [self.worklists rearrangeObjects];
    [self.worklists didChangeValueForKey:@"content"];
}

- (void)tableViewSelectionDidChange:(NSNotification*)notification {
    [self performSelector:@selector(adjustRefreshDelays) withObject:nil afterDelay:0.01]; // wait a moment to make sure the bindings affect the views...
}

- (void)adjustRefreshDelays {
    NSInteger refresh = _refreshButton.selectedTag;

    if (_autoretrieveButton.selectedTag > refresh)
        [_autoretrieveButton selectItemWithTag:refresh];
    
    for (NSMenuItem* mi in _autoretrieveButton.itemArray)
        [mi setHidden:(mi.tag > refresh)];
}

@end

@interface WorklistsTableView : NSTableView

@end

@implementation WorklistsTableView

- (void)textDidEndEditing:(NSNotification*)n {
    [super textDidEndEditing:n];
    if ([self.delegate respondsToSelector:@selector(tableViewTextDidEndEditing:)])
        [self.delegate performSelector:@selector(tableViewTextDidEndEditing:) withObject:n];
}

@end
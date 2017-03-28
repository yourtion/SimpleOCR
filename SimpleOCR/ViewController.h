//
//  ViewController.h
//  SimpleOCR
//
//  Created by YourtionGuo on 20/03/2017.
//  Copyright © 2017 Yourtion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (unsafe_unretained) IBOutlet NSTextView *textV;
@property (weak) IBOutlet NSImageView *imageV;
@property (weak) IBOutlet NSTextField *infoL;
@end


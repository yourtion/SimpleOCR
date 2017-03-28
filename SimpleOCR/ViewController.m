//
//  ViewController.m
//  SimpleOCR
//
//  Created by YourtionGuo on 20/03/2017.
//  Copyright © 2017 Yourtion. All rights reserved.
//

#import "ViewController.h"
#include "Tesseract.h"

@implementation ViewController{
    Tesseract *_tesseract ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tesseract = [[Tesseract alloc] initWithLanguage:@"chi_sim"];
}

- (IBAction)paste:(id)sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSArray *classArray = [NSArray arrayWithObject:[NSImage class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
    if (ok) {
        NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
        NSImage *image = [objectsToPaste objectAtIndex:0];
        [self.imageV setImage:image];
    }
}

- (IBAction)run:(id)sender {
    NSDate *start = [NSDate new];
    [self.infoL setStringValue:@"Running..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        LeptonicaPix *pix = [[LeptonicaPix alloc] initWithNSImage:self.imageV.image];
        [_tesseract setImage:pix];
        NSString *ret = [_tesseract getUTF8Text];
        NSLog(@"%@", ret);
        NSTimeInterval time = [start timeIntervalSinceNow];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.textV setString:ret];
            [self.infoL setStringValue:[NSString stringWithFormat:@"Time: %.0f s", -time]];
        });
    });
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

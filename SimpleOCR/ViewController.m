//
//  ViewController.m
//  SimpleOCR
//
//  Created by YourtionGuo on 20/03/2017.
//  Copyright © 2017 Yourtion. All rights reserved.
//

#import "ViewController.h"
#include "Tesseract.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSImage *image = [NSImage imageNamed:@"9"];
    
    LeptonicaPix *pix = [[LeptonicaPix alloc] initWithNSImage:image];
    Tesseract *t = [[Tesseract alloc] initWithLanguage:@"chi_sim"];
    [t setImage:pix];
    NSString *ret = [t getUTF8Text];
    NSLog(@"%@", ret);

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

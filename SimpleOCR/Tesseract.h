//
//  Tesseract.h
//
//  Created by philopon on 2013/08/22.
//  Copyright (c) 2013年 philopon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "environ.h"
#include "pix.h"


@interface LeptonicaPix : NSObject

- (id)initWithNSImage:(NSImage*)image;
- (id)initWithFilePath:(NSString*)path;

@property PIX* pix;

@end

@interface Tesseract : NSObject

- (id)initWithLanguage:(NSString*)lang;

- (void)setImage:(LeptonicaPix*)img;
- (BOOL)setVariable:(NSString*)value forName:(NSString*)name;

- (void)clear;
- (NSString*)getUTF8Text;

@end

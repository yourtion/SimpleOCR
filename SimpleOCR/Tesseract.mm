//
//  Tesseract.mm
//
//  Created by philopon on 2013/08/22.
//  Copyright (c) 2013年 philopon. All rights reserved.
//

#import "Tesseract.h"

#include "baseapi.h"
#include "allheaders.h"

#define defaultLanguage = @"eng"

@implementation LeptonicaPix{
    l_uint32* _pixels;
}

- (id)initWithNSImage:(NSImage*)image{
    self = [super init];
    if(self){
        CGImageRef cg  = [image CGImageForProposedRect:NULL context:NULL hints:NULL];
        unsigned long width  = CGImageGetWidth (cg),
                      height = CGImageGetHeight (cg);
        
        _pixels = (l_uint32 *) malloc(width * height * sizeof(l_uint32));
        memset(_pixels, 0, width * height * sizeof(l_uint32));
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context =
        CGBitmapContextCreate(_pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                              kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), cg);

        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        
        self.pix = pixCreate(width, height,CGImageGetBitsPerPixel(cg));
        pixSetData(self.pix, _pixels);
    }
    return self;
}

- (id)initWithFilePath:(NSString*)path{
    self = [super init];
    if(self){
        self.pix = pixRead([path UTF8String]);
    }
    return self;
}

- (void)dealloc{
    free(_pixels);
}

@end

@implementation Tesseract{
    tesseract::TessBaseAPI* _tesseract;
    LeptonicaPix*           _pix;
}

- (id)initWithLanguage:(NSString*)lang{
    self = [super init];
    if(self){
        _tesseract = new tesseract::TessBaseAPI;
        if(_tesseract->Init(NULL, [lang UTF8String])){
            [NSException raise:@"IntializeException" format:@"TessBaseAPI initialize failed."];
        }
    }
    return self;
}

- (NSString*)getUTF8Text{
    char*     cstr = _tesseract->GetUTF8Text();
    NSString*  str = [NSString stringWithCString: cstr encoding:NSUTF8StringEncoding];
    delete [] cstr;
    return str;
}

- (void)setImage:(LeptonicaPix*)img{
    _tesseract->SetImage(img.pix);
    _pix = img;
}

- (void)clear{
    _tesseract->Clear();
    _pix = nil;
}

- (BOOL)setVariable:(NSString*)value forName:(NSString*)name{
    return _tesseract->SetVariable([name UTF8String], [value UTF8String]);
}

- (void)dealloc{
    _pix = nil;
    _tesseract->End();
}

@end

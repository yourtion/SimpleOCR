//
//  ViewController.m
//  SimpleOCR
//
//  Created by YourtionGuo on 20/03/2017.
//  Copyright © 2017 Yourtion. All rights reserved.
//

#import "ViewController.h"
#include "allheaders.h"
#include "capi.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    TessBaseAPI *handle;
    char *text;
    
    NSImage *image = [NSImage imageNamed:@"eng"];
    struct Pix *img = [self pixWithNSImage:image];
    
    handle = TessBaseAPICreate();
    if(TessBaseAPIInit3(handle, NULL, "eng") != 0)
        printf("Error initialising tesseract\n");
    
    TessBaseAPISetImage2(handle, img);
    
    if(TessBaseAPIRecognize(handle, NULL) != 0)
        printf("Error in Tesseract recognition\n");
    
    if((text = TessBaseAPIGetUTF8Text(handle)) == NULL)
        printf("Error getting text\n");
    
    fputs(text, stdout);
    
    TessDeleteText(text);
    TessBaseAPIEnd(handle);
    TessBaseAPIDelete(handle);
    pixDestroy(&img);

}

- (struct Pix *)pixWithNSImage:(NSImage*)image{
    CGImageRef cg  = [image CGImageForProposedRect:NULL context:NULL hints:NULL];
    int width  = (int)CGImageGetWidth (cg);
    int height = (int)CGImageGetHeight (cg);
        
    l_uint32* pixels = (l_uint32 *) malloc(width * height * sizeof(l_uint32));
    memset(pixels, 0, width * height * sizeof(l_uint32));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context =
    CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                              kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cg);
        
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
        
    struct Pix *img  = pixCreate(width, height, (int)CGImageGetBitsPerPixel(cg));
    pixSetData(img, pixels);
    return img;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

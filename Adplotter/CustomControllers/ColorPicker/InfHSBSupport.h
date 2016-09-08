
//  InfHSBSupport.h
//  Color SMS
//
//  Created by Alex on 2/9/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

float pin(float minValue, float value, float maxValue);


void HSVtoRGB(float h, float s, float v, float* r, float* g, float* b);

void RGBToHSV(float r, float g, float b, float* h, float* s, float* v,
              BOOL preserveHS);

//------------------------------------------------------------------------------

CGImageRef createSaturationBrightnessSquareContentImageWithHue(float hue);
	 typedef enum {
	InfComponentIndexHue = 0,
	InfComponentIndexSaturation = 1,
	InfComponentIndexBrightness = 2,
} InfComponentIndex;

CGImageRef createHSVBarContentImage(InfComponentIndex barComponentIndex, float hsv[3]);
	// Generates an image where the specified  -------------------------------------------------------------

//
//  UIColor+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "UIColor+SKSkinning.h"

@implementation UIColor (SKSkinning)

+ (UIColor *)colorWithDictionary:(NSDictionary *)dictionary {
    UIColor *color = nil;
    
    id rgb = [dictionary valueForKey:@"rgb"];
    id hsb = [dictionary valueForKey:@"hsb"];
    id hex = [dictionary valueForKey:@"hex"];
    id name = [dictionary valueForKey:@"name"];
    
    if (rgb) {
        if ([rgb isKindOfClass:[NSString class]]) {
            color = [self colorWithRGBString:rgb];
        }
        else {
            id r = [rgb objectForKey:@"r"];
            id g = [rgb objectForKey:@"g"];
            id b = [rgb objectForKey:@"b"];
            id a = [rgb objectForKey:@"a"];
            
            color = [UIColor colorWithRed:[r floatValue]
                                    green:[g floatValue]
                                     blue:[b floatValue]
                                    alpha:(a ? [a floatValue] : 1.0f)];
        }
    }
    else if (hsb) {
        if ([hsb isKindOfClass:[NSString class]]) {
            color = [self colorWithHSBString:hsb];
        }
        else {
            id h = [hsb objectForKey:@"h"];
            id s = [hsb objectForKey:@"s"];
            id b = [hsb objectForKey:@"b"];
            id a = [hsb objectForKey:@"a"];
            
            color = [UIColor colorWithHue:[h floatValue]
                               saturation:[s floatValue]
                               brightness:[b floatValue]
                                    alpha:(a ? [a floatValue] : 1.0f)];
        }
    }
    else if (hex) {
        color = [self colorWithHexString:hex];
    }
    else if (name) {
        color = [self colorWithName:name];
    }
    
    return color;
}

+ (UIColor *)colorWithRGBString:(NSString *)rgb {
    // trim
    rgb = [rgb stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *components = [rgb componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // TODO: DRY!
    if ([components count] == 3) {
        return [UIColor colorWithRed:[components[0] floatValue]
                               green:[components[1] floatValue]
                                blue:[components[2] floatValue]
                               alpha:1.0f];
    }
    else if ([components count] == 4) {
        return [UIColor colorWithRed:[components[0] floatValue]
                               green:[components[1] floatValue]
                                blue:[components[2] floatValue]
                               alpha:[components[3] floatValue]];
    }
    
    return nil;
}

+ (UIColor *)colorWithHSBString:(NSString *)hsb {
    // trim
    hsb = [hsb stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *components = [hsb componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // TODO: DRY!
    if ([components count] == 3) {
        return [UIColor colorWithHue:[components[0] floatValue]
                          saturation:[components[1] floatValue]
                          brightness:[components[2] floatValue]
                               alpha:1.0f];
    }
    else if ([components count] == 4) {
        return [UIColor colorWithHue:[components[0] floatValue]
                          saturation:[components[1] floatValue]
                          brightness:[components[2] floatValue]
                               alpha:[components[3] floatValue]];
    }
    
    return nil;
}

+ (UIColor *)colorWithHexString:(NSString *)hex {
    // trim and make lowercase
    hex = [hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hex = [hex lowercaseString];
    
    // remove leading #
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    
    // remove leading 0x
    if ([hex hasPrefix:@"0x"]) {
        hex = [hex substringFromIndex:2];
    }
    
    if ([hex length] == 3) {
        hex = [hex stringByAppendingString:@"f"];
    }
    
    if ([hex length] == 4) {
        NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
        NSString *a = [hex substringWithRange:NSMakeRange(3, 1)];
        
        hex = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",
               r, r,
               g, g,
               b, b,
               a, a];
    }
    
    if ([hex length] == 6) {
        hex = [hex stringByAppendingString:@"ff"];
    }
    
    NSUInteger value;
    [[NSScanner scannerWithString:hex] scanHexInt:&value];
    
    CGFloat red   = ((value >> 24) & 0xff) / 255.0f;
    CGFloat green = ((value >> 16) & 0xff) / 255.0f;
    CGFloat blue  = ((value >>  8) & 0xff) / 255.0f;
    CGFloat alpha = ((value >>  0) & 0xff) / 255.0f;
    
    return  [UIColor colorWithRed:red
                            green:green
                             blue:blue
                            alpha:alpha];
}

// TODO: dirty... - I know!
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (UIColor *)colorWithName:(NSString *)name {
    // trim and make lowercase
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    name = [name lowercaseString];
    
    SEL selector = NSSelectorFromString([name stringByAppendingString:@"Color"]);
    id colorClass = [UIColor class];
    
    if ([colorClass respondsToSelector:selector]) {
        return [colorClass performSelector:selector];
    }
    
    return nil;
}
#pragma clang diagnostic pop

- (UIColor *)lighterColor {
    CGFloat hue, saturation, brightness, alpha, white;
    
    UIColor *lighterColor = self;
    
    if ([self getHue:&hue
          saturation:&saturation
          brightness:&brightness
               alpha:&alpha]) {
        lighterColor = [UIColor colorWithHue:hue
                                  saturation:saturation * 0.5
                                  brightness:brightness
                                       alpha:alpha];
    }
    else if ([self getWhite:&white alpha:&alpha]) {
        lighterColor = [UIColor colorWithWhite:white * 1.5
                                         alpha:alpha];
    }
    else if ([self isEqual:[UIColor scrollViewTexturedBackgroundColor]]) {
        lighterColor = [UIColor underPageBackgroundColor];
    }
    
    return lighterColor;
}

- (UIColor *)darkerColor {
    CGFloat hue, saturation, brightness, alpha, white;
    
    UIColor *darkerColor = self;
    
    if ([self getHue:&hue
          saturation:&saturation
          brightness:&brightness
               alpha:&alpha]) {
        darkerColor = [UIColor colorWithHue:hue
                                  saturation:saturation
                                  brightness:brightness * 0.5
                                       alpha:alpha];
    }
    else if ([self getWhite:&white alpha:&alpha]) {
        darkerColor = [UIColor colorWithWhite:white * 0.5
                                        alpha:alpha];
    }
    else if ([self isEqual:[UIColor underPageBackgroundColor]]) {
        darkerColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    
    return darkerColor;
}

@end

//
//  WayToApi.m
//  currencies
//
//  Created by Шпщк on 08.07.17.
//  Copyright © 2017 ia. All rights reserved.
//

#import "WayToApi.h"

@implementation WayToApi

- (NSMutableArray*)WatchCurr:(NSString*)currFrom :(NSString*)currTo {
    NSString *url;
    url = [NSString stringWithFormat: @"https://v3.exchangerate-api.com/pair/c86c3beef60378c0fbc88606/%@/%@", currFrom, currTo];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *err;
    NSMutableArray *output = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];

    return output;
}

@end

//
//  Movie.m
//  MovieSearch
//
//  Created by Taylor Phillips on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithMovie:(NSString *)movieName overview:(NSString *)overview releaseDate:(NSString *)releaseDate rating:(double)rating {
    self = [super init];
    if (self) {
        _movieName = [movieName copy];
        _overview = [overview copy];
        _releaseDate = [releaseDate copy];
        _rating = rating;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString * movieName = dictionary[@"original_title"];
    NSString * overview = dictionary[@"overview"];
    NSString * releaseDate = dictionary[@"release_date"];
    double rating = [dictionary[@"vote_average"]doubleValue];
    
    if (![movieName isKindOfClass:[NSString class]] || ![overview isKindOfClass:[NSString class]] || ![releaseDate isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [self initWithMovie:movieName overview:overview releaseDate:releaseDate rating:rating];
}
@end

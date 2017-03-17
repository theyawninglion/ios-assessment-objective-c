//
//  Movie.h
//  MovieSearch
//
//  Created by Taylor Phillips on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, readonly, copy) NSString *movieName;
@property (nonatomic, readonly, copy) NSString *overview;
@property (nonatomic, readonly, copy) NSString *releaseDate;
@property (nonatomic, readonly) double rating;

- (instancetype)initWithDictionary:(NSDictionary<NSString*,id> *)dictionary;
- (instancetype)initWithMovie:(NSString *)movieName overview:(NSString *)overview releaseDate:(NSString *)releaseDate rating:(double)rating;

@end

//
//  MovieController.h
//  MovieSearch
//
//  Created by Taylor Phillips on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Movie;

@interface MovieController : NSObject
@property (nonatomic, copy) NSArray<Movie*> *moviesArray;
- (void)fetchMovieFromSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<Movie*>*))completion;

@end

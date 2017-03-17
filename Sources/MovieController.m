//
//  MovieController.m
//  MovieSearch
//
//  Created by Taylor Phillips on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "MovieController.h"
#import "Movie.h"
#import "MovieSearch-Swift.h"

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie?";
static NSString * const apiBase = @"api_key";
static NSString * const apiKey = @"66b0f042f063fbc3d55b879b592b32a0";

@interface MovieController ()
@property (nonatomic, strong) NSMutableArray *internalMovies;

@end

@implementation MovieController


-(instancetype)init {
    self = [super init];
    if (self) {
        _internalMovies = [NSMutableArray new];
    }
    return self;
}

- (void)fetchMovieFromSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<Movie *> *))completion {
    if (!completion) { completion = ^(NSArray *movies){};}
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:apiBase value:apiKey], [NSURLQueryItem queryItemWithName:@"query" value:[searchTerm lowercaseString]]];
    NSURL *searchURL = urlComponents.URL;
    
        [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data,
                                                                                     NSURLResponse * _Nullable response,
                                                                                     NSError * _Nullable error) {
            if (error){
                NSLog(@"Error: %@",error);
                completion(nil);
                return;
            }
            if (!data) {
                NSLog(@"Response: %@", response);
                completion(nil);
                return;
            }
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (!dictionary) {
                NSLog(@"Error fetching json: %@", error);
                completion(nil);
                return;
            }
            NSString *errorString = dictionary[@"error"];
            if (errorString) {
                NSLog(@"%@", errorString);
                completion(nil);
                return;
            }
            NSArray *resultsArray = dictionary[@"results"];
            
            for (NSDictionary *result in resultsArray) {
                Movie *movie = [[Movie alloc] initWithDictionary:result];
                [self.internalMovies addObject:movie];
            }
            self.moviesArray = self.internalMovies;
            completion(self.moviesArray);
        }] resume];
    
}
@end

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


@implementation MovieController

+ (void)fetchMovieFromSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<Movie *> *))completion {
    if (!completion) { completion = ^(NSArray *movies){};}
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:apiBase value:apiKey], [NSURLQueryItem queryItemWithName:@"query" value:[searchTerm lowercaseString]]];
    NSURL *searchedURL = urlComponents.URL;
    
    [NetworkController performRequestFor:searchedURL
                        httpMethodString:@"GET"
                           urlParameters:nil body:nil
                              completion:^(NSData *data, NSError *error) {
                                  if (error) {
                                      NSLog(@"Error getting movie for %@: %@", searchTerm, error);
                                      completion(nil);
                                      return;
                                  }
                                       NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                  
                                  NSMutableArray *moviesArray = dictionary[@"results"] ;
                                 
                                  NSArray *movies = [[Movie alloc]initWithDictionary:moviesArray];
//                                  .flatMap({ Movie(dictionary: $0) });
                                  
                                  if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
                                      NSLog(@"Error in fething json: %@", error );
                                      completion(nil);
                                      return;
                                  }
                                  
                                  Movie *movie = [[Movie alloc]initWithDictionary:dictionary];
                                  completion(movies);
                              }];
    
    
}

@end

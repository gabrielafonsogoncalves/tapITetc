//
//  PLConnection.h
//  TapIt
//
//  Created by Gabriel Afonso on 6/4/14.
//  Copyright (c) 2014 parallel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLConnection : NSObject <NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData *responseData;

- (void)sendScore:(NSInteger)score forUser:(NSString *)name;

@end

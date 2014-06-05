//
//  PLConnection.m
//  TapIt
//
//  Created by Gabriel Afonso on 6/4/14.
//  Copyright (c) 2014 parallel. All rights reserved.
//

#import "PLConnection.h"

@implementation PLConnection

#pragma mark NSURLConnection Delegate Methods

- (void)sendScore:(NSInteger)score forUser:(NSString *)name
{
    NSString *post =[NSString stringWithFormat:@"username=%@&score=%li", name, (long)score];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://clients.aragmedia.com/etcsrv/services/setNewScore"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Response!!!");
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
    NSString *str = [[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"data recived %@", str);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

}

@end

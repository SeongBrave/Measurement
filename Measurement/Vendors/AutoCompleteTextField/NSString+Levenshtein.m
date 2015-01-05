//
//  NSString+Levenshtein.m
//  uitextFieldTabV
//
//  Created by DTSoft on 15/1/5.
//  Copyright (c) 2015年 山西金仕达软件有限公司. All rights reserved.
//

#import "NSString+Levenshtein.h"

int smallestOf(int a, int b, int c);

@implementation NSString (Levenshtein)
- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB
{
    return [self asciiLevenshteinDistanceWithString:stringB
                               skippingCharacterSet:nil];
}


- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB skippingCharacterSet: (NSCharacterSet *)charset
{
    // try to convince caller that a nil object is *really* different from any string
    if (!stringB)
        return LEV_INF_DISTANCE;
    
    // strip chars from the requested charset (if any)
    
    NSString *stringA;
    if (charset) {
        stringA = [[self componentsSeparatedByCharactersInSet:charset] componentsJoinedByString:@""];
        stringB = [[stringB componentsSeparatedByCharactersInSet:charset] componentsJoinedByString:@""];
    } else {
        stringA = self;
    }
    
    // converting to ASCII to normalize characters with accents etc.
    // and also so we can use treat the string as an array of char *
    
    NSData *dataA = [stringA dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSData *dataB = [stringB dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    // not really cstrings, since not nul terminated
    const char *cstringA = [dataA bytes];
    const char *cstringB = [dataB bytes];
    
    // Calculate Levenshtein distance
    
    // Step 1
    int k, i, j, cost, * d, distance;
    
    NSUInteger n = [dataA length];
    NSUInteger m = [dataB length];
    
    if( n++ != 0 && m++ != 0 ) {
        
        d = malloc( sizeof(int) * m * n );
        
        // Step 2
        for( k = 0; k < n; k++)
            d[k] = k;
        
        for( k = 0; k < m; k++)
            d[ k * n ] = k;
        
        // Step 3 and 4
        for( i = 1; i < n; i++ )
            for( j = 1; j < m; j++ ) {
                
                // Step 5
                if( cstringA[i-1] == cstringB[j-1] )
                    cost = 0;
                else
                    cost = 1;
                
                // Step 6
                d[ j * n + i ] = smallestOf( d[ (j - 1) * n + i ] + 1,
                                            d[ j * n + i - 1 ] +  1,
                                            d[ (j - 1) * n + i -1 ] + cost );
            }
        
        distance = d[ n * m - 1 ];
        
        free( d );
        
        return distance;
    }
    return 0.0;
}

// return the minimum of a, b and c
int smallestOf(int a, int b, int c)
{
    int min = a;
    if ( b < min )
        min = b;
    
    if( c < min )
        min = c;
    
    return min;
}


@end

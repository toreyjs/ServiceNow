//
//  SOAPRequest.h
//  ServiceNow
//
//  Created by Developer on 8/5/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@protocol SOAPRequestDelegate <NSObject>
- (void)returnedSOAPResult:(TBXMLElement*)element;
//@optional
- (void)returnedSOAPError:(NSError *)error;
@end



@interface SOAPRequest : NSObject <NSXMLParserDelegate> {
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    NSString *methodName;
}
extern int NO_INTERNET_CODE;
@property (nonatomic, weak) id <SOAPRequestDelegate> delegate;
- (id)initWithDelegate:(id <SOAPRequestDelegate>) myDelegate;
- (void) sendSOAPRequestForMethod:(NSString*)methodName withParameters:(NSDictionary*)parameterArray;
@end
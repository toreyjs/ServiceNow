//
//  OpenTicketsTableViewController.h
//  ServiceNow
//
//  Created by Developer on 6/13/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "SOAPRequest.h"
@class Ticket;
@class Reachability;

@interface OpenTicketsTVC : PullRefreshTableViewController <SOAPRequestDelegate> {
    Ticket *selectedTicket;
    
    Reachability *reach;
}

@property (strong, nonatomic) Ticket *selectedTicket;
@property (nonatomic, retain) NSMutableArray *ticketsArray;
@property (nonatomic, retain) Reachability *reach;

@end

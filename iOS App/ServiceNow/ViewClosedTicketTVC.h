//
//  TicketViewController.h
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ticket;

@interface ViewClosedTicketTVC : UITableViewController {
    Ticket *ticket;
    NSMutableArray *sections;
}

@property (strong, nonatomic) Ticket *ticket;

@end

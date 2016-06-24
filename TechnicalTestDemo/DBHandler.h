//
//  DBHandler.h
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "UserData.h"



@interface DBHandler : NSObject {
    
}

@property(nonatomic,strong) NSMutableArray *arrUserdata;
+(id)sharedInstance;
-(NSManagedObjectContext*)managedObjectContext;
-(BOOL)saveUserData:(UserData*)userData;
-(NSArray*)fetchUserData;
-(BOOL)fetchSelectedUserData:(UserData*)userinformationObj;

@end

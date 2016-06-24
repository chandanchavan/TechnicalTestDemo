//
//  DBHandler.m
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import "DBHandler.h"
#import <UIKit/UIKit.h>
@implementation DBHandler

+(id)sharedInstance //Create shared instance of DBHandler
{
    static DBHandler *sharedInstance =nil;
    if(!sharedInstance)
    {
        sharedInstance=[[DBHandler alloc]init];
        
    }
    return sharedInstance;
}
-(NSManagedObjectContext*)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
-(BOOL)saveUserData:(UserData*)userData //Save user data into database
{
    NSManagedObjectContext *context = [self managedObjectContext];
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context];
    
    [newDevice setValue:userData.userDataName forKey:@"name"];
    [newDevice setValue:userData.userDataDOB forKey:@"dob"];
    [newDevice setValue:userData.userDataMobNo forKey:@"mobile_no"];
    [newDevice setValue:userData.userDataImage forKey:@"image"];
    [newDevice setValue:[NSNumber numberWithInt:userData.userDataUserId] forKey:@"userid"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}
-(NSMutableArray*)fetchUserData //Get user data from database
{
    _arrUserdata = [[NSMutableArray alloc] init];
     NSManagedObjectContext *context =[self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"UserInfo"];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error != nil) {
        
    }
    else {
        
        for (NSManagedObject *obj in results) {
            UserData *userData = [[UserData alloc] init];
            [userData setUserDataName:[obj valueForKey:@"name"]];
            [userData setUserDataDOB:[obj valueForKey:@"dob"]];
            [userData setUserDataMobNo:[obj valueForKey:@"mobile_no"]];
            [userData setUserDataImage:[obj valueForKey:@"image"]];
            [userData setUserDataUserId:[[obj valueForKey:@"userid"] intValue]];
            [_arrUserdata addObject:userData];
            userData = nil;
            
        }
    }
    return _arrUserdata;
}
-(BOOL)fetchSelectedUserData:(UserData*)userinformationObj //Get selected user data from database
{
    
    
    _arrUserdata = [[NSMutableArray alloc] init];
    NSManagedObjectContext *context =[self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:context]];
    request.predicate = [NSPredicate predicateWithFormat:@"userid == %d",userinformationObj.userDataUserId];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *objUserInfo = (NSManagedObject *)[results objectAtIndex:0];
    
    [objUserInfo setValue:userinformationObj.userDataName forKey:@"name"];
    [objUserInfo setValue:userinformationObj.userDataDOB forKey:@"dob"];
    [objUserInfo setValue:userinformationObj.userDataMobNo forKey:@"mobile_no"];
    [objUserInfo setValue:userinformationObj.userDataImage forKey:@"image"];
    
    NSError *saveError = nil;
    
    if (![objUserInfo.managedObjectContext save:&saveError]) {
        NSLog(@"Unable to save managed object context.");
        return NO;
    }
     return YES;
}
@end

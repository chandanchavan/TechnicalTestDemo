//
//  UserData.h
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property(nonatomic,strong)NSString * userDataName;
@property(nonatomic,strong)NSString * userDataDOB;
@property(nonatomic,strong)NSString * userDataMobNo;
@property(nonatomic,strong)NSData * userDataImage;
@property(nonatomic) int userDataUserId;

@end

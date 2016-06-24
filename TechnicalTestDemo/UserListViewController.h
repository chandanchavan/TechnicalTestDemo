//
//  UserListViewController.h
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "DBHandler.h"
#import "UserInfoTableViewCell.h"

@interface UserListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *userListTableView;
@property(nonatomic,strong)NSArray *arrUserInfo;

@end

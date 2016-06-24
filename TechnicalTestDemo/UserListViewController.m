//
//  UserListViewController.m
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import "UserListViewController.h"
#import "ViewController.h"

@interface UserListViewController ()
{
    NSIndexPath *index;
}
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    DBHandler *objDBHandler= [DBHandler sharedInstance];
    _arrUserInfo=[[NSArray alloc]initWithArray: objDBHandler.fetchUserData];
    [_userListTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableview Datasource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrUserInfo.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"userCellInfo";
    UserInfoTableViewCell *cell;
    if(!cell)
    {
        cell=[_userListTableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
    }
    UserData *userData=[_arrUserInfo objectAtIndex:indexPath.row];
    cell.userName.text =userData.userDataName;
    cell.userImgView.image=[UIImage imageWithData:userData.userDataImage];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserData *userData=[_arrUserInfo objectAtIndex:indexPath.row];
    ViewController*objViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    objViewController.userDataFromUserList = userData;
    [self.navigationController pushViewController:objViewController animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}


@end

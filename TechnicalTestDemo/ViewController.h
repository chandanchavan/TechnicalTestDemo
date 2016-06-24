//
//  ViewController.h
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBHandler.h"
#import "UserData.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImgView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblDOB;
@property (weak, nonatomic) IBOutlet UILabel *lblMobNo;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
@property (weak, nonatomic) IBOutlet UITextField *txtMobNo;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property(nonatomic,strong)UserData *userDataFromUserList;

- (IBAction)btnSubmitClicked:(id)sender;

@end


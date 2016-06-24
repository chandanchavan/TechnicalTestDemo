//
//  ViewController.m
//  TechnicalTestDemo
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import "ViewController.h"
#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'"
@interface ViewController ()
{
    UIImagePickerController *objImagePicker;
    UIPopoverPresentationController *presentationController;
    NSData*imageData;
    BOOL isImageSelected;
    UIDatePicker* picker;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    //  Do any additional setup after loading the view, typically from a nib.
    
    // Add gesture on image view to select the image from gallery /camera
    UITapGestureRecognizer *singleTap  =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [_profilePicImgView addGestureRecognizer:singleTap];
    
    
    if(_userDataFromUserList)
    {
        isImageSelected  =  YES;
        UserData *userData  =  _userDataFromUserList;
        _txtUserName.text = userData.userDataName;
        _txtDOB.text = userData.userDataDOB;
        _txtMobNo.text = userData.userDataMobNo;
        _profilePicImgView.image = [UIImage imageWithData:userData.userDataImage];
    }
    
}
-(void)configureView //configure the View
{
    _profilePicImgView.layer.cornerRadius = 50;
    _profilePicImgView.layer.borderWidth = 2;
    _profilePicImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _profilePicImgView.clipsToBounds = YES;
    
    _btnSubmit.layer.borderWidth = 1;
    _btnSubmit.layer.cornerRadius = 5;
    
    picker  =  [[UIDatePicker alloc] init];
    picker.autoresizingMask  =  UIViewAutoresizingFlexibleWidth;
    picker.datePickerMode  =  UIDatePickerModeDate;
    [picker addTarget:self action:@selector(DateChanged:) forControlEvents:UIControlEventValueChanged];
    [picker setMaximumDate:[NSDate date]];
    picker.backgroundColor  =  [UIColor whiteColor];
    _txtDOB.inputView = picker;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Methods
//Method for to store user information into database
- (IBAction)btnSubmitClicked:(id)sender {
    UserData *objUserData;
    if ([self validateAllFields]) {
        UserData *objUserData = [[UserData alloc]init];
        objUserData.userDataName  = _txtUserName.text;
        objUserData.userDataDOB  = _txtDOB.text;
        objUserData.userDataMobNo  =  _txtMobNo.text;
        objUserData.userDataImage = imageData;
        
        DBHandler*objDbHandler = [DBHandler sharedInstance];
        if (_userDataFromUserList) {
            objUserData.userDataUserId  =  _userDataFromUserList.userDataUserId;
            objUserData.userDataImage = _userDataFromUserList.userDataImage;
        } else {
            UserData *userData  =  [[objDbHandler fetchUserData] lastObject];
            if (userData.userDataUserId == 0) {
                objUserData.userDataUserId  =  1;
            } else {
                objUserData.userDataUserId  =  userData.userDataUserId+1;
            }
        }
        BOOL Sucess;
        if(_userDataFromUserList)
        {
            Sucess=[objDbHandler fetchSelectedUserData:objUserData];
        }
        else
        {
            Sucess =  [objDbHandler saveUserData:objUserData];
        }
        
        
        if(Sucess)
        {
            UIAlertController * validationAlertView =  [UIAlertController
                                                        alertControllerWithTitle:@"Success"
                                                        message:@"User information submitted successfully"
                                                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* btnOk  =  [UIAlertAction
                                      actionWithTitle:@"Ok"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [validationAlertView dismissViewControllerAnimated:YES completion:nil];
                                          [self.navigationController popViewControllerAnimated:YES];
                                          
                                      }];
            [validationAlertView addAction:btnOk];
            [self presentViewController:validationAlertView animated:YES completion:nil];
        }
        else
        {
            UIAlertController * validationAlertView =  [UIAlertController
                                                        alertControllerWithTitle:@"Error"
                                                        message:@"Failed to submit user information"
                                                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* btnOk  =  [UIAlertAction
                                      actionWithTitle:@"Ok"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [validationAlertView dismissViewControllerAnimated:YES completion:nil];
                                          
                                      }];
            [validationAlertView addAction:btnOk];
            [self presentViewController:validationAlertView animated:YES completion:nil];
        }
    }
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer {
    UIAlertController * view =    [UIAlertController
                                   alertControllerWithTitle:nil
                                   message:@"Select Profile pic from"
                                   preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* camera  =  [UIAlertAction
                               actionWithTitle:@"Camera"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [self openCamera];
                               }];
    UIAlertAction* gallary  =  [UIAlertAction
                                actionWithTitle:@"Gallery"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self selectPhotoFromGallery];
                                }];
    UIAlertAction* cancel  =  [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [view dismissViewControllerAnimated:YES completion:nil];
                               }];
    [view addAction:camera];
    [view addAction:gallary];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}
-(void)openCamera //Select the photo from Camera
{
    objImagePicker  =  [[UIImagePickerController alloc] init];objImagePicker.delegate  =  self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) { objImagePicker.sourceType  =  UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:objImagePicker animated:YES completion:NULL]; }
    else {
        UIAlertController * noCameraViewAlert =  [UIAlertController alertControllerWithTitle:@"Error" message:@"No Camera Preview Available" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* btnOk  =  [UIAlertAction
                                  actionWithTitle:@"Ok"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [noCameraViewAlert dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
        [noCameraViewAlert addAction:btnOk];
        [self presentViewController:noCameraViewAlert animated:YES completion:nil];
        
    }
    
}
-(void)selectPhotoFromGallery //Select the photo from Gallery
{
    objImagePicker =  [[UIImagePickerController alloc] init];
    objImagePicker.delegate  =  self;
    objImagePicker.sourceType  =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        [self presentViewController:objImagePicker animated:YES completion:nil];
    else {
        presentationController  =  [objImagePicker popoverPresentationController];
        presentationController.permittedArrowDirections  =  UIPopoverArrowDirectionAny;
        presentationController.sourceView  =  self.view;
    }
}
#pragma mark - ImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    _profilePicImgView.image  =  [info objectForKey:UIImagePickerControllerOriginalImage];
    imageData =  UIImagePNGRepresentation(_profilePicImgView.image);
    isImageSelected  =  YES;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)DateChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter  =  [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    //self.myLabel.text  =  [dateFormatter stringFromDate:[dueDatePickerView date]];
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
    _txtDOB.text = [dateFormatter stringFromDate:[sender date]];
}
#pragma mark Textfield Delegate Method

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _txtMobNo && textField.text.length >= 10) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    if(textField == _txtUserName)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        if (filtered.length == 0 || [filtered isEqualToString:@""] || filtered == nil)
        {
            return [string isEqualToString:filtered];
        }

    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_txtDOB)
    {
        [self DateChanged:picker];
    }
}


-(BOOL)validateAllFields //Validate all field on view
{
    NSString *tilteMessage;
    BOOL isValid  =  YES;
    
    if([_txtUserName.text isEqualToString:@""] && [_txtDOB.text isEqualToString:@"" ] && [_txtMobNo.text isEqualToString:@"" ]&& !isImageSelected)
    {
        tilteMessage = @"Please Enter the details.";
        isValid  =  NO;
    }
    else if ([_txtUserName.text isEqualToString:@""])
    {
        tilteMessage = @"Please Enter the username.";
        isValid  =  NO;
    }
    else if ([_txtDOB.text isEqualToString:@""])
    {
        tilteMessage = @"Please select the Date of birth.";
        isValid  =  NO;
    }
    else if ([_txtMobNo.text isEqualToString:@""])
    {
        tilteMessage = @"Please Enter the Mobile Number.";
        isValid  =  NO;
        
    }
    else if (_txtMobNo.text.length>10||_txtMobNo.text.length<10) {
        tilteMessage = @"Please Enter the correct Mobile Number.";
        isValid  =  NO;
    }
    else if (!isImageSelected)
    {
        tilteMessage = @"Please select the profile image.";
        isValid  =  NO;
    }
    if (!isValid) {
        UIAlertController * validationAlertView =  [UIAlertController
                                                    alertControllerWithTitle:@"Error"
                                                    message:tilteMessage
                                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* btnOk  =  [UIAlertAction
                                  actionWithTitle:@"Ok"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [validationAlertView dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
        [validationAlertView addAction:btnOk];
        [self presentViewController:validationAlertView animated:YES completion:nil];
    }
    
    return isValid;
}
@end

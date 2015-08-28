//
//  ViewController.m
//  BookmarkPGM
//
//  Created by Parames on 28/08/15.
//  Copyright (c) 2015 Softcraft Systems and Solutions Private Limited. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onFav:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"welcome1" forKey:@"selectedVasanam"];
    [defaults synchronize];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Bookmark"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Add to Favourites",nil];
    actionSheet.tag=11;
    [actionSheet showInView:self.view.window]; // self.view.window to avoid tab bar interference while touch
}

-(void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strSelectedVerse1 = [defaults objectForKey:@"selectedVasanam"];
    
    if (actionSheet.tag==11)
    {
        if (buttonIndex==0)//Add to Favourite
        {
            
            if([strSelectedVerse1 isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select a verse to share!"
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
            NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath = [[path objectAtIndex:0] stringByAppendingPathComponent:@"favourites1.plist"];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            NSMutableArray *arrFav;
            if (fileExists)
            {
                arrFav = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
            }
            else
            {
                arrFav = [[NSMutableArray alloc] init];
            }
            for(int i=0;i<[arrFav count];i++)
            {
                NSString *str = [arrFav objectAtIndex:i];
                if([str isEqualToString:strSelectedVerse1])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"The verse already exists!"
                                                                   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];//Already Exists
                    [alert show];
                    return;
                }
            }
            [arrFav addObject:strSelectedVerse1];
            [arrFav writeToFile:filePath atomically:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favourite" message:@"Added to favourites!"
                                                           delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];//Added to Favourites
            [alert show];
        }
    }
}
@end

//
//  ViewController.h
//  ColumbiaBarRatingMain
//
//  Created by Rahul Kapur on 9/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ExpandingCell.h"
#import "MBProgressHUD.h"




@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,  MBProgressHUDDelegate, ExpandingCellDelegate>

{
    MBProgressHUD *HUD;
    
    int selectedIndex;
    
    NSArray *totalBarListingFromParse;
    
    NSInteger tapCount;
    NSInteger tappedRow;
    
    NSIndexPath *indexPath1;
    
    NSTimer *tapTimer;
    
    ExpandingCell *cell;
    
    BOOL dataSync;
    BOOL attendingOnePoint;
    
    NSMutableArray *funRatingArray;
    NSMutableArray *strictnessRatingArray;
    NSMutableArray *girlGuyRatingArray;
    NSMutableArray *compositeRatingArray;
    NSMutableArray *titleArray;
    NSMutableArray *addressArray;
    NSMutableArray *numberGoingArray;
    
    float funRating;
    float strictnessRating;
    float girlGuyRating;


}

@property (nonatomic) BOOL doubleTapBoolean;

@property (strong, nonatomic) IBOutlet UINavigationBar *navigationControl;

@end

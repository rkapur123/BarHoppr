//
//  ExpandingCell.h
//  ColumbiaBarRatingMain
//
//  Created by Rahul Kapur on 9/6/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
#import "DLStarRatingControl.h"
#import <Parse/Parse.h>

@protocol ExpandingCellDelegate;

@interface ExpandingCell : UITableViewCell <EDStarRatingProtocol, DLStarRatingDelegate> {
    NSString *barName;
    NSString *fun;
    NSString *stricntness;
    NSString *girlGuy;

    
}

@property (nonatomic) NSNumber *funNumber;
@property (nonatomic) NSNumber *strictnessNumber;
@property (nonatomic) NSNumber *girlGuyNumber;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *goingLabel;
@property (strong, nonatomic) IBOutlet EDStarRating *totalRating;
@property (strong, nonatomic) IBOutlet DLStarRatingControl *beerRating;
@property (strong, nonatomic) IBOutlet UILabel *funRatingLabel;
@property (strong, nonatomic) IBOutlet DLStarRatingControl *strictnessRating;
@property (strong, nonatomic) IBOutlet UILabel *strictnessLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButtom;
@property (strong, nonatomic) IBOutlet UILabel *girlGuyLabel;
- (IBAction)buttonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet DLStarRatingControl *girlGuyRating;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (assign,nonatomic) IBOutlet id<ExpandingCellDelegate> delegate;

@end

@protocol ExpandingCellDelegate
-(void)attendingRatings:(ExpandingCell *)cell :(NSNumber *)funNumber :(NSNumber *)strictnessNumber :(NSNumber *)girlGuyNumber :(NSString *)barName;
@end





//
//  ExpandingCell.m
//  ColumbiaBarRatingMain
//
//  Created by Rahul Kapur on 9/6/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import "ExpandingCell.h"
#import "EDStarRating.h"
#import "DLStarRatingControl.h"
#import <Parse/Parse.h>




@implementation ExpandingCell
@synthesize totalRating, titleLabel, beerRating, strictnessRating, girlGuyRating, submitButtom, backgroundView, delegate, funNumber, strictnessNumber, girlGuyNumber;

-(void)layoutSubviews
{
    
    submitButtom.backgroundColor = [UIColor colorWithRed:0.894 green:0.157 blue:0.486 alpha:1] ;
    submitButtom.userInteractionEnabled = YES;
    
    backgroundView.backgroundColor = [UIColor colorWithRed:0.412 green:0.176 blue:0.675 alpha:1];
    
    totalRating.halfSize = NO;
    totalRating.backgroundColor  = [UIColor clearColor];
    totalRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    totalRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    totalRating.maxRating = 5.0;
    totalRating.delegate = self;
    totalRating.horizontalMargin = 10;
    totalRating.editable=NO;
    totalRating.displayMode=EDStarRatingDisplayHalf;
    [totalRating  setNeedsDisplay];
    totalRating.tintColor =  [UIColor yellowColor];
    
    
    beerRating = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 154, 320, 153) andStars:5 isFractional:YES theTag:@"beerRating"];
    beerRating.isFractionalRatingEnabled = YES;
    beerRating.delegate = self;
	beerRating.backgroundColor = [UIColor clearColor];
	beerRating.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	//beerRating.rating = 2.5;
    beerRating.backgroundColor = [UIColor clearColor];
    
    
    strictnessRating = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 154, 320, 153) andStars:5 isFractional:YES theTag:@"strictnessRating"];
    strictnessRating.isFractionalRatingEnabled = YES;
   strictnessRating.delegate = self;
	strictnessRating.backgroundColor = [UIColor clearColor];
	strictnessRating.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	//strictnessRating.rating = 2.5;
    strictnessRating.backgroundColor = [UIColor clearColor];
    NSLog(@"Cell created");

    
    
    girlGuyRating = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 154, 320, 153) andStars:5 isFractional:YES theTag:@"girlGuyRating"];
    girlGuyRating.isFractionalRatingEnabled = YES;
    girlGuyRating.delegate = self;
	girlGuyRating.backgroundColor = [UIColor clearColor];
	girlGuyRating.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	//girlGuyRating.rating = 2.5;
    girlGuyRating.backgroundColor = [UIColor clearColor];

    
    UIView* horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 330, 1)];
    UIView* horizontalLineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 84, 330, 1)];
    

    horizontalLineView.backgroundColor = [UIColor whiteColor];
    horizontalLineView2.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:horizontalLineView];
    [self.contentView addSubview:horizontalLineView2];
    
    girlGuyNumber = [NSNumber numberWithInt:-1];
    strictnessNumber = [NSNumber numberWithInt:-1];
    funNumber = [NSNumber numberWithInt:-1];
    
    
   

    

}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)newRating:(DLStarRatingControl *)control :(float)rating :(NSString *) tag{
    NSLog(@"Hello");
    
    switch ([control tag]) {
        case 1:
            funNumber =  [NSNumber numberWithFloat: rating];
            NSLog(@"%@", funNumber);

            break;
            
        case 2:
            strictnessNumber = [NSNumber numberWithFloat: rating];


            break;
            
        case 3:
            
            girlGuyNumber = [NSNumber numberWithFloat: rating];


            break;
    }
   

    

}


- (IBAction)buttonClicked:(id)sender {
    
    [self.delegate attendingRatings:self :funNumber :strictnessNumber :girlGuyNumber :titleLabel.text];
    
}
@end

//
//  ViewController.m
//  ColumbiaBarRatingMain
//
//  Created by Rahul Kapur on 9/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "ExpandingCell.h"
#import "MBProgressHUD.h"



@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{


    dataSync = NO;
    attendingOnePoint = NO;
    _navigationControl.barTintColor = [UIColor yellowColor];
    
    
    self.title = @"BarHoppr";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.412 green:0.176 blue:0.675 alpha:1];
    self.view.backgroundColor = [UIColor yellowColor];
    self.tableView.hidden = YES;
    
    
    tapCount =0;
    selectedIndex = -1;
    
    titleArray = [[NSMutableArray alloc] init];
    addressArray = [[NSMutableArray alloc] init];
    numberGoingArray = [[NSMutableArray alloc] initWithObjects:@"31 People Going", @"43 People Going", @"18 People Going", @"7 People Going", @"6 People Going", @"17 people going", nil];
    compositeRatingArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], nil];
    funRatingArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], nil];
    strictnessRatingArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], nil];
    girlGuyRatingArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], [NSNumber numberWithInt:(0)], nil];
    self.doubleTapBoolean = NO;
    
    [self retrieveFromParse];
    [super viewDidLoad];
    
    
    
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}

-(void) retrieveFromParse {
    
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];

    PFQuery *paidBarQuery = [PFQuery queryWithClassName:@"Bars"];
    NSArray *paidBarsArray = [paidBarQuery findObjects];
    for (PFObject *object in paidBarsArray) {
        NSString *paidBarName = [object objectForKey:@"Bar"];
        NSString *paidAddress = [object objectForKey:@"Address"];
        [titleArray addObject:paidBarName];
        [addressArray addObject:paidAddress];
    }
    PFQuery *addedBarQuery = [PFQuery queryWithClassName:@"UserBars"];
    NSDate *oneDay = [NSDate dateWithTimeIntervalSinceNow:-86400];
    [addedBarQuery whereKey:@"createdAt" lessThan:oneDay];
    NSArray *addedBarsArray = [paidBarQuery findObjects];
    for (PFObject *object in addedBarsArray) {
        NSString *addedBarName = [object objectForKey:@"Bar"];
        NSString *addedAddress = [object objectForKey:@"Address"];
        [titleArray addObject:addedBarName];
        [addressArray addObject:addedAddress];
    }
    
    
    
    
    PFQuery *mainQuery = [PFQuery queryWithClassName:@"Rating"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-172800];
    [mainQuery whereKey:@"createdAt" lessThan:date];

    [mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        /*if (!error) {
            totalBarListingFromParse = [[NSArray alloc] initWithArray:objects];
            for (PFObject *object in objects) {
                NSString *barname = [object objectForKey:@"Bar"];
                int barPaidChecker = 0;
                for (int i = 0; i < [titleArray count]; i++) {
                    NSString *stringToCheck = (NSString *)[titleArray objectAtIndex:i];
                    if([stringToCheck isEqualToString:barname]) {
                        barPaidChecker = 1;
                    }
                }
                if (barPaidChecker == 0) {
                    [titleArray addObject:barname];
                }
            }
        } */
        
        int ratingCounter = 0;
        for (NSString *string in titleArray) {
            [mainQuery whereKey:@"Bar" equalTo:string];
            NSArray* compositeScoreArray = [mainQuery findObjects];
            if ([compositeScoreArray count] != 0) {
                int size = (int) [compositeScoreArray count];
                float funSum = 0;
                float strictnessSum = 0;
                float girlGuySum = 0;
                float sum = 0;
                float mainSum = 0;
                for(PFObject *objects in compositeScoreArray) {
                    NSNumber *funNumber = [objects objectForKey:@"Fun"];
                    NSNumber *strictnessNumber = [objects objectForKey:@"Strictness"];
                    NSNumber *girlGuyNumber = [objects objectForKey:@"GirGuy"];
                    sum = ((funNumber.floatValue) * 0.5) + ((strictnessNumber.floatValue)* 0.25) + ((girlGuyNumber.floatValue)* 0.25);
                    mainSum = sum + mainSum;
                    funSum = funNumber.floatValue + funSum;
                    strictnessSum = strictnessNumber.floatValue + strictnessSum;
                    girlGuySum = girlGuyNumber.floatValue + girlGuySum;
                }
                float finalRating = mainSum/size;
                finalRating = round(finalRating * 2.0) / 2.0;
                float finalFunRating = funSum/size;
                int finalFun = (finalFunRating + 0.5);
                float finalStrictnessRating = strictnessSum/size;
                int finalStrictness = (finalStrictnessRating + 0.5);
                float finalGirGuyRating = girlGuySum/size;
                int finalGirlGuy = (finalGirGuyRating + 0.5);
                
                [compositeRatingArray replaceObjectAtIndex:ratingCounter withObject:[NSNumber numberWithFloat:finalRating]];
                [funRatingArray replaceObjectAtIndex:ratingCounter withObject:[NSNumber numberWithInt:finalFun]];
                [girlGuyRatingArray replaceObjectAtIndex:ratingCounter withObject:[NSNumber numberWithInt:finalStrictness]];
                [strictnessRatingArray replaceObjectAtIndex:ratingCounter withObject:[NSNumber numberWithInt:finalGirlGuy]];
                
            }
            ratingCounter++;
        }
        
        
        
        self.tableView.hidden = NO;
        dataSync = YES;
        [HUD hide:YES];
        [self.tableView reloadData];
    }];
    
    }
    
    


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"expandingCell";
    
    cell = (ExpandingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
   // if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpandingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
  //  }
    
    
    
    
    NSString *going = @"50 people going";
    cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1] ;

    
    if (selectedIndex == indexPath.row) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.addressLabel.textColor = [UIColor whiteColor];
        cell.funRatingLabel.textColor = [UIColor whiteColor];
        NSNumber *funRating1 = [funRatingArray objectAtIndex:indexPath.row];
        NSNumber *strictnessRating1 = [strictnessRatingArray objectAtIndex:indexPath.row];
        NSNumber *girlGuyRating1 = [girlGuyRatingArray objectAtIndex:indexPath.row];
        cell.beerRating.rating = [funRating1 intValue];
        cell.strictnessRating.rating = [strictnessRating1 intValue];
        cell.girlGuyRating.rating = [girlGuyRating1 intValue];
        
       
        
        
        
    }
    
    else {
        //cell.contentView.backgroundColor = [UIColor colorWithRed:0.353 green:0.831 blue:0.153 alpha:1];
        //cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:0.286 blue:0.506 alpha:1];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.addressLabel.textColor = [UIColor clearColor];
        



    }
    
    
    
    if(dataSync) {
        NSNumber *totalRating1 = [compositeRatingArray objectAtIndex:indexPath.row];

        NSLog(@"%d",(int) [compositeRatingArray count]);

        cell.totalRating.rating = [totalRating1 floatValue];
        
    }
    
    cell.titleLabel.font = [UIFont fontWithName:@"Arial" size:25];


    
    cell.goingLabel.text = going;
    cell.funRatingLabel.textColor = [UIColor whiteColor] ;
    cell.goingLabel.textColor = [UIColor whiteColor];
    cell.strictnessLabel.textColor = [UIColor whiteColor] ;
    cell.girlGuyLabel.textColor = [UIColor whiteColor];
    cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.addressLabel.text = [addressArray objectAtIndex:indexPath.row];
    NSLog(@"%@", (NSString *) [addressArray objectAtIndex:indexPath.row]);
    cell.goingLabel.text = [numberGoingArray objectAtIndex:indexPath.row];
    
    funRating = cell.beerRating.rating;
    strictnessRating = cell.strictnessRating.rating;
    girlGuyRating = cell.girlGuyRating.rating;
    
    cell.submitButtom.tag = indexPath.row;

    
    cell.clipsToBounds =YES;
    cell.delegate = self;
    
    return cell;
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == indexPath.row){
        return 239;
    }
    else {
        return 82;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexPath1 = indexPath;

    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        return;
    }
    
    if (selectedIndex != -1) {
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = (int)indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    selectedIndex = (int)indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



-(void)attendingRatings:(ExpandingCell *)cell :(NSNumber *)funNumber :(NSNumber *)strictnessNumber :(NSNumber *)girlGuyNumber :(NSString *)barName{
    
    if (funNumber.intValue == -1 || strictnessNumber.intValue == -1 || girlGuyNumber.intValue == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"To Attend!" message:@"You must rate all categories first!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    } else {
        
        PFObject *Rating = [PFObject objectWithClassName:@"Rating"];
        [Rating setObject:barName forKey:@"Bar"];
        [Rating setObject:funNumber forKey:@"Fun"];
        [Rating setObject:strictnessNumber forKey:@"Strictness"];
        [Rating setObject:girlGuyNumber forKey:@"GirGuy"];
        
        
        [Rating saveInBackground];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"+ 1 Point" message:@"You are attending!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        if (selectedIndex == indexPath1.row) {
            selectedIndex = -1;
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationAutomatic];
            return;
        }
        
        if (selectedIndex != -1) {
            NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            selectedIndex = (int)indexPath1.row;
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        selectedIndex = (int) indexPath1.row;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        attendingOnePoint = YES;
        
        
        
        
    }
    
    

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

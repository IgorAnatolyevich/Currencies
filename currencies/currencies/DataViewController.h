//
//  DataViewController.h
//  currencies
//
//  Created by Шпщк on 08.07.17.
//  Copyright © 2017 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayToApi.h"
#import "Multiply.h"

@interface DataViewController : UIViewController {

    IBOutlet UILabel *output;
    NSInteger operation;
    double usersNum;
    double returning;
    
    NSString *from;
    NSString *to;

}

- (IBAction)clearAll:(id)sender;
- (IBAction)running:(id)sender;

- (IBAction)chooseFrom:(id)sender;
- (IBAction)chooseTo:(id)sender;

- (IBAction)copy:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;


@end


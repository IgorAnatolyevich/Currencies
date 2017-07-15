//
//  DataViewController.m
//  currencies
//
//  Created by Шпщк on 08.07.17.
//  Copyright © 2017 ia. All rights reserved.
//

#import "DataViewController.h"


@interface DataViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap];
}

- (void)handleEndEditing {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}


- (IBAction)clearAll:(id)sender {
    operation = [sender tag];
    if (operation == 0) {
        from = @"";
        to = @"";
        output.text = @"cleaned!";
    }
}


- (IBAction)running:(id)sender {
    operation = [sender tag];
    
    if (operation == 1) {
        if (![from  isEqual: @""] && ![to  isEqual: @""]) {
            WayToApi *api = [[WayToApi alloc] init];
            NSMutableArray *resultFromApi = [api WatchCurr:from:to];
        
            NSString *result = [resultFromApi description];
            NSArray *mod = [result componentsSeparatedByString: @";\n"];
            NSString *rate = [mod objectAtIndex: 1];
            output.lineBreakMode = NSLineBreakByWordWrapping;
            output.numberOfLines = 2;
            if ([from  isEqual: to]) {
                output.text = @"please choose different currencies!";
            } else {
                rate = [rate stringByReplacingOccurrencesOfString:@"rate =" withString:@""];
                rate = [rate stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                double doubleRate = [rate doubleValue];
                Multiply *mult = [[Multiply alloc] init];
                returning = [mult Multiply:doubleRate :usersNum];
                NSLog(@"result %.2f", returning);
                
                output.text = [NSString stringWithFormat:@"from %@ to %@ \n %.2f", from, to, returning];
            }
        } else {
            output.text = @"please choose something!";
        }
    }
}


- (IBAction)chooseFrom:(id)sender {
    
    operation = [sender tag];
    
    if (operation == 10) {
        from = @"RUB";
    } else if (operation == 20) {
        from = @"EUR";
    } else if (operation == 30) {
        from = @"USD";
    }
    
}

- (IBAction)chooseTo:(id)sender {
    
    operation = [sender tag];
    
    if (operation == 11) {
        to = @"RUB";
    } else if (operation == 12) {
        to = @"EUR";
    } else if (operation == 13) {
        to = @"USD";
    }
}

- (IBAction)copy:(id)sender {
    
    operation = [sender tag];
    if (operation == 100) {

        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        NSLog(@"returning %f", returning);
        if (returning != 0) {
            pboard.string = [NSString stringWithFormat:@"%.2f", returning];
        } else {
            output.text = @"nothing to copy";
        }
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.textField]) {
        [self.textField resignFirstResponder];
        
        NSCharacterSet *characters = [[NSCharacterSet characterSetWithCharactersInString: @"1234567890."] invertedSet];
        NSString *filteredString = [[textField.text componentsSeparatedByCharactersInSet:characters] componentsJoinedByString: @""];
        
        usersNum = [filteredString doubleValue];
        NSLog(@"filterstring %f", usersNum);
    }
    return YES;
}

@end
    
    
    
    
    

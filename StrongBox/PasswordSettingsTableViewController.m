//
//  PasswordSettingsTableViewController.m
//  StrongBox
//
//  Created by Mark on 29/05/2017.
//  Copyright © 2017 Mark McGuill. All rights reserved.
//

#import "PasswordSettingsTableViewController.h"
#import "PreviousPasswordsTableViewController.h"
#import "Alerts.h"

@implementation PasswordSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindToModel];
}

- (IBAction)onMaxEntriesStepper:(id)sender {
    _model.maximumSize = (int)self.uiStepper.value;

    [self save];
    [self bindToModel];
}

- (IBAction)onTogglePasswordHistoryEnabled:(id)sender {
    if (!self.uiSwitchEnabled.on && (_model.entries).count > 0) {
        [Alerts yesNo:self
                title:@"Disable History?"
              message:@"Are you sure you want to disable history? This will clear previous passwords."
               action:^(BOOL response) {
                   if (response) {
                   _model.enabled = NO;
                   [_model.entries removeAllObjects];

                   [self save];
                   [self bindToModel];
                   }
                   else {
                   _model.enabled = YES;
                   [self bindToModel];
                   }
               }];
    }
    else {
        _model.enabled = self.uiSwitchEnabled.on;
        [self save];
        [self bindToModel];
    }
}

- (void)save {
    self.saveFunction(self.model, ^(NSError *error) {
        if (error) {
            [Alerts error:self title:@"Problem Saving Safe" error:error];
        }
    });
}

- (void)bindToModel {
    self.uiSwitchEnabled.on = _model.enabled;

    self.uiTableViewCellMaximumEntries.userInteractionEnabled = _model.enabled;
    self.uiTableViewCellMaximumEntries.textLabel.enabled = _model.enabled;
    self.uiTableViewCellMaximumEntries.detailTextLabel.enabled = _model.enabled;

    self.uiTableViewCellPreviousPasswords.userInteractionEnabled = _model.enabled;
    self.uiTableViewCellPreviousPasswords.textLabel.enabled = _model.enabled;
    self.uiTableViewCellPreviousPasswords.detailTextLabel.enabled = _model.enabled;

    self.uiStepper.enabled = _model.enabled;
    self.uiStepper.value = _model.maximumSize;

    self.uiLabelMaximumEntriesStatic.enabled = _model.enabled;
    self.uiLabelMaximumEntries.enabled = _model.enabled;

    (self.uiLabelMaximumEntries).text = [NSString stringWithFormat:@"%lu", (unsigned long)_model.maximumSize];

    self.uiLabelPreviousPasswords.enabled = _model.enabled;

    if ((_model.entries).count > 0) {
        self.uiLabelPreviousPasswords.text = [NSString stringWithFormat:@"Old Passwords (%lu)", (unsigned long)(_model.entries).count];
    }
    else {
        self.uiLabelPreviousPasswords.text = [NSString stringWithFormat:@"Old Passwords (None)"];
        self.uiLabelPreviousPasswords.enabled = NO;
        self.uiTableViewCellPreviousPasswords.userInteractionEnabled = NO;
        self.uiTableViewCellPreviousPasswords.textLabel.enabled = NO;
        self.uiTableViewCellPreviousPasswords.detailTextLabel.enabled = NO;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"segueToPreviousPasswords"]) {
        PreviousPasswordsTableViewController *vc = segue.destinationViewController;
        vc.model = _model;
    }
}

@end

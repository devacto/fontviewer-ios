//
//  SettingsViewController.m
//  FontViewer
//
//  Created by Victor Wibisono on 28/09/13.
//  Copyright (c) 2013 Victor Wibisono. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) NSString *currentAlignmentSettingObject;
@property (nonatomic, strong) NSString *currentSortByObject;
@property (nonatomic, strong) UISwitch *reverseCharacterSwitch;
@property (nonatomic, strong) UISwitch *ascendingSwitch;
@property (nonatomic, strong) NSMutableDictionary *settingsDictionary;

@property NSInteger textAlignmentIndex;
@property NSInteger sortByIndex;
@property BOOL reverseCharacterBool;
@property BOOL sortAscendingBool;

@end

@implementation SettingsViewController

NSString *_textAlignmentString = @"Text alignment";
NSString *_characterString = @"Characters";
NSString *_sortByString = @"Sort by";
NSString *_ascendingString = @"Sort type";
NSString *_revertString = @"Revert";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataFromUserDefaults];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self getSections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if ([self tableView:self.tableView titleForHeaderInSection:section] == _textAlignmentString) {
        numberOfRows = [[self getAlignmentRows] count];
    } else if ([self tableView:self.tableView titleForHeaderInSection:section] == _characterString) {
        numberOfRows = [[self getCharacterRows] count];
    } else if ([self tableView:self.tableView titleForHeaderInSection:section] == _sortByString) {
        numberOfRows = [[self getSortByRows] count];
    } else if ([self tableView:self.tableView titleForHeaderInSection:section] == _ascendingString) {
        numberOfRows = [[self getSortingRows] count];
    } else if ([self tableView:self.tableView titleForHeaderInSection:section] == _revertString) {
        numberOfRows = [[self getRevertRows] count];
    }
    
    // Return the number of rows in the section.
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *labelString;
    if ([self tableView:self.tableView titleForHeaderInSection:indexPath.section] == _textAlignmentString) {
        // Get text alignment index value from NSUserDefaults.
        // If there is none then left is the default.
        // Put that into an integer somewhere.
        labelString = [[self getAlignmentRows] objectAtIndex:indexPath.row];
    } else if ([self tableView:self.tableView titleForHeaderInSection:indexPath.section] == _characterString) {
        labelString = [[self getCharacterRows] objectAtIndex:indexPath.row];
    } else if ([self tableView:self.tableView titleForHeaderInSection:indexPath.section] == _sortByString) {
        labelString = [[self getSortByRows] objectAtIndex:indexPath.row];
    } else if ([self tableView:self.tableView titleForHeaderInSection:indexPath.section] == _ascendingString) {
        labelString = [[self getSortingRows] objectAtIndex:indexPath.row];
    } else if ([self tableView:self.tableView titleForHeaderInSection:indexPath.section] == _revertString) {
        labelString = [[self getRevertRows] objectAtIndex:indexPath.row];
    }
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Setting the label of the cell
    // This has to be out of the cell == nil if clause so that the label will be set even if they can reuse existing cell.
    cell.textLabel.text = labelString;
    
    if ([cell.textLabel.text isEqualToString: @"Reverse characters"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *switchView = [[UISwitch alloc] init];
        cell.accessoryView = switchView;
        
    } else if ([cell.textLabel.text isEqualToString:@"Ascending"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *switchView = [[UISwitch alloc] init];
        cell.accessoryView = switchView;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self getSections] objectAtIndex:section];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        // Section: Text alignment
        // Behaviour: Exclusive list checkmark.
        NSInteger textAlignmentIndex = [[self getAlignmentRows] indexOfObject:self.currentAlignmentSettingObject];
        if (textAlignmentIndex == indexPath.row) {
            return;
        }
        
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:textAlignmentIndex inSection:indexPath.section];
        UITableViewCell *newCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (newCell.accessoryType == UITableViewCellAccessoryNone) {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.currentAlignmentSettingObject = [[self getAlignmentRows] objectAtIndex:indexPath.row];
            
            // Saves currently selected text alignment index to NSUserDefaults.
            [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"TextAlignmentIndex"];
        }
        
        UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:oldIndexPath];
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    } else if (indexPath.section == 2) {
        // Section: Sort by
        // Behaviour: Exclusive list checkmark.
        NSInteger sortByIndex = [[self getSortByRows] indexOfObject:self.currentSortByObject];
        if (sortByIndex == indexPath.row) {
            return;
        }
        
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:sortByIndex inSection:indexPath.section];
        UITableViewCell *newCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (newCell.accessoryType == UITableViewCellAccessoryNone) {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.currentSortByObject = [[self getSortByRows] objectAtIndex:indexPath.row];
        }
        
        UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:oldIndexPath];
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        // Saves currently selected sort by index to NSUserDefaults.
        [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"SortByIndex"];
        
    }
    
}

#pragma mark - Load data from user defaults

- (void)loadDataFromUserDefaults {
    // Load text alignment index value.
    _textAlignmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"TextAlignmentIndex"];

    // Load reverse character boolean value.
    _reverseCharacterBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"ReverseCharacterBool"];
    
    // Load sort by index value.
    _sortByIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"SortByIndex"];
    
    // Load sort type ascending boolean value.
    _sortAscendingBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"SortAscendingBool"];
}

#pragma mark - Data setup

- (NSArray*)getSections
{
    return [NSArray arrayWithObjects: _textAlignmentString, _characterString, _sortByString, _ascendingString, _revertString, nil];
}

- (NSArray*)getAlignmentRows
{
    return [NSArray arrayWithObjects:@"Left", @"Right", nil];
}

- (NSArray *)getCharacterRows
{
    return [NSArray arrayWithObjects:@"Reverse characters", nil];
}

- (NSArray *)getSortByRows
{
    return [NSArray arrayWithObjects:@"Alphabetical order", @"Character count", @"Display size", nil];
}

- (NSArray*)getSortingRows
{
    return [NSArray arrayWithObjects:@"Ascending", nil];
}

- (NSArray*)getRevertRows
{
    return [NSArray arrayWithObjects:@"Refresh to default state", nil];
}

@end

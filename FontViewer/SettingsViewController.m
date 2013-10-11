//
//  SettingsViewController.m
//  FontViewer
//
//  Created by Victor Wibisono on 28/09/13.
//  Copyright (c) 2013 Victor Wibisono. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

NSString *_textAlignmentString = @"Text Alignment";
NSString *_characterString = @"Characters";
NSString *_sortByString = @"Sort by";
NSString *_ascendingString = @"Ascending";
NSString *_revertString = @"Revert";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    NSLog(@"Label string is %@", labelString);
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Setting the label of the cell
    // This has to be out of the cell == nil if clause so that the label will be set even if they can reuse existing cell.
    cell.textLabel.text = labelString;
    
    if ([cell.textLabel.text isEqualToString: @"Reverse Characters"]) {
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Data setup

- (NSArray*)getSections
{
    return [NSArray arrayWithObjects: _textAlignmentString, @"Characters", @"Sort by", @"Ascending", @"Revert", nil];
}

- (NSArray*)getAlignmentRows
{
    return [NSArray arrayWithObjects:@"Left", @"Right", nil];
}

- (NSArray *)getCharacterRows
{
    return [NSArray arrayWithObjects:@"Reverse Characters", nil];
}

- (NSArray *)getSortByRows
{
    return [NSArray arrayWithObjects:@"Alpha", @"Character count", @"Display size", nil];
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

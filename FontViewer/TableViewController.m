//
//  TableViewController.m
//  FontViewer
//
//  Created by Victor Wibisono on 22/09/13.
//  Copyright (c) 2013 Victor Wibisono. All rights reserved.
//

#import "TableViewController.h"
#import "SettingsViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *fontNames;
@property BOOL reverseCharacter;
@property BOOL sortTypeAscending;
@property NSTextAlignment textAlignment;

@end

@implementation TableViewController

CGFloat DEFAULT_FONT_SIZE = 14.0;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set property which will become the data source of the TableViewController.
    self.fontNames = [[UIFont familyNames] mutableCopy];
    
    // Add the edit button
    // Add the settings button
    [self setupEditButton];
    [self setupSettingsButton];
    
    // Get settings stored on the phone.
    _reverseCharacter = [self getReverseCharacter];
    _sortTypeAscending = [self getSortTypeAscending];
    _textAlignment = [self getTextAlignment];
    
    // Configure model based on settings stored on phones.
    [self setupTableSorting];
    
    // Reload table based on configured model
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.textAlignment = _textAlignment;
    
    // Configure the cell...
    cell.textLabel.font = [UIFont fontWithName:cell.textLabel.text size:DEFAULT_FONT_SIZE];
    
    // Check if the text characters are supposed to be reversed.
    if (_reverseCharacter == YES) {
        cell.textLabel.text = [self reverseStringFrom:[self.fontNames objectAtIndex:indexPath.row]];
    } else {
        cell.textLabel.text = [self.fontNames objectAtIndex:indexPath.row];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.fontNames removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self setSettingsAfterTableModifications];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *stringToMove = [self.fontNames objectAtIndex:fromIndexPath.row];
    [self.fontNames removeObjectAtIndex:fromIndexPath.row];
    [self.fontNames insertObject:stringToMove atIndex:toIndexPath.row];
    [self setSettingsAfterTableModifications];
}

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
}

#pragma mark - Table setup helper methods

- (void) setupEditButton
{
    if ([self numberOfItemsInTable] > 0) {
        UIBarButtonSystemItem rightButtonType;
        if (self.tableView.isEditing) {
            rightButtonType = UIBarButtonSystemItemDone;
        } else {
            rightButtonType = UIBarButtonSystemItemEdit;
        }
        
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:rightButtonType target:self action:@selector(editTable:)];
        [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
        [self.tableView setEditing:NO];
    }
}

- (void)editTable:(id)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    [self setupEditButton];
}

- (void)setupSettingsButton
{
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(displaySettingsScreen)];
    [self.navigationItem setLeftBarButtonItem:settingsButton];
}

- (void)setupTableSorting
{
    // Check which sorting is being stored on NSUserDefaults and then apply the necessary sorting.
    // 0 - Alphabetical order; 1 - Character count; 2 - Display size; If it is not 0, 1 or 2 - No sorting.
    NSInteger sortByIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"SortByIndex"];
    switch (sortByIndex) {
        case 0:
            [self sortFontNamesByAlphabeticalOrder];
            break;
        
        case 1:
            [self sortFontNamesByCharacterCount];
            break;
            
        case 2:
            [self sortFontNamesByDisplaySize];
            
        default:
            break;
    }
    
    if (_sortTypeAscending == NO) {
        [self sortDescending];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Selectors

- (void)displaySettingsScreen
{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingsViewController.title = @"Settings";
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

#pragma mark - Retrieve settings

// Reverse character: YES or NO
- (BOOL)getReverseCharacter
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"ReverseCharacterBool"];
}

// Text alignment: left or right
- (NSTextAlignment)getTextAlignment {
    NSInteger textAlignmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"TextAlignmentIndex"];
    switch (textAlignmentIndex) {
        case 0:
            return NSTextAlignmentLeft;
            break;
        
        case 1:
            return NSTextAlignmentRight;
            break;
        
        default:
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"TextAlignmentIndex"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return NSTextAlignmentLeft;
            break;
    }
}

// Sort by: alphabetical order, character count, display size.
- (BOOL)getSortTypeAscending
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"SortAscendingBool"];
}

#pragma mark - Sort methods

// Method to sort the array by alphabetical order.
- (void)sortFontNamesByAlphabeticalOrder
{
    [_fontNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

// Method to sort the array by string character count.
- (void)sortFontNamesByCharacterCount
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"length" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    [_fontNames sortUsingDescriptors:sortDescriptors];
}

// Method to sort the array by display size.
- (void)sortFontNamesByDisplaySize
{
    [_fontNames sortUsingComparator:^NSComparisonResult(id firstObject, id secondObject) {
        
        NSNumber *firstFontWidth  = [NSNumber numberWithFloat:[(NSString *)firstObject sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:firstObject size:DEFAULT_FONT_SIZE]}].width];
        NSNumber *secondFontWidth = [NSNumber numberWithFloat:[(NSString *)secondObject sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:secondObject size:DEFAULT_FONT_SIZE]}].width];

        return [firstFontWidth compare:secondFontWidth];
    }];
}

#pragma mark - Sort descending

- (void)sortDescending
{
    NSArray *reversedFontNames = [[_fontNames reverseObjectEnumerator] allObjects];
    _fontNames = [reversedFontNames mutableCopy];
}

#pragma mark - Other helper methods

// String reverse helper function
- (NSString *)reverseStringFrom:(NSString *)originalString
{
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [originalString length];
    while (originalString && charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[originalString substringWithRange:subStrRange]];
    }
    return reversedString;
}

- (NSInteger)numberOfItemsInTable
{
    NSInteger items = 0;
    
    for (int i = 0; i < [self.tableView numberOfSections]; i++) {
        items = items + [self.tableView numberOfRowsInSection:i];
    }
    
    return items;
}

- (void)setSettingsAfterTableModifications
{
    // Change sort-by to 3.
    // Change sort type ascending to false
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"SortByIndex"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SortAscendingBool"];
}
@end

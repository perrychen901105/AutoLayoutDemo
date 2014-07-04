
#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *filterNameLabel;
@end

@implementation ViewController
{
	NSArray *filterNames;
	NSUInteger activeFilterIndex;
	UITableView *filterTableView;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	filterNames = @[ @"Show All", @"By Name", @"By Date", @"By Popularity" ];
	activeFilterIndex = 0;

	self.filterNameLabel.text = filterNames[activeFilterIndex];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.tableView)
		return 50;
	else
		return [filterNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	if (tableView == self.tableView)
	{
		cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
	}
	else
	{
		cell.textLabel.text = filterNames[indexPath.row];
		cell.accessoryType = (activeFilterIndex == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	}

	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

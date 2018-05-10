#import "EXCRootListController.h"

@implementation TouchesRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Touches" target:self] retain];
	}

	return _specifiers;
}

@end

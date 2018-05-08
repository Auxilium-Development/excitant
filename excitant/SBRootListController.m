#import "EXCRootListController.h"

@implementation SBRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"TapTapUtils" target:self] retain];
	}

	return _specifiers;
}

@end

#include "LSFRootListController.h"

#include <spawn.h>
#include <signal.h>

@implementation LSFRootListController

- (id)init {
	self = [super init];
	if(self) {
		UIBarButtonItem *respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
		self.navigationItem.rightBarButtonItem = respringButton;
	}
	return self;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)respring {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "SpringBoard", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}

@end

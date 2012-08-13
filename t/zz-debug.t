#!perl

use Test::More;
do "t/common.pl";

###################################################################
# DEBUG support

ok_plugin(0, "DEBUG OK - good", undef, "Debugging / Dumping", sub {
	use Synacor::SynaMon::Plugin qw(:easy);
	PLUGIN name => "debug";
	START;
	DEBUG("this is a debug statement");
	DUMP(qw(and this is a dumped array));
	OK "good";
	DONE;
});

ok_plugin(0, "DEBUG> test debugging", undef, "debug processing", sub {
	close STDERR;
	use Synacor::SynaMon::Plugin qw(:easy);
	PLUGIN name => "DEBUG";
	START default => "done";

	open STDERR, ">&STDOUT";
	DEBUG "test debugging";

	DONE;
}, ["-D"]);

ok_plugin(0, "DEBUG> undef", undef, "debug undef handling", sub {
	close STDERR;
	use Synacor::SynaMon::Plugin qw(:easy);
	PLUGIN name => "DEBUG";
	START default => "done";

	open STDERR, ">&", STDOUT;
	DEBUG undef, "line 2";

	DONE;
}, ["-D"]);

ok_plugin(0, "DEBUG> \$VAR1 = 'test';", undef, "object dump", sub {
	close STDERR;
	use Synacor::SynaMon::Plugin qw(:easy);
	PLUGIN name => "DEBUG";
	START default => "done";

	open STDERR, ">&", STDOUT;
	DUMP "test";

	DONE;
}, ["-D"]);

done_testing;

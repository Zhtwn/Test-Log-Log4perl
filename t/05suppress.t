#!/usr/bin/perl

use strict;
use warnings;

use Log::Log4perl;
use Log::Log4perl::Level;

use Test::More tests => 3;
use Test::Builder::Tester;
use Test::Log::Log4perl;
use Test::Exception;

my $logger   = Log::Log4perl->get_logger('Foo');
$logger->level($ERROR);

# set up appender to capture logs
my $app = Log::Log4perl::Appender->new('Log::Log4perl::Appender::TestBuffer');
$logger->add_appender($app);

########################################################

$logger->error('unsuppressed');
is($app->buffer, "ERROR - unsuppressed\n", 'unsuppressed log works' );
$app->buffer('');

Test::Log::Log4perl->suppress_logging;
$logger->error('suppressed');
is( $app->buffer, '', 'suppress_logging works');

# new logger should still be suppressed
my $new_logger = Log::Log4perl->get_logger('Bar');
$new_logger->level($ERROR);
my $new_app = Log::Log4perl::Appender->new('Log::Log4perl::Appender::TestBuffer');
$new_logger->add_appender($new_app);

$new_logger->error('also suppressed');
is( $new_app->buffer, '', 'suppress_logging works with new logger' );



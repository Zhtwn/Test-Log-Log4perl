#!/usr/bin/perl

use strict;
use warnings;

use Log::Log4perl;
use Log::Log4perl::Level;

use Test::More tests => 2;
use Test::Builder::Tester;
use Test::Log::Log4perl;
use Test::Exception;

my $logger   = Log::Log4perl->get_logger("Foo");
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


use 5.012;

use strict;
use warnings FATAL => 'all';

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'gloc',
    AUTHOR           => q{Jeremy Volkening <jdv@base2bio.com>},
    VERSION_FROM     => 'gloc',
    ABSTRACT_FROM    => 'gloc',
    LICENSE          => 'GPL_3',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.012,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
        'Test::Pod'  => 0,
    },
    PREREQ_PM => {
        # core
        'Config'          => 0,
        'Digest::SHA'     => 0,
        'Encode'          => 0,
        'File::Basename'  => 0,
        'File::Copy'      => 0,
        'Getopt::Long'    => 0,
        'List::Util'      => 0,
        'MIME::Base64'    => 0,
        'threads'         => 0,
        'threads::shared' => 0,
        'Thread::Queue'   => 0,
        'Time::Piece'     => 0,
        'URI'             => 0,

        # non-core
        'File::HomeDir'   => 0,
        'Gtk3'            => 0,
        'HTML::Entities'  => 0,
        'HTTP::Tiny'      => 0,
        'IO::Socket::SSL' => 1.56,
        'Net::SSLeay'     => 1.49,
        'XML::Simple'     => 0,
    },
    EXE_FILES => [qw|
        gloc
    |],
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url => 'https://github.com/jvolkening/gloc.git',
                web => 'https://github.com/jvolkening/gloc',
            },
        },
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'gloc-*' },
);

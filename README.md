# NAME

gloc - A GNU/Linux Overdrive/EMusic download client

# SYNOPSIS

    gloc [options] <some_book.odm>

# DESCRIPTION

GLOC is a download manager for the OverDrive and eMusic MP3 audiobook
collections written in Perl+GTK. Lack of a native Linux client for downloading
OverDrive audiobooks from libraries and retailers has left Linux users in the
cold, and this program was written to fill that need.  eMusic compatibility
was added later. It is developed and tested on Debian GNU/Linux but is
expected to run on most flavors of Linux as well as any other platforms with
the Perl bindings to the GTK+ libraries.

# LICENSING AND LEGAL CONSIDERATIONS (Please read)

GLOC is not authorized by OverDrive or eMusic. However, GLOC does not make any
attempts to circumvent license restrictions and only works with the (already
DRM-free) MP3 versions of audiobooks. It requires the user to have a license
for any books downloaded in the same way that the official,
non-Linux-compatible client does.

It is important to note, however, that GLOC is not an audiobook manager, and
does not manage license restrictions. It is a simple client which facilitates
the download of legally borrowed or purchased MP3 files from the official
OverDrive or eMusic servers to the user's computer. It can display license
restrictions associated with a book (such as expiration date for borrowed
books or burn-to-CD limits) but the user is responsible for abiding by any
and all such restrictions and removing files when the license period has ended.

# INSTALLATION

GLOC is currently distributed as a single perl script along with associated
documentation. If you are lucky, installation may be as simple as downloading
the tarball, extracting, making the 'gloc' binary executable, and running it.
It is also useful to add 'gloc' to your PATH, but the details of file
permissions and environment variables will not be covered here.

Some users, however, may need to install a few prerequisites before GLOC will
run. The primary dependency, besides a reasonably modern version of perl, is
the GTK+ (v.2) graphics library. Users of KDE or other non-GTK desktops may
need to install this separately (a rather heavy dependency, but there you have
it). Beyond that, most of the modules used are part of the perl core as of
version 5.9 or later, with the exception of the following which may need to be
installed separately:

- File::HomeDir
- Gtk2
- IO::Socket::SSL
- HTML::Entities
- HTTP::Tiny
- Net::SSLeay
- XML::Simple

These are available from the package manager of most distributions. For
example, on Debian they can be installed with (on a single line):

    apt-get install libfile-homedir-perl libgtk2-perl libhtml-parser-perl
    libhttp-tiny-perl libxml-simple-perl libio-socket-ssl-perl
    libnet-ssleay-perl

There is also now a Makefile.PL included with the distribution for those who
prefer. All it does is to check the dependencies and copy the executable and
manpage to an appropriate directory (wherever your copy of Perl is configured
to install binaries from MakeMaker scripts). Install by:

    perl Makefile.PL
    make
    make install

Test your installation simply by running the program on the command line (if
you don't know how to do this, either read elsewhere or have someone else
install and set up GLOC for you). It should open the main GLOC window. If you
get errors about missing dependencies, check the above, seek help elsewhere,
or (as a last resort) submit a question to the developers.

# BASIC USAGE

GLOC usage should be relatively self-explanatory, but a brief description of a
typical use case and some relevant implementation details are provided below.

## Loading a Book

GLOC is meant to be used as a download manager. It works by reading
information from the XML metadata files that are served by both OverDrive and
eMusic (albeit in different formats) when a download is initiated. Basically,
when you click "Download" for a book title in your browser, the browser
will download an "\*.odm" file (for OverDrive) or "\*.emx" file (for eMusic). On
Windows or Mac, this file is transparently opened by the OverDrive Media
Console or eMusic Download Manager. For GLOC, the browser should be set up to
recognize "\*.odm" and "\*.emx" file extensions and open them with the 'gloc'
binary. The details of how to do this are browser-specific and the user should
refer to their browser documentation for how to associate downloaded file
types with specific applications.

Alternatively, the "\*.odm" or "\*.emx" XML files can be saved to disk and then
opened separately in GLOC. To do this, either pass the path to the XML file on
the command line as the only argument to GLOC (e.g. 'gloc example\_book.odm')
or open up gloc and select the XML file via "File->Open".

When an ODM or EMX file is opened for the first time, GLOC will prompt for a
directory in which to save the audiobook files. Within this directory, it will
create a new subdirectory with a name based on the book title. For example, if you are
downloading "A Clockwork Orange" and select "Media/Audiobooks" as the parent
directory, GLOC will create a folder called
"Media/Audiobooks/A\_Clockwork\_Orange" to which to save all of the MP3 files
and associated metadata.

If the XML file loads successfully, the main GLOC window will be populated
with information about the book (title, author, etc) as well as a list of MP3
files comprising the audiobook. By default, all files are selected, but the
list of selected files can be changed if desired. Clicking the 'Start
Download' button at the bottom of the window will initialize download of the
selected files, and progress for each file is shown on the right side of each
line. The download can be aborted at any time by clicking 'Stop Download'. If
all goes well, the status of all files will eventually change to 'Completed'
and GLOC can be closed.

## Restarting Interrupted Downloads

Occasionally a file download will timeout or fail for some reason, and its
status will remain as 'Missing' after the other downloads complete. Download
of individual files can be re-tried as many times as necessary by selecting
them and clicking 'Start Download' again. Successful downloads are tested
by comparing the expected and actual file sizes, which must match before a
file is marked as 'Completed'.

When a book download is attempted for the first time, GLOC saves a
configuration file in the book's directory named '.gloc\_meta' (normally hidden
in Linux). It also renames and saves a copy of the downloaded XML file as
'download.odm' or 'download.emx'. If GLOC needs to be closed for some reason
during download, these files store information needed to resume the download
at a later time. Simply run GLOC and open the 'download.odm' or 'download.emx'
file. All relevant information should load and the download can be resumed as
per the previous paragraph.

# COMMAND LINE OPTIONS

The following options are supported when using GLOC from the command line:

- --retry &lt;int>

    Specify the number of times times to retry connections before giving up.
    Default: 3.

- --threads &lt;int>

    Specify the number of download threads to use.

    \*WARNING\*: use of more than one thread is experimental and currently
    unstable. Stick to the default singled-threaded mode unless you want to
    assist with testing and debugging this feature. Default: 1.

- --debug

    Print various debugging messages to STDERR. Useful for developers only.

# LIMITATIONS AND BUGS

GLOC is only capable of downloading MP3 audiobooks. It does not handle WMA
audiobooks which require proprietary licensing libraries not available on
Linux. However, many libraries as well as commercial retailers using OverDrive
have a wide selection of MP3 audiobooks for download. 

GLOC should be working with eMusic now as well, but the developer no longer
has an active account and so testing has been limited.

GLOC is considered to be in beta testing stage. The developer has used it
extensively for his own needs and it behaves stably on his system, but no
outside testing on other system configurations has been done. Users are
encouraged to try it out and report any suspected bugs, unexpected behavior,
or other problems or comments on the bug tracker and discussion forums of the
project homepage ([https://github.com/jvolkening/gloc](https://github.com/jvolkening/gloc)).

# AUTHOR

Jeremy Volkening <jdv@base2bio.com>

# COPYRIGHT AND LICENSE

Copyright 2014-2018 Jeremy Volkening

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see &lt;http://www.gnu.org/licenses/>.

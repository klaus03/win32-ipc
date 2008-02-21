#---------------------------------------------------------------------
package Win32::Mutex;
#
# Copyright 1998 Christopher J. Madsen
#
# Created: 3 Feb 1998 from the ActiveWare version
#   (c) 1995 Microsoft Corporation. All rights reserved.
#       Developed by ActiveWare Internet Corp., http://www.ActiveState.com
#
#   Other modifications (c) 1997 by Gurusamy Sarathy <gsar@activestate.com>
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
# $Id: lib/Win32/Mutex.pm 236 2008-02-20 21:50:07 -0600 cmadsn $
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# Use Win32 mutex objects for synchronization
#---------------------------------------------------------------------

$VERSION = '1.06';

use Win32::IPC 1.00 '/./';      # Import everything
require Exporter;
require DynaLoader;

@ISA = qw(Exporter DynaLoader Win32::IPC);
@EXPORT_OK = qw(
  wait_all wait_any
);

bootstrap Win32::Mutex;

sub Create  { $_[0] = Win32::Mutex->new(@_[1..2]) }
sub Open  { $_[0] = Win32::Mutex->open($_[1]) }
sub Release { &release }

1;
__END__

=head1 NAME

Win32::Mutex - Use Win32 mutex objects from Perl

=head1 SYNOPSIS

	require Win32::Mutex;

	$mutex = Win32::Mutex->new($initial,$name);
	$mutex->wait;

=head1 DESCRIPTION

This module allows access to the Win32 mutex objects.  The C<wait>
method and C<wait_all> & C<wait_any> functions are inherited from the
L<"Win32::IPC"> module.

=head2 Methods

=over 4

=item $mutex = Win32::Mutex->new([$initial, [$name]])

Constructor for a new mutex object.  If C<$initial> is true, requests
immediate ownership of the mutex (default false).  If C<$name> is
omitted, creates an unnamed mutex object.

If C<$name> signifies an existing mutex object, then C<$initial> is
ignored and the object is opened.  If this happens, C<$^E> will be set
to 183 (ERROR_ALREADY_EXISTS).

=item $mutex = Win32::Mutex->open($name)

Constructor for opening an existing mutex object.

=item $mutex->release

Release ownership of a C<$mutex>.  You should have obtained ownership
of the mutex through C<new> or one of the wait functions.  Returns
true if successful.

=item $mutex->wait([$timeout])

Wait for ownership of C<$mutex>.  See L<"Win32::IPC">.

=back

=head2 Deprecated Functions and Methods

B<Win32::Mutex> still supports the ActiveWare syntax, but its use is
deprecated.

=over 4

=item Create($MutObj,$Initial,$Name)

Use C<$MutObj = Win32::Mutex-E<gt>new($Initial,$Name)> instead.

=item Open($MutObj,$Name)

Use C<$MutObj = Win32::Mutex-E<gt>open($Name)> instead.

=item $MutObj->Release()

Use C<$MutObj-E<gt>release> instead.

=back

=head1 DIAGNOSTICS

None.


=head1 CONFIGURATION AND ENVIRONMENT

Win32::Mutex requires no configuration files or environment variables.

It runs under 32-bit or 64-bit Microsoft Windows, either natively or
under Cygwin.


=head1 DEPENDENCIES

L<Win32::IPC>


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.


=head1 AUTHOR

Christopher J. Madsen E<lt>F<perl AT cjmweb.net>E<gt>

Please report any bugs or feature requests to
S<< C<< <bug-Win32-IPC AT rt.cpan.org> >> >>,
or through the web interface at
L<http://rt.cpan.org/Public/Bug/Report.html?Queue=Win32-IPC>

Loosely based on the original module by ActiveWare Internet Corp.,
L<http://www.ActiveState.com>

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENSE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut

# Local Variables:
# tmtrack-file-task: "Win32::Mutex"
# End:
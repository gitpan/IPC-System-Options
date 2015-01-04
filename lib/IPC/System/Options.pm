package IPC::System::Options;

our $DATE = '2015-01-04'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(system);

sub system {
    my $opts = ref($_[0]) eq 'HASH' ? shift : {};

    local $ENV{LC_ALL}   = $opts->{lang} if $opts->{lang};
    local $ENV{LANGUAGE} = $opts->{lang} if $opts->{lang};
    local $ENV{LANG}     = $opts->{lang} if $opts->{lang};

    if (defined($opts->{shell}) && !$opts->{shell}) {
        system {$_[0]} @_;
    } else {
        system @_;
    }
}

1;
# ABSTRACT: Perl's system() replacement/wrapper, with options

__END__

=pod

=encoding UTF-8

=head1 NAME

IPC::System::Options - Perl's system() replacement/wrapper, with options

=head1 VERSION

This document describes version 0.01 of IPC::System::Options (from Perl distribution IPC-System-Options), released on 2015-01-04.

=head1 SYNOPSIS

 use IPC::System::Options qw(system);

 # use exactly like system()
 system(...);

 # but it accepts an optional hash first argument to specify options
 system({...}, ...);

 # run without shell, even though there is only one argument
 system({shell=>0}, "ls");
 system({shell=>0}, "ls -lR"); # will fail, as there is no 'ls -lR' binary

 # set LC_ALL/LANGUAGE/LANG environment variable
 system({lang=>"de_DE.UTF-8"}, "df");

=head1 DESCRIPTION

=head1 FUNCTIONS

=head2 system([ \%opts ], @args)

Just like perl's C<system()> except that it accepts an optional hash first
argument to specify options. Currently known options:

=over

=item * shell => bool

Can be set to 0 to always avoid invoking the shell. The default is to use the
shell under certain conditions, like Perl's C<system()>.

=item * lang => str

Set locale-related environment variables: C<LC_ALL> (this is the highest
precedence, even higher than the other C<LC_*> variables including
C<LC_MESSAGES>), C<LANGUAGE> (this is used in Linux, with precedence higher than
C<LANG> but lower than C<LC_*>), and C<LANG>.

Of course you can set the environment variables manually, this option is just
for convenience.

=back

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/IPC-System-Options>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-IPC-System-Options>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=IPC-System-Options>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

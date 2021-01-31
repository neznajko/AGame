#! /usr/bin/env perl
use List::Util ('sum');
################################################################
print "Problem 1: A Game\n";
# load input to board array:
chomp( my @board = <STDIN>); # ./AGame.pl <NPUT 
my $n = scalar( @board); # board size
################################################################
my @wstk = (); # white moos
my @bstk = (); # black moos
sub dmpStk {
  print "\nW (", sum(@wstk), ") @wstk\n";
  print "B (", sum(@bstk), ") @bstk\n";
}
################################################################
sub vrooo {
  my ($c, $l, $r) = @_;
  # c - colour ('W' or 'B')
  # l - left position
  # r - right position
  if ($c eq 'W') {
    # Greedy mode:
    my $dl = $board[$l + 1] - $board[$l];
    my $dr = $board[$r - 1] - $board[$r];
    if ($dl < $dr) {
      push @wstk, $board[$l];
      vrooo('B', $l + 1, $r);
      pop @wstk;
    } else {
      push @wstk, $board[$r];
      vrooo('B', $l, $r - 1);
      pop @wstk;
    }
  } else {
    if ($l == $r) {
      push @bstk, $board[$r];
      dmpStk();
      pop @bstk;
    } else {
      push @bstk, $board[$l];
      vrooo('W', $l + 1, $r);
      pop @bstk;
      #
      push @bstk, $board[$r];
      vrooo('W', $l, $r - 1);
      pop @bstk;
    }
  }
}
################################################################
print "Game Board: @board\n";
vrooo('W', 0, $n - 1);
################################################################
# log:

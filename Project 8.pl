#!/usr/bin/perl

#Assignment: Final
#Auther: Zachary Keating (keating.zack@gmail.com)
#Version: 12.10.2016.01
#Purpose:Pig Dice

use 5.14.1;
use warnings;

my (@users, @deletedUsers);
my ($continue, $selection, $user, $homeDir);
use constant COLUMNS => 2;
use constant FILEIN => @ARGV;
use constant FILEOUT => @ARGV;
use File::Copy;
use File::Path qw(make_path);

sub main {
     setContinue();
     readUsers();
     while ($continue == 1){
          printUserList();
          setSelection();
          setUser();
          setHomeDir();
          archiveHomeDir();
          removeUser();
          populateDeltedUsers();
          setContinue();
     }
     writeUsers();
     printDeletedUsers();
}

main();

sub setContinue {
     use constant YES => 1;
     use constant NO => 0;
     if (defined $continue) {
          print "\nWould you like to continue entering patient data (1=yes 0=no) ";
          chomp ($continue = <STDIN>);
          while ($continue != YES && $continue != NO) {
               print "\nInvalid input, please try again.";
               print "\nWould you like to continue entering patient data (1=yes 0=no) ";
               chomp ($continue = <STDIN>);
          }
     } else {
          $continue = 1;
     }
}

sub readUsers {
	my $IN;
	my $counter = 0;
	my @tempData = ();
	@users = ();
	open ($IN, '<', FILEIN);
	while (<$IN>) {
		@tempData = split(/,/);
		for (my $i = 0; $i < COLUMNS; $i++) {
			chomp ($users[$counter][$i] = $tempData[$i]);
		}
		$counter++;
	}
	close $IN;
}

sub printUserList {
     my $size = @users;
     my $counter = 1;
     for (my $i = 0; $i < $size; $i++){
          print "$counter\t $users[$i]\n";
          $counter++;
     }
}

sub setSelection {
     print "Which user will you delete?";
     chomp ($selection = <STDIN>);
}

sub setUser {
     $user = $users[$selection - 1][0];
}

sub setHomeDir {
     $homeDir = $users[$selection - 1][1];
}

sub archiveHomeDir {
     exec "cp $homeDir $homeDir+.zip";
}

sub removeUser {
     exec "userdel $user";
}

sub populateDeletedUsers {
     my $size = @deletedUsers;
     for (my $i = 0; $i < COLUMNS; $i++)
          if ($i == 0 ) {
	  	$deletedUsers[$size][$i] = $user;
	  } else {
          	$deletedUsers[$size][$i] = $homeDir + ".zip";
	  }
     }
}

sub writeUsers {
     my $OUT;
	my $size = @users;
	open ($OUT, '>', FILEOUT);
	for (my $m = 0; $m < $size; $m++) {
		for (my $n = 0; $n < COLUMNS; $n++) {
			if ($n < COLUMNS) {
				print ($OUT "$users[$m][$n],");
			} else {
				print ($OUT "$users[$m][$n]");
			}
		}
		print ($OUT "\n");
	}
	close $OUT;
}

sub printDeletedUsers {
     my $size = @users;
     print "User\tArchiveDir";
     for (my $i =0; $i < $size; $i++){
          for (my $j = 0; $j < COLUMNS; $j++) {
			if ($j < COLUMNS) {
				print "$deletedUsers[$i][$j]\t";
			} else {
				print "$deletedUsers[$i][$j]\n";
			}
		}
     }
}

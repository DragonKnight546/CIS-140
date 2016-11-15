#!/usr/bin/perl

#Assignment: Project 7
#Auther: Zachary Keating (keating.zack@gmail.com)
#Version: 11.12.2015.01
#Purpose:Input patient data and print those without insurance.

use 5.14.1;
use warnings;

my (@pateintList, @uninsuredList);
my ($continue, $pin, $counter);
use constant YES=>1;
use constant NO=>0;
use constant COLUMNS=>8;
use constant DATAFILEOUT1 => "./PateintList.csv";
use constant DATAFILEOUT2 => "./UninsuredList.csv";
use Time::Piece;

sub main {
     setContinue();
     while ($continue == 1) {
          setPIN();
          setCounter();
          populatePateintList();
          setContinue();
          system("clear")
     }
     populateUninsuredList();
     printPateintList();
     printUninsuredList();
     writeData1();
     writeData2();
}

main();

sub setContinue {
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

sub setPIN {
     if (defined $pin) {
          $pin++;
     } else {
          $pin = 0;
     }
}

sub setCounter {
     if (defined $counter) {
          $counter++;
     } else {
          $counter = 0;
     }
}

sub populatePateintList {
     my ($year, $month, $day);
     use constant MIN=>2;
     use constant MAX=>20;
     for (my $i=0; $i < COLUMNS; $i++) {
          if ($i == 0) {
               $pateintList[$counter][$i] = $pin;
          } elsif ($i == 1) {
               $pateintList[$counter][$i]=0;
               while (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN ||length($pateintList[$counter][$i]) > MAX) {
                    print "\nPlease enter pateint's last name. ";
                    chomp ($pateintList[$counter][$i] = <STDIN>);
                    if (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN || length($pateintList[$counter][$i]) > MAX) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          } elsif ($i == 2) {
               $pateintList[$counter][$i]=0;
               while (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN ||length($pateintList[$counter][$i]) > MAX) {
                    print "\nPlease enter pateint's first name. ";
                    chomp ($pateintList[$counter][$i] = <STDIN>);
                    if (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN || length($pateintList[$counter][$i]) > MAX) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          } elsif ($i == 3) {
               $pateintList[$counter][$i]=0;
               while (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN || length($pateintList[$counter][$i]) > MAX) {
                    print "\nPlease enter pateint's middle name. ";
                    chomp ($pateintList[$counter][$i] = <STDIN>);
                    if (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN || length($pateintList[$counter][$i]) > MAX) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          } elsif ($i == 4) {
               my ($year, $month, $day)=0;
               use constant MINYEAR=>1900;
               use constant MAXYEAR=>2015;
               use constant MINMONTH=>1;
               use constant MAXMONTH=>12;
               use constant MINDAY=>1;
               use constant MAXDAY=>31;
               while (! $year =~ /[0-9]/ || $year < MINYEAR || $year > MAXYEAR) {
                    print "\nPlease enter pateint's year of birth. ";
                    chomp ($year = <STDIN>);
                    if (! $year =~ /[0-9]/ || $year < MINYEAR || $year > MAXYEAR) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }         
               }
               while (! $month =~ /[0-9]/ || $month < MINMONTH || $month > MAXMONTH) {
                    print "\nPlease enter pateint's month of birth. ";
                    chomp ($month = <STDIN>);
                    if (! $month =~ /[0-9]/ || $month < MINMONTH || $month > MAXMONTH) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }         
               }
               while (! $day =~ /[0-9]/ || $day < MINDAY || $day > MAXDAY) {
                    print "\nPlease enter pateint's day of birth. ";
                    chomp ($day = <STDIN>);
                    if (! $day =~ /[0-9]/ || $day < MINDAY || $day > MAXDAY) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }         
               }
               $pateintList[$counter][$i] = "$month/$day/$year";
               calculateAge($i,$day,$month,$year);
          } elsif ($i == 6) {
               $pateintList[$counter][$i]="a";
               while ($pateintList[$counter][$i] eq "a" || length($pateintList[$counter][$i]) > MAX) {
                    print "\nPlease enter pateint's insurance provider. Put zero (0) if none. ";
                    chomp ($pateintList[$counter][$i] = <STDIN>);
                    if (length($pateintList[$counter][$i]) > MAX) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          } elsif ($i == 7) {
               $pateintList[$counter][$i]=0;
               while (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN || length($pateintList[$counter][$i]) > MAX) {
                    print "\nPlease enter the pateint's aliment. ";
                    chomp ($pateintList[$counter][$i] = <STDIN>);
                    if (! $pateintList[$counter][$i] =~ /[a-zA-Z]/ || length($pateintList[$counter][$i]) < MIN || length($pateintList[$counter][$i]) > MAX) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          }
     }
}

sub calculateAge {
     my $i = $_[0];
     my $birthDay = $_[1];
     my $birthMonth = $_[2];
     my $birthYear = $_[3];
     my $year = localtime->strftime('%Y');
     my $month = localtime->strftime('%m');
     my $day = localtime->strftime('%d');
     my $age;
     $age = $year - $birthYear;
     if ($month < $birthMonth) {
          $age = $age - 1;
     } elsif ($month == $birthMonth) {
          if ($day < $birthDay) {
               $age = $age - 1;
          }
     }
     $pateintList[$counter][$i+1] = $age;
}

sub populateUnisuredList {
     my $size = @pateintList;
     my $unisuredCounter = 0;
     for (my $i = 0; $i < $size; $i++) {
          if ($pateintList [$i][6] == 0) {
               for (my $j = 0; $j < COLUMNS; $j++) {
                    $uninsuredList[$unisuredCounter][$j] = $pateintList[$i][$j];
               }
          }
     }
}

sub printPateintList {
	my $size = @pateintList;
     print "\nPateint List\n##################\nPIN\tLast Name\tFirst Name\tMName\tDoB\tAge/Insurance\tAilment\n";
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			print "$pateintList[$i][$j]\t";
		}
		print "\n";
	}
     print "##################\n";
     sleep 15;
}

sub printUninsuredList {
	my $size = @uninsuredList;
     print "\nPateint List\n##################\nPIN\tLast Name\tFirst Name\tMName\tDoB\tAge/Insurance\tAilment\n";
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			print "$uninsuredList[$i][$j]\t";
		}
		print "\n";
	}
     print "##################";
     sleep 15;
}

sub writeData1 {
	my $OUT;
	my $size = @pateintList;
	open ($OUT, '>', DATAFILEOUT1);
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			if ($j != COLUMNS - 1) {
				print ($OUT "$pateintList[$i][$j],");
			} else {
				print ($OUT "$pateintList[$i][$j]");
			}
		}
		print ($OUT "\n");
	}
	close $OUT;
}

sub writeData2 {
	my $OUT;
	my $size = @uninsuredList;
	open ($OUT, '>', DATAFILEOUT2);
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			if ($j != COLUMNS - 1) {
				print ($OUT "$uninsuredList[$i][$j],");
			} else {
				print ($OUT "$uninsuredList[$i][$j]");
			}
		}
		print ($OUT "\n");
	}
	close $OUT;
}
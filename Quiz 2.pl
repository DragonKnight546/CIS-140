#!/usr/bin/perl

#Assignment: Quiz 2
#Auther: Zachary Keating (keating.zack@gmail.com)
#Version: 12.6.2015.01
#Purpose:Input employee data and display total years worked by all employees

use 5.14.1;
use warnings;

my @employeeData;
my ($continue,$counter, $totalYearsWorked);
use constant YES=>1;
use constant NO=>0;
use constant MIN=>1;
use constant MAXDEPARTMENT=>10;
use constant MAXID=>5000;
use constant MAXYEARS=>40;

sub main {
     setContinue();
     while ($continue == YES) {
          setCounter();
          populateEmployeeData();
          setContinue();
     }
     calculateTotalYearsWorked();
     printTotalYearsWorked();
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

sub setCounter {
     if (defined $counter) {
          $counter++;
     } else {
          $counter = 0;
     }
}

sub populateEmployeeData {
     use constant COLUMNS=>3;
     for (my $i = 0; $i < 3; $i++) {
          if ($i == 0) {
               $employeeData[$counter][$i] = 0;
               while (! $employeeData[$counter][$i] =~ /[0-9]/ || $employeeData[$counter][$i] < MIN || $employeeData[$counter][$i] > MAXID) {
                    print "\nPlease enter an employee ID (1-5000). ";
                    chomp ($employeeData[$counter][$i] = <STDIN>);
                    if (! $employeeData[$counter][$i] =~ /[0-9]/ || $employeeData[$counter][$i] < MIN || $employeeData[$counter][$i] > MAXID) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          } elsif ($i == 1){
               $employeeData[$counter][$i] = 0;
               while (! $employeeData[$counter][$i] =~ /[0-9]/ || $employeeData[$counter][$i] < MIN || $employeeData[$counter][$i] > MAXDEPARTMENT) {
                    print "\nPlease enter the department ID for employee number $employeeData[$counter][0]. ";
                    chomp ($employeeData[$counter][$i] = <STDIN>);
                    if (! $employeeData[$counter][$i] =~ /[0-9]/ || $employeeData[$counter][$i] < MIN || $employeeData[$counter][$i] > MAXDEPARTMENT) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          } else {
               $employeeData[$counter][$i] = 0;
               while (! $employeeData[$counter][$i] =~ /[0-9]/ || $employeeData[$counter][$i] < MIN || $employeeData[$counter][$i] > MAXYEARS) {
                    print "\nHow many years has employee number $employeeData[$counter][0] been employed? ";
                    chomp ($employeeData[$counter][$i] = <STDIN>);
                    if (! $employeeData[$counter][$i] =~ /[0-9]/ || $employeeData[$counter][$i] < MIN || $employeeData[$counter][$i] > MAXYEARS) {
                         print "\nIncorrect input. Please try again.\n";
                         sleep 2;
                         system ("clear");
                    }
               }
          }
     }
}

sub calculateTotalYearsWorked {
     my $size = @employeeData;
     $totalYearsWorked = 0;
     for (my $i =0; $i < $size; $i++) {
          $totalYearsWorked = $totalYearsWorked + $employeeData[$i][2];
     }
}

sub printTotalYearsWorked {
     print "\nThe sum total of work years for all employees is $totalYearsWorked year.";
}

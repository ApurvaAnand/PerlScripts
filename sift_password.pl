#!/usr/bin/perl
#the script checks if the password is valid

#subroutine to check if the password length is greater than 8
sub checkLength {
	if(length($_[0])>8){
		return 1;
	} else {
		return 0;
	}
}

#subroutine to check upper case
sub checkUpper {
	if($_[0] =~ /[A-Z]/){
		return 1;
	} else {
    	return 0;
	}
}

#subroutine to check lower case
sub checkLower {
	if($_[0] =~ /[a-z]/){
		return 1;
	} else {
    	return 0;
	}
}

#subroutine to check numeric
sub checkNum {
	if($_[0] =~ /[0-9]/){
		return 1;
	} else {
    	return 0;
	}
}

#subroutine to check alphanumeric
sub checkSym {
	if($_[0] =~ /[@#*=()~`!$%^&-+{}|:;"'<,>.\]\[\\]/){
		return 1;
	} else {
    	return 0;
	}
}

sub checkPassword {
    #password fails if the length is less than 8
	if( length($_[0]) < 8 ) {
		return "INVALID PASSWORD\n";
	}
	
    # if the length is between 8 and 11, checkUpper, checkLower, checkNum, checkSym is called
	if (length($_[0]) <= 11) {
		if( checkUpper($_[0])
			* checkLower($_[0])
			* checkNum($_[0])
			* checkSym($_[0])
			){
			return "VALID PASSWORD\n";
		} else {
			return "INVALID PASSWORD\n";
		}
	}

    # if the length is between 12 and 15, checkUpper, checkLower, checkNum is called
    if (length($_[0]) <= 15){
		if( checkUpper($_[0])
			* checkLower($_[0])
			* checkNum($_[0])
			){
			return "VALID PASSWORD\n";
		} else {
			return "INVALID PASSWORD\n";
		}
	}

    # if the length is between 16 and 19, checkUpper, checkLower is called
    if (length($_[0]) <= 19){
		if( checkUpper($_[0])
			* checkLower($_[0])
			){
			return "VALID PASSWORD\n";
		} else {
			return "INVALID PASSWORD\n";
		}
	}
    
	return "VALID PASSWORD\n";
}

$passwd = <STDIN>;
chomp($passwd);
print checkPassword($passwd);

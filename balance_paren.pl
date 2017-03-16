#!/usr/bin/perl
# the script removes unnecessary brackets from expressions

#setting the priority of operators
%oprtrOrd;
$oprtrOrd{''} = 0; 
$oprtrOrd{'('} = 0; 
$oprtrOrd{')'} = 0; 
$oprtrOrd{'-'} = 1;  
$oprtrOrd{'+'} = 1;  
$oprtrOrd{'*'} = 3;  
$oprtrOrd{'/'} = 4; 

#cleaning the expression based on the order of operators
sub getCleanExpr {
	my $str = $_[0];
	my $left = $_[1]; 
	my $right = $_[2]; 
	my $in = $_[3];
	if ( $left eq '-' && ($in eq '-' || $in eq '+')) {
		return '('.$str.')';
	} elsif ($oprtrOrd{$left} > $oprtrOrd{$in} 
		|| $oprtrOrd{$right} > $oprtrOrd{$in}
		){
			return '('.$str.')';
	} else {
		return $str;
	}

}

# uses stack to keep track of expression between open and close brackets. 
sub removeRedundant {
	my @charArr = split(//, $_[0]);
    my @stackParen;
	my @stackExpr;
	my $arrLen = length($_[0]);
	my $leftSym; my $rightSym; my $leftIn; my $rightIn; my $tempS = ""; 
	my $finalStr = ""; my $i = 0;
                            
	while ($i < $arrLen)
	{
		my $char = $charArr[$i]; 
		$i = $i + 1;
		push @stackExpr, $char;
		if ($char eq ')'){
			$char = pop @stackExpr; # will push ')' on $char
			$tempS = ""; $char = ""; 
			while($char ne '('){
				$tempS = $char.$tempS; 
				if ($char !~ /[0-9a-zA-Z]/) {
					$leftIn = $char;
				}
				$char = pop @stackExpr;
			}
			$leftSym = pop @stackExpr;
			push @stackExpr, $leftSym;
			$rightSym = $charArr[$i];
			$tempS = getCleanExpr($tempS, $leftSym, $rightSym, $leftIn); 
			push @stackExpr, $tempS;
		} 
	}
	$finalStr = join("", @stackExpr);
	print $finalStr;
    print "\n";
}

$expr = <STDIN>;
chomp($expr);
removeRedundant($expr)




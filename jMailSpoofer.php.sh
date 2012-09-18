#!/usr/bin/php -q
<?php

#echo $argv[0];
#echo $argv[1];

#$stdin = fopen('php://stdin', 'r');
#mail ("user@example.com", "test", $stdin, "FROM:knuddel@muddel.com");

#$email = file_get_contents( $argv[1] );
#mail ("user@example.com", "test", $email, "FROM:knuddel@muddel.com");
#mail ("user@example.com", "test", $email); <- FROM is not optional

$lines = file( $argv[1] );
$header = true;
$headerContent="";
$email = "";
$from="";
$subject="";

foreach($lines as $line){
	if($header === true) {
		#echo strlen($line) . "\n";
		/*
		if(strlen($line) == 2){
			echo ord($line[0]) . "|" . ord($line[1]) . "\n";
		}
		*/ #if( $line === "\r\n"){			
		#if( strcmp($line,"\r\n")){
		if( strlen(trim($line)) == 0){			
			$header = false;
			#echo "=============================";
		}else{
			$headerContent .= $line;
			#echo "Header: " . $line;
			
			if( preg_match( "/^From:/", $line) ){
				#echo $line;
				$strArr=preg_split( "/:/", $line);
				$from=trim($strArr[1]);
			}
			if( preg_match( "/^Subject:/", $line) ){
				#echo $line;
				$strArr=preg_split("/:/", $line);
				$subject=trim($strArr[1]);
			}
		}
	}else{		
		$email .= $line;
		#echo "Email: " . $line;
	}
}


#echo $headerContent;
#echo "=============================\n";
#echo $email;
echo $subject . "\n";
echo $from . "\n";

#mail ("user@example.com", "fakemailtest", $email, "FROM:knuddel@muddel.com");
mail ("user@example.com", $subject, $email, "FROM:".$from);

?>

<?php
/**
#########################################################################################################
# Copyright (c) 2009 - 2010 CustomCode.info. All Rights Reserved.
# URL:              [url]http://customcode.info[/url]
# Function:         Random String Generation
# Author:           fwhite et al
# Language:         PHP
# License:          Public Domain
# ----------------- THIS IS FREE SOFTWARE ----------------
# Version:          $Id: randlib.class.php 2 2010-03-28 22:06:04Z fwhite $
# Created:          Monday, December 28, 2009 / 01:16 AM GMT+1 (fwhite)
# Last Modified:    $Date: 2010-03-29 00:06:04 +0200 (Mo, 29 Mrz 2010) $
# Notice:           Please maintain this section
#########################################################################################################
*/

/*
    This is a collection of random string generation methods.
    This code has been created by various authors.
*/

class Rand
{
	// START randlib.class.php
	
	/**
	* source:   http://www.php.net/manual/en/function.rand.php#87095
	* source:   http://pns.mehedi.com.bd/2009/12/generate-random-string-numbers-in-php
	*
	* @param    integer $length length of returned string
	* @param	string $letters allowed characters in returned string
	* @param	integer $mt_rand specify use of mt_rand() or rand()
	*
	* @return	string
	*/
	public static function generateRandomString($length = 11, $letters = '-1234567890qwertyuiopasdfghjklzxcvbnm', $mt_rand = 1)
	{
	    $s = '';
	    $lettersLength = strlen($letters)-1;
	
	    for($i = 0 ; $i < $length ; $i++)
	    {
	        if($mt_rand == 1)
	        {
	            $s .= $letters[mt_rand(0,$lettersLength)];
	        }
	        else
	        {
	            $s .= $letters[rand(0,$lettersLength)];
	        }
	    }
	
	    return $s;
	}
	
	/*----------------------------------------------------------------------------------------
	  randomString Script- � 2008 Jean Korte (www.jeankorte.ca)
	
	  randString( int $length [, string $type[, string $exclude [, bool $repeat]]])
	
	  Returns a random string of length $length or false on failure.
	
	  $type     mixed     - default
	                      - alphanumeric, both upper and lower case
	            mixed-uc  - alphanumeric, upper case
	            mixed-lc  - alphanumeric, lower case
	            alpha     - alpha, both upper and lower case
	            alpha-uc  - alpha, upper case
	            alpha-lc  - alpha, lower case
	            numeric   - numeric
	  $exclude  alphanumeric string of characters to exclude. Defaults to null.
	  $repeat   Set to false to prevent repetition of characters in string.  Default is true.
	
	  Designed for captcha - could also be used for passwords.
	  For mixed captcha, suggested exclusions are 0Oo1l2Z5S.
	  For aural captcha, consider also excluding fFxXsS.
	----------------------------------------------------------------------------------------*/
	public static function randString($length=11,$type=false,$exclude=false,$repeat=true)
	{
	  $string['lower'] = '-abcdefghijklmnopqrstuvwxyz';
	  $string['upper'] = '-ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	  $string['digits'] = '0123456789';
	  $type=strtolower($type);
	
	  if($exclude)
	  {
	    $exclude = str_split($exclude);
	    foreach($string as $key=>$value)
	    {
	      $string[$key] = str_ireplace($exclude,'',$value);
	    }
	  }
	
	  switch ($type)
	  {
	    case 'numeric':
	      $chars = $string['digits'];
	      break;
	    case 'alpha':
	      $chars = $string['lower'].$string['upper'];
	      break;
	    case 'alpha-uc':
	      $chars = $string['upper'];
	      break;
	    case 'alpha-lc':
	      $chars = $string['lower'];
	      break;
	    case 'mixed-uc':
	      $chars = $string['upper'].$string['digits'];
	      break;
	    case 'mixed-lc':
	      $chars = $string['lower'].$string['digits'];
	      break;
	    case 'mixed':
	    default:
	      $chars=$string['lower'].$string['upper'].$string['digits'];
	      break;
	  }
		$char_length = strlen($chars);
		if((!$repeat) AND ($length > $char_length ))
	  {
	    $err_msg = "ALLOWING REPEATS - only $char_length chars available ";
	    $repeat=true;
	    trigger_error($err_msg,E_USER_NOTICE);
	  }
	
	  $rand_string = "";
	  for ($i = 0; ($i < $length); $i++)
	  {
			$char = substr($chars,mt_rand(0, strlen($chars) - 1), 1);
	    $rand_string .= $char;
	    if(!$repeat)$chars=str_ireplace($char,'',$chars);
	  }
	  return $rand_string;
	}
	
	/**
	 * Generate a random character string
	 *
	 * source: http://www.php.net/manual/en/function.rand.php#90773
	 * author: kyle dot florence [@t] gmail dot com
	 *
	 * @param    integer $length length of retured string
	 * @param	string	$chars characters to use in returned string
	 *
	 * @return	string
	*/
	public static function rand_str($length = 32, $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890')
	{
	    // Length of character list
	    $chars_length = (strlen($chars) - 1);
	
	    // Start our string
	    $string = $chars{rand(0, $chars_length)};
	
	    // Generate random string
	    for ($i = 1; $i < $length; $i = strlen($string))
	    {
	        // Grab a random character from our list
	        $r = $chars{rand(0, $chars_length)};
	
	        // Make sure the same two characters don't appear next to each other
	        if ($r != $string{$i - 1}) $string .=  $r;
	    }
	
	    // Return the string
	    return $string;
	}
	
	/**
	* genRandStr() creates a random string, with parameters to control length, type of characters,
	* and also the ability to create an array of these randomized strings with the established properties
	* (as opposed to running the function multiple times, which would require program to loop through
	* the logic portion of the function again and again).
	*
	* source: http://bundyxc.com/?p=158
	* author: bundyxc
	*
	* genRandStr($minLen, $maxLen, $alphaLower = 1, $alphaUpper = 1, $num = 1, $batch = 1)
	*
	* @param    integer $minLen is the minimum length of the string. Required.
	* @param    integer $maxLen is the maximum length of the string. Required.
	* @param    integer $alphaLower toggles the use of lowercase letters (a-z). Default is 1 (lowercase letters may be used).
	* @param    integer $alphaUpper toggles the use of uppercase letters (A-Z). Default is 1 (uppercase letters may be used).
	* @param    integer $num toggles the use of numbers (0-9). Default is 1 (numbers may be used).
	* @param    integer $batch specifies the number of strings to create. Default is 1 (returns one string).
	* When $batch is not 1 the function returns an array of multiple strings.
	*
	* @return	array
	*
	* Usage:
	*
	* //Output is a single string 5-10 characters long, using solely lowercase and numbers.
	* print_r(genRandStr(5, 10, 1, 0, 1, 1));
	*
	* //Output is an array containing 50 strings that are only uppercase, and 8 characters long.
	* print_r(genRandStr(8, 8, 0, 1, 0, 50));
	*
	* //Output is a single string 5-10 characters long, using the full alphabet (uppercase and lowercase), and all numbers.
	* print_r(genRandStr(5, 10));
	*
	*/
	
	public static function genRandStr($minLen, $maxLen, $alphaLower = 1, $alphaUpper = 1, $num = 1, $batch = 1)
	{
	    $alphaLowerArray = array('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');
	    $alphaUpperArray = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
	    $numArray = array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
	
	    if (isset($minLen) && isset($maxLen)) {
	        if ($minLen == $maxLen) {
	            $strLen = $minLen;
	        } else {
	            $strLen = rand($minLen, $maxLen);
	        }
	        $merged = array_merge($alphaLowerArray, $alphaUpperArray, $numArray);
	
	        if ($alphaLower == 1 && $alphaUpper == 1 && $num == 1) {
	            $finalArray = array_merge($alphaLowerArray, $alphaUpperArray, $numArray);
	        } elseif ($alphaLower == 1 && $alphaUpper == 1 && $num == 0) {
	            $finalArray = array_merge($alphaLowerArray, $alphaUpperArray);
	        } elseif ($alphaLower == 1 && $alphaUpper == 0 && $num == 1) {
	            $finalArray = array_merge($alphaLowerArray, $numArray);
	        } elseif ($alphaLower == 0 && $alphaUpper == 1 && $num == 1) {
	            $finalArray = array_merge($alphaUpperArray, $numArray);
	        } elseif ($alphaLower == 1 && $alphaUpper == 0 && $num == 0) {
	            $finalArray = $alphaLowerArray;
	        } elseif ($alphaLower == 0 && $alphaUpper == 1 && $num == 0) {
	            $finalArray = $alphaUpperArray;
	        } elseif ($alphaLower == 0 && $alphaUpper == 0 && $num == 1) {
	            $finalArray = $numArray;
	        } else {
	            return FALSE;
	        }
	
	        $count = count($finalArray);
	
	        if ($batch == 1) {
	            $str = '';
	            $i = 1;
	            while ($i <= $strLen) {
	                $rand = rand(0, $count);
	                $newChar = $finalArray[$rand];
	                $str .= $newChar;
	                $i++;
	            }
	            $result = $str;
	        } else {
	            $j = 1;
	            $result = array();
	            while ($j <= $batch) {
	                $str = '';
	                $i = 1;
	                while ($i <= $strLen) {
	                    $rand = rand(0, $count);
	                    $newChar = $finalArray[$rand];
	                    $str .= $newChar;
	                    $i++;
	                }
	                $result[] = $str;
	                $j++;
	            }
	        }
	
	        return $result;
	    }
	}
	
	/**
	* source: http://www.wlscripting.com/tutorial/39
	* author: http://www.wlscripting.com/tutorial/author/Daniel
	*
	* @param    integer $length length of returned string
	* @param	string $type minimum number
	*
	* @return	string
	*/
	public static function randomString($length = '12', $type = '') {
	  // Select which type of characters you want in your random string
	  switch($type) {
	    case 'num':
	      // Use only numbers
	      $salt = '1234567890';
	      break;
	    case 'lower':
	      // Use only lowercase letters
	      $salt = 'abcdefghijklmnopqrstuvwxyz';
	      break;
	    case 'upper':
	      // Use only uppercase letters
	      $salt = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	      break;
	    default:
	      // Use uppercase, lowercase, numbers, and symbols
	      $salt = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890$*#@!?';
	      break;
	  }
	  $rand = '';
	  $i = 0;
	  while ($i < $length) { // Loop until you have met the length
	    $num = rand() % strlen($salt);
	    $tmp = substr($salt, $num, 1);
	    $rand = $rand . $tmp;
	    $i++;
	  }
	  return $rand; // Return the random string
	}
	
	
	/**
	 * source: http://www.php.net/manual/en/function.rand.php#95420
	 *
	 * @param    integer $n number of random numbers to return in the array
	 * @param	integer	$min minimum number
	 * @param	integer	$max maximum number
	 *
	 * @return	array
	*/
	public static function uniqueRand($n, $min = 0, $max = null)
	{
	  if($max === null)
	   $max = getrandmax();
	  $array = range($min, $max);
	  $return = array();
	  $keys = array_rand($array, $n);
	  foreach($keys as $key)
	   $return[] = $array[$key];
	  return $return;
	}
	
	/**
	 * source: http://www.php.net/manual/en/function.rand.php#91531
	 * author: alex at bimpson dot com
	 *
	 * @param    integer $total number of random numbers to return in the array
	 * @param	integer	$min lowest possible value
	 * @param	integer	$max highest possible value
	 *
	 * @return	array
	*/
	public static function rand_array($total,$min,$max)
	{
	    $rand = array();
	    while (count($rand) < $total ) {
	    $r = mt_rand($min,$max);
	    if ( !in_array($r,$rand) ) {
	        $rand[] = $r;
	    }
	    }
	    return $rand;
	}
	
	
	/**
	 * source: http://squirrelmail.org/docs/stable-code/__filesource/fsource_squirrelmail__functionsstrings.php.html#a604
	 * author: The SquirrelMail Project Team
	 *
	 * Generates a random string from the caracter set you pass in
	 *
	 * @param int size the size of the string to generate
	 * @param string chars a string containing the characters to use
	 * @param int flags a flag to add a specific set to the characters to use:
	 *
	 *      Flags:
	 *
	 *        1 = add lowercase a-z to $chars
	 *        2 = add uppercase A-Z to $chars
	 *        4 = add numbers 0-9 to $chars
	 *
	 * @return string the random string
	*/
	public static function SQM_GenerateRandomString($size = 16, $chars = '', $flags = 0 ) {
	    if ($flags & 0x1) {
	        $chars .= 'abcdefghijklmnopqrstuvwxyz';
	    }
	
	    if ($flags & 0x2) {
	        $chars .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	    }
	
	    if ($flags & 0x4) {
	        $chars .= '0123456789';
	    }
	
	    if (($size < 1) || (strlen($chars) < 1)) {
	        return '';
	    }
	
	    /* Initialize the random number generator */
	    mt_srand(microtime() * rand());
	
	    $String = '';
	    $j = strlen( $chars ) - 1;
	    while (strlen($String) < $size) {
	        $String .= $chars{mt_rand(0, $j)};
	    }
	
	    return $String;
	}
	
	/**
	 * Generate a random string similar to Microsoft's VLK
	 * author:   fwhite
	 *
	 * @param    integer $length length of returned string
	 * @param	string  $chars allowed characters in returned string
	 * @param	integer $mt_rand specify use of mt_rand() or rand()
	 *
	 * @return	string
	*/
	public static function generate_VLK($length = 60, $chars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ', $mt_rand = 1)
	{
	    $s = '';
	    $charsLength = strlen($chars)-1;
	
	    for($i = 0 ; $i < $length ; $i++)
	    {
	        if($mt_rand == 1)
	        {
	            $s .= $chars[mt_rand(0,$charsLength)];
	        }
	        else
	        {
	            $s .= $chars[rand(0,$charsLength)];
	        }
	    }
	
	    $s = str_split($s,5);
	    $s = join('-', $s);
	
	    return $s;
	}
	
	// END randlib.class.php
}
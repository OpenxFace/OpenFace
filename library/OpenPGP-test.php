<?php

// Openpgp.php
//
// An OpenPGP implementation for creating encrypted and signed messages (e.g. e-mail) in PHP.
//
// Please refer to http://jeroenvandergun.nl/blog/2013/openpgpphp for usage instructions.
// (Please keep that link included in redistributions of this code.)


// Copyright (c) 2013, Jeroen van der Gun
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * The name Jeroen van der Gun may not be used to endorse or promote
//       products derived from this software without specific prior written
//       permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER "AS IS" AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
// EVENT SHALL JEROEN VAN DER GUN BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.


abstract class OpenpgpPacketTags
{
 const PublicKeyEncryptedSessionKey = 1;
 const Signature = 2;
 const SymmetricKeyEncryptedSessionKey = 3;
 const OnePassSignature = 4;
 const SecretKey = 5;
 const PublicKey = 6;
 const SecretSubkey = 7;
 const CompressedData = 8;
 const SymmetricallyEncryptedData = 9;
 const Marker = 10;
 const LiteralData = 11;
 const Trust = 12;
 const UserId = 13;
 const PublicSubkey = 14;
 const UserAttribute = 17;
 const SymEncryptedAndIntegrityProtectedData = 18;
 const ModificationDetectionCode = 19;
}
abstract class OpenpgpSignatureSubpacketTypes
{
 const CreationTime = -2;
 const ExpirationTime = -3;
 const ExportableCertification = -4;
 const Trust = -5;
 const RegularExpression = -6;
 const Revocable = -7;
 const KeyExpirationTime = -9;
 const PreferredSymmetricAlgorithms = -11;
 const RevocationKey = -12;
 const Issuer = -16;
 const NotationData = -20;
 const PreferredHashAlgorithms = -21;
 const PreferredCompressionAlgorithms = -22;
 const KeyServerPreferences = -23;
 const PreferredKeyServer = -24;
 const PrimaryUserId = -25;
 const PolicyUri = -26;
 const KeyFlags = -27;
 const SignerUserId = -28;
 const ReasonForRevocation = -29;
 const Features = -30;
 const Target = -31;
 const Embedded = -32;
}
abstract class OpenpgpPublicKeyAlgorithms
{
 const Rsa = 1;
 const RsaEncryptOnly = 2;
 const RsaSignOnly = 3;
 const Elgamal = 16;
 const Dsa = 17;
}
abstract class OpenpgpSymmetricKeyAlgorithms
{
 const Plaintext = 0;
 const Idea = 1;
 const TripleDes = 2;
 const Cast5 = 3;
 const Blowfish = 4;
 const Aes128 = 7;
 const Aes192 = 8;
 const Aes256 = 9;
 const Twofish = 10;
}
abstract class OpenpgpHashAlgorithms
{
 const Md5 = 1;
 const Sha1 = 2;
 const RipeMd160 = 3;
 const Sha256 = 8;
 const Sha384 = 9;
 const Sha512 = 10;
 const Sha224 = 11;
}
abstract class OpenpgpDerTags
{
 const BitString = 0x03;
 const Boolean = 0x01;
 const Integer = 0x02;
 const Null = 0x05;
 const ObjectIdentifier = 0x06;
 const OctetString = 0x04;
 const BmpString = 0x1E;
 const Ia5String = 0x16;
 const PrintableString = 0x13;
 const TeletexString = 0x14;
 const Utf8String = 0x0C;
 const Sequence = 0x30;
 const Set = 0x31;
}

abstract class Openpgp
{

 private function package($packetTag, $data)
 {
  $result = $packetTag < 0 ? '' : chr(0xC0 | $packetTag);
  if($packetTag < 0)
   $data = chr(-$packetTag) . $data;
  $octets = strlen($data);
  if($octets < 192)
   $result .= chr($octets);
  else if($octets < 8384)
   $result .= chr((($octets-192) >> 8) + 192) . chr(($octets-192) & 0xFF);
  else if($octets < 0x100000000)
   $result .= chr(255) . chr($octets >> 24) . chr($octets >> 16 & 0xFF) . chr($octets >> 8 & 0xFF) . chr($octets & 0xFF);
  else
   throw new Exception('Openpgp.php: too large packet.');
  return $result . $data;
 }
 
 private function unpackage($data, $sub = false)
 {
  $packets = array();
  for($processed = 0; $processed < strlen($data); $processed += $octets)
  {
   if($sub || (ord($data[$processed]) & 0xC0) == 0xC0)
   {
    if(!$sub)
     $packetTag = ord($data[$processed++]) & 0x3F;
    $octets = ord($data[$processed++]);
    if($octets >= 192)
    {
     if($octets < 224)
      $octets = ($octets - 192 << 8) + ord($data[$processed++]) + 192;
     else if($octets == 255)
      $octets = ord($data[$processed++]) << 24 | ord($data[$processed++]) << 16 | ord($data[$processed++]) << 8 | ord($data[$processed++]);
     else
      throw new Exception('Openpgp.php: invalid new packet length.');
    }
    if($sub)
    {
     $packetTag = -ord($data[$processed++]);
     $octets--;
    }
   }
   else if((ord($data[$processed]) & 0x80) == 0x80)
   {
    $packetTag = ord($data[$processed]) >> 2 & 0xF;
    switch(ord($data[$processed++]) & 0x3)
    {
     case 0: $octets = ord($data[$processed++]); break;
     case 1: $octets = ord($data[$processed++]) << 8 | ord($data[$processed++]); break;
     case 2: $octets = ord($data[$processed++]) << 24 | ord($data[$processed++]) << 16 | ord($data[$processed++]) << 8 | ord($data[$processed++]); break;
     default: throw new Exception('Openpgp.php: invalid old packet length.');
    }
   }
   else
    throw new Exception('Openpgp.php: unsupported packet format.');
   $extracted = substr($data, $processed, $octets);
   if(strlen($extracted) != $octets)
    throw new Exception('Openpgp.php: inconsistent packet length.');
   $packets[] = array($packetTag, $extracted);
  }
  return $packets;
 }
 
 private function literalDataPacket($text)
 {
  return self::package(OpenpgpPacketTags::LiteralData, "u\0\0\0\0\0" . $text);
 }

 private function generateSessionKey()
 {
  $sessionKey = openssl_random_pseudo_bytes(32, $secure);
  if(!$secure)
   throw new Exception('Openpgp.php: no secure random session key.');
  return $sessionKey;
 }
 
 private function packMpi($number)
 {
  $length = strlen($number);
  for($i = 0; $i < $length; $i++)
   if($number[$i] != "\0")
   {
    $digits = floor(1 + log(ord($number[$i]), 2)) + 8 * ($length - $i - 1);
    if($digits > 0xFFFF)
     throw new Exception('Openpgp.php: too large integer.');
    return chr($digits >> 8 & 0xFF) . chr($digits & 0xFF) . substr($number, $i);
   }
  return "\0\0";
 }
 
 private function unpackMpi(&$data)
 {
  $processed = 0;
  $octets = ceil((ord($data[$processed++]) << 8 | ord($data[$processed++])) / 8);
  $extracted = substr($data, $processed, $octets);
  if(strlen($extracted) != $octets)
   throw new Exception('Openpgp.php: inconsistent integer length.');
  $data = substr($data, $processed + $octets);
  return $extracted;
 }
 
 private function packBc($number)
 {
  $bc = '0';
  for($i = 0; $i < strlen($number); $i++)
   $bc = bcadd(bcmul($bc, '256', 0), ord($number[$i]), 0);
  return $bc;
 }
 
 private function unpackBc($bc)
 {
  $number = '';
  do
  {
   $number = chr(bcmod($bc, '256')) . $number;
   $bc = bcdiv($bc, '256', 0);
  }
  while($bc != '0');
  return $number;
 }
 
 private function encryptedSessionKeyPacket($publicKey, $sessionKey)
 {
  list($id, $modulus, $exponent) = $publicKey;
  $key = openssl_pkey_get_public("-----BEGIN PUBLIC KEY-----\r\n" . chunk_split(base64_encode(
   self::derPackage(OpenpgpDerTags::Sequence,
    self::derPackage(OpenpgpDerTags::Sequence,
     self::derPackage(OpenpgpDerTags::ObjectIdentifier, "\x2A\x86\x48\x86\xF7\x0D\x01\x01\x01") .
     self::derPackage(OpenpgpDerTags::Null, '')
    ) .
    self::derPackage(OpenpgpDerTags::BitString,
     "\0" .
     self::derPackage(OpenpgpDerTags::Sequence,
      self::derInteger($modulus) .
      self::derInteger($exponent)
     )
    )
   )
  )) . "-----END PUBLIC KEY-----\r\n");
  $sum = 0;
  for($i = 0; $i < 32; $i++)
   $sum += ord($sessionKey[$i]);
  if(!openssl_public_encrypt(chr(OpenpgpSymmetricKeyAlgorithms::Aes256) . $sessionKey . chr($sum >> 8 & 0xFF) . chr($sum & 0xFF), $encryptedSessionKey, $key, OPENSSL_PKCS1_PADDING))
   throw new Exception('Openpgp.php: encryption of session key failed.');
  return self::package(OpenpgpPacketTags::PublicKeyEncryptedSessionKey, "\x03" . $id . chr(OpenpgpPublicKeyAlgorithms::Rsa) . self::packMpi($encryptedSessionKey));
 }
 
 private function encryptedDataPacket($sessionKey, $source)
 {
  $prefix = openssl_random_pseudo_bytes(16, $secure);
  if(!$secure)
   throw new Exception('Openpgp.php: no secure random initialization vector.');
  $source = substr($prefix, -2) . $source;
  $source .= self::package(OpenpgpPacketTags::ModificationDetectionCode, sha1($prefix . $source . chr(0xC0 | OpenpgpPacketTags::ModificationDetectionCode) . chr(20), true));
  $encrypted = mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $sessionKey, $prefix, MCRYPT_MODE_NOFB, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0");
  do
  {
   $encrypted .= mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $sessionKey, substr($source, 0, 16), MCRYPT_MODE_NOFB, substr($encrypted, -16));
   $source = substr($source, 16);
  }
  while($source != '');
  return self::package(OpenpgpPacketTags::SymEncryptedAndIntegrityProtectedData, "\x01" . $encrypted);
 }
 
 private function onePassSignaturePacket($privateKey)
 {
  list($id,,,,,,) = $privateKey;
  return Openpgp::package(OpenpgpPacketTags::OnePassSignature, "\x03\x01" . chr(OpenpgpHashAlgorithms::Sha512) . chr(OpenpgpPublicKeyAlgorithms::Rsa) . $id . "\x01");
 }
 
 private function signaturePacket($privateKey, $text)
 {
  list($id, $modulus, $exponent, $secretExponent, $secretPrimeP, $secretPrimeQ, $secretInverse) = $privateKey;
  $secretExponentBc = self::packBc($secretExponent);
  $key = openssl_pkey_get_private("-----BEGIN RSA PRIVATE KEY-----\r\n" . chunk_split(base64_encode(
   self::derPackage(OpenpgpDerTags::Sequence,
    self::derPackage(OpenpgpDerTags::Integer, "\0") .
    self::derInteger($modulus) .
    self::derInteger($exponent) .
    self::derInteger($secretExponent) .
    self::derInteger($secretPrimeQ) .
    self::derInteger($secretPrimeP) .
    self::derInteger(self::unpackBc(bcmod($secretExponentBc, bcsub(self::packBc($secretPrimeQ), '1', 0)))) .
    self::derInteger(self::unpackBc(bcmod($secretExponentBc, bcsub(self::packBc($secretPrimeP), '1', 0)))) .
    self::derInteger($secretInverse)
   )
  )) . "-----END RSA PRIVATE KEY-----\r\n");
  $time = time();
  $subpacketData = self::package(OpenpgpSignatureSubpacketTypes::CreationTime, chr($time >> 24 & 0xFF) . chr($time >> 16 & 0xFF) . chr($time >> 8 & 0xFF) . chr($time & 0xFF)) . self::package(OpenpgpSignatureSubpacketTypes::Issuer, $id);
  $hashedData = "\x04\x01" . chr(OpenpgpPublicKeyAlgorithms::Rsa) . chr(OpenpgpHashAlgorithms::Sha512) . chr(strlen($subpacketData) >> 8 & 0xFF) . chr(strlen($subpacketData) & 0xFF) . $subpacketData;
  $hash = hash('sha512', $text . $hashedData . "\x04\xFF" . chr(strlen($hashedData) >> 24 & 0xFF) . chr(strlen($hashedData) >> 16 & 0xFF) . chr(strlen($hashedData) >> 8 & 0xFF) . chr(strlen($hashedData) & 0xFF), true);
  if(!openssl_private_encrypt(
   self::derPackage(OpenpgpDerTags::Sequence,
    self::derPackage(OpenpgpDerTags::Sequence,
     self::derPackage(OpenpgpDerTags::ObjectIdentifier, "\x60\x86\x48\x01\x65\x03\x04\x02\x03") .
     self::derPackage(OpenpgpDerTags::Null, '')
    ) .
    self::derPackage(OpenpgpDerTags::OctetString, $hash)
   ), $signature, $key, OPENSSL_PKCS1_PADDING))
   throw new Exception('Openpgp.php: signing of hash failed.');
  return self::package(OpenpgpPacketTags::Signature, $hashedData . "\0\0" . substr($hash, 0, 2) . self::packMpi($signature));
 }
 
 private function derPackage($tag, $data)
 {
  $octets = strlen($data);
  if($octets < 0x80)
   return chr($tag) . chr($octets) . $data;
  $size = '';
  while($octets != 0)
  {
   $size = chr($octets & 0xFF) . $size;
   $octets >>= 8;
  }
  return chr($tag) . chr(0x80 | strlen($size)) . $size . $data;
 }
 
 private function derInteger($number)
 {
  if(ord($number) >= 0x80)
   $number = "\0" . $number;
  return self::derPackage(OpenpgpDerTags::Integer, $number);
 }
 
 private function getKey($data, $tags, $algorithms, $flag, $private)
 {
  $candidate = null;
  foreach(self::unpackage(self::unarmor($data)) as $packet)
  {
   list($packetTag, $packetData) = $packet;
   if(in_array($packetTag, $tags))
   {
    if($packetData[0] != "\x04" || !in_array(ord($packetData[5]), $algorithms))
     continue;
    $unread = substr($packetData, 6);
    $modulus = self::unpackMpi($unread);
    $exponent = self::unpackMpi($unread);
    if($unread != '')
     $packetData = substr($packetData, 0, -strlen($unread));
    $id = substr(sha1("\x99" . chr(strlen($packetData) >> 8 & 0xFF) . chr(strlen($packetData) & 0xFF) . $packetData, true), -8);
    if($private)
    {
     $unread = substr($unread, 1);
     $candidate = array($id, $modulus, $exponent, self::unpackMpi($unread), self::unpackMpi($unread), self::unpackMpi($unread), self::unpackMpi($unread));
    }
    else
     $candidate = array($id, $modulus, $exponent);
   }
   if($packetTag != OpenpgpPacketTags::Signature || $candidate === null || $packetData[0] != "\x04" || ($packetData[1] != "\x10" && $packetData[1] != "\x13" && $packetData[1] != "\x18"))
    continue;
   $hashedLength = ord($packetData[4]) << 8 | ord($packetData[5]);
   foreach(self::unpackage(substr($packetData, 6, $hashedLength), true) as $subpacket)
   {
    list($subpacketType, $subpacketData) = $subpacket;
    if($subpacketType == OpenpgpSignatureSubpacketTypes::KeyFlags && strlen($subpacketData) >= 1 && ord($subpacketData) & $flag)
     return $candidate;
   }
  }
  throw new Exception('Openpgp.php: no suitable key found.');
 }
 
 private function getPublicKey($data)
 {
  return self::getKey($data, array(OpenpgpPacketTags::PublicKey, OpenpgpPacketTags::PublicSubkey), array(OpenpgpPublicKeyAlgorithms::Rsa, OpenpgpPublicKeyAlgorithms::RsaEncryptOnly), 0x04, false);
 }
 
 private function getPrivateKey($data)
 {
  return self::getKey($data, array(OpenpgpPacketTags::SecretKey, OpenpgpPacketTags::SecretSubkey), array(OpenpgpPublicKeyAlgorithms::Rsa, OpenpgpPublicKeyAlgorithms::RsaSignOnly), 0x02, true);
 }
 
 private function crc24($data)
 {
  $len = strlen($data);
  $octets = 0;
  $crc = 0xB704CE;
  while($len--)
  {
   $crc ^= ord($data[$octets++]) << 16;
   for($i = 0; $i < 8; $i++)
   {
    $crc <<= 1;
    if($crc & 0x1000000)
     $crc ^= 0x1864CFB;
   }
  }
  return chr($crc >> 16 & 0xFF) . chr($crc >> 8 & 0xFF) . chr($crc & 0xFF);
 }
 
 private function armor($data)
 {
  return "-----BEGIN PGP MESSAGE-----\r\n\r\n" . chunk_split(base64_encode($data)) . "=" . base64_encode(self::crc24($data)) . "\r\n-----END PGP MESSAGE-----\r\n";
 }
 
 private function unarmor($text)
 {
  $lines = explode("\r\n", $text);
  $result = '';
  $begin = $body = -1;
  for($i = 0; $i < count($lines); $i++)
  {
   if(substr($lines[$i], 0, 15) == '-----BEGIN PGP ' && substr($lines[$i], -5) == '-----')
    $begin = $i;
   else if($begin != -1 && $lines[$i] == '')
    $body = $i + 1;
   else if($body != -1 && substr($lines[$i], 0, 13) == '-----END PGP ' && substr($lines[$i], -5) == '-----')
   {
    $block = '';
    for($j = $body; $j < $i - 1; $j++)
     $block .= $lines[$j];
    $result .= base64_decode($block);
    $begin = $body = -1;
   }
  }
  return $result;
 }
 
 public function message($text, $publicKeys, $privateKey = '')
 {
  $message = self::literalDataPacket($text);
  if($privateKey != '')
  {
   $privateKey = self::getPrivateKey($privateKey);
   $message = self::onePassSignaturePacket($privateKey) . $message . self::signaturePacket($privateKey, $text);
  }
  $sessionKey = self::generateSessionKey();
  $message = self::encryptedDataPacket($sessionKey, $message);
  foreach($publicKeys as $publicKey)
   $message = self::encryptedSessionKeyPacket(self::getPublicKey($publicKey), $sessionKey) . $message;
  return self::armor($message);
 }
 
}
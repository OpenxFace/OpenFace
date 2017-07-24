<?php
/**
 * BizLogic Base Framework
 * Email Utility Class
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   201z BizLogic
 * @link        http://bizlogicdev.com
 * @link        http://pricelessphp.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Monday, July 24, 2017, 19:39 GMT+1 mknox
 * @edited      $Date$ $Author$
 * @version     $Id$
 */

require_once( 'PHPMailer/PHPMailerAutoload.php' );

class Email
{
    private $_PHPMailer;
    private $_charset = 'UTF-8';
    
    public function __construct()
    {
        $this->_PHPMailer = new PHPMailer;

        // charset
        $this->_PHPMailer->CharSet = $this->_charset;
    }

    public function send( $params = array() )
    {
        switch( $params['email_system'] ) {
            case 'mailjet':

                // is SMTP
                $this->_PHPMailer->IsSMTP();
                $this->_PHPMailer->SMTPAuth = true;

                // secure SMTP
                $this->_PHPMailer->SMTPSecure = 'tls';

                // enables SMTP debug information
                if( $params['debug'] ) {
                    $this->_PHPMailer->SMTPDebug = 2;
                }

                // sets the SMTP server
                $this->_PHPMailer->Host = $params['server']['host'];

                // set the SMTP port for the GMAIL server
                $this->_PHPMailer->Port = $params['server']['port'];

                // SMTP account username
                $this->_PHPMailer->Username = $params['smtp']['username'];

                // SMTP account password
                $this->_PHPMailer->Password = $params['smtp']['password'];

                break;

            default:
                // do nothing...
        }

        $this->_PHPMailer->From		= $params['email']['from']['address'];
        $this->_PHPMailer->FromName = $params['email']['from']['name'];

        // to
        $emailToAddress     = trim( @$params['email']['to']['email'] );
        $emailToFirstName   = trim( @$params['email']['to']['first_name'] );
        $emailToLastName    = trim( @$params['email']['to']['last_name'] );

        if( strlen( $emailToAddress ) == 0 ) {
            // log
            file_put_contents( BASEDIR.'/data/logs/error/php/'.__FUNCTION__.'-'.date('Y-m-d').'.log', translate('no_email_address'), FILE_APPEND );

            // exit
            return false;
        } else if( strlen( $emailToFirstName ) > 0 AND strlen( $emailToLastName ) > 0 AND strlen( $emailToAddress ) > 0 ) {
            $this->_PHPMailer->addAddress( $emailToAddress, $emailToFirstName.' '.$emailToLastName );
        } else if ( strlen( $emailToAddress ) > 0 ) {
            $this->_PHPMailer->addAddress( $emailToAddress );
        }

        // reply to
        $replyToEmail   = $params['email']['reply_to']['email'];
        $replyToName    = $params['email']['reply_to']['name'];

        if( strlen( $replyToEmail ) > 0 AND strlen( $replyToName ) > 0 ) {
            $this->_PHPMailer->addReplyTo( $replyToEmail, $replyToName );
        } else if( strlen( $replyToEmail ) > 0 ) {
            $this->_PHPMailer->addReplyTo( $replyToEmail );
        }

        // word wrap
        $wordwrap = (int)@$params['email']['wordwrap'];

        if( $wordwrap > 0 ) {
            $this->_PHPMailer->WordWrap = 50;
        }

        // subject
        $this->_PHPMailer->Subject = @$params['email']['subject'];

        // HTML Body
        $htmlBody = trim( @$params['email']['body']['html'] );

        // Plain-text Body
        $plainTextBody = trim( @$params['email']['body']['plaintext'] );

        if( strlen( $htmlBody ) > 0 ) {
            $this->_PHPMailer->Body = $htmlBody;
            $this->_PHPMailer->isHTML( true );
        } else {
            $this->_PHPMailer->isHTML( false );

            if( strlen( $plainTextBody ) ) {
                $this->_PHPMailer->Body = $plainTextBody;
            }
        }

        // Plain-text Body
        if( strlen( $plainTextBody ) ) {
            $this->_PHPMailer->AltBody = $plainTextBody;
        }

        if( !$this->_PHPMailer->send() ) {
            file_put_contents( BASEDIR.'/data/logs/error/php/'.__FUNCTION__.'-'.date('Y-m-d').'.log', var_export( $this->_PHPMailer->ErrorInfo, true ), FILE_APPEND );

            return $this->_PHPMailer->ErrorInfo;
        }

        return true;
    }
    
}

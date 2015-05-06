<?php
/**
 * BizLogic Base Framework
 * Extends Zend_Cache
 *
 * @author      BizLogic <hire@bizlogicdev.com>
 * @copyright   2012 - 2015 BizLogic
 * @link        http://bizlogicdev.com
 * @license     GNU Affero General Public License v3
 *
 * @since       Tuesday, November 27, 2012, 08:00 AM GMT+1 mknox
 * @edited      $Date: 2014-10-13 11:46:37 +0200 (Mon, 13 Oct 2014) $ $Author: dev@bizlogicdev.com $
 * @version     $Id: Cache.php 109 2014-10-13 09:46:37Z dev@bizlogicdev.com $
 *
 * @package     BizLogic
*/

class Cache extends Zend_Cache
{
    /**
     * setup Zend_Cache
     *
     * @link    http://framework.zend.com/manual/en/zend.cache.introduction.html
     * @param   int     $lifetime
     * @param   string  $cacheObj
     */
    public function setupCache( $lifetime, $cacheObj )
    {
        $frontendOptions = array(
            'lifetime' => $lifetime,
            'automatic_serialization' => true
        );

        $backendOptions = array('cache_dir' => ROOT_DIR.'/data/cache/');

        $cache = Zend_Cache::factory(   'Core', 'File',
                                        $frontendOptions,
                                        $backendOptions
        );

        Zend_Registry::set( $cacheObj, $cache );
    }
}
<?php

/**
 * @see http://tools.ietf.org/html/rfc4880#section-5.2.3.4
 */
class OpenPGP_SignaturePacket_SignatureCreationTimePacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->data = $this->read_timestamp();
    }

    function body() {
        return pack('N', $this->data);
    }
}
<?php

/**
 * OpenPGP Trust packet (tag 12).
 *
 * @see http://tools.ietf.org/html/rfc4880#section-5.10
 */
class OpenPGP_TrustPacket extends OpenPGP_Packet {
    function read() {
        $this->data = $this->input;
    }

    function body() {
        return $this->data;
    }
}
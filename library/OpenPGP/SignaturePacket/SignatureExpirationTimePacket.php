<?php

class OpenPGP_SignaturePacket_SignatureExpirationTimePacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->data = $this->read_timestamp();
    }

    function body() {
        return pack('N', $this->data);
    }
}
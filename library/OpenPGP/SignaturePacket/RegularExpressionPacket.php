<?php 

class OpenPGP_SignaturePacket_RegularExpressionPacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->data = substr($this->input, 0, -1);
    }

    function body() {
        return $this->data . chr(0);
    }
}
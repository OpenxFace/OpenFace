<?php 

class OpenPGP_SignaturePacket_ReasonforRevocationPacket extends OpenPGP_SignaturePacket_Subpacket {
    public $code;

    function read() {
        $this->code = ord($this->read_byte());
        $this->data = $this->input;
    }

    function body() {
        return chr($this->code) . $this->data;
    }
}
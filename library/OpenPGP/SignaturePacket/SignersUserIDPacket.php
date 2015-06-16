<?php 

class OpenPGP_SignaturePacket_SignersUserIDPacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->data = $this->input;
    }

    function body() {
        return $this->data;
    }
}
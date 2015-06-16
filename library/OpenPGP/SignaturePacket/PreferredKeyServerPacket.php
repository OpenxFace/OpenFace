<?php 

class OpenPGP_SignaturePacket_PreferredKeyServerPacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->data = $this->input;
    }

    function body() {
        return $this->data;
    }
}
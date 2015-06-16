<?php

class OpenPGP_SignaturePacket_ExportableCertificationPacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->data = (ord($this->input) != 0);
    }

    function body() {
        return chr($this->data ? 1 : 0);
    }
}
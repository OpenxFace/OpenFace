<?php

class OpenPGP_SignaturePacket_TrustSignaturePacket extends OpenPGP_SignaturePacket_Subpacket {
    function read() {
        $this->depth = ord($this->input{0});
        $this->trust = ord($this->input{1});
    }

    function body() {
        return chr($this->depth) . chr($this->trust);
    }
}
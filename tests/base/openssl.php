<?php

if (openssl_encrypt('12345', 'bf', 'xxxxxxxx', 0, 'xxxxxxxx') === false) {
    exit(1);
}

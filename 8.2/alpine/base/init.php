<?php

if (str_starts_with(OPENSSL_VERSION_TEXT, 'OpenSSL 3')) {
    $cnf = file_get_contents($path = '/etc/ssl/openssl.cnf');
    // [provider_sect]
    // default = default_sect
    // legacy = legacy_sect
    if (str_contains($cnf, "default = default_sect") && ! str_contains($cnf, "legacy = legacy_sect")) {
        $cnf = str_replace("default = default_sect", "default = default_sect" . PHP_EOL . "legacy = legacy_sect" . PHP_EOL, $cnf);
    }

    // [default_sect]
    // activate = 1
    // [legacy_sect]
    // activate = 1
    if (str_contains($cnf, '[default_sect]' . PHP_EOL . '# activate = 1') && ! str_contains($cnf, "[legacy_sect]")) {
        $cnf = str_replace('[default_sect]' . PHP_EOL . '# activate = 1', '[default_sect]' . PHP_EOL . 'activate = 1' . PHP_EOL . '[legacy_sect]' . PHP_EOL . 'activate = 1' . PHP_EOL, $cnf);
    }

    file_put_contents($path, $cnf);
    echo "Rewrite openssl.cnf" . PHP_EOL;
}

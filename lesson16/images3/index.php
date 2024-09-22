<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

if (!function_exists('dd')) {
    function dd(...$args)
    {
        foreach ($args as $x) {
            Symfony\Component\VarDumper\VarDumper::dump($x);
        }
        die(1);
    }
}

// Используем dd как в Laravel
dd(['test' => 'package']);
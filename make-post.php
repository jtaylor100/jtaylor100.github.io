<?php

// Get arguments
$title = $argv[1];

// Generate post content
ob_start();
include "post-template.php";
$content = ob_get_clean();

// Save to file in "posts" directory
$path = "posts/" . str_replace(" ", "-", strtolower($title)) . ".html";
file_put_contents($path, $content);
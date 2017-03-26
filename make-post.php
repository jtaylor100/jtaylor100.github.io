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

// Add link to post on homepage
$homeFileContents = file_get_contents("index.html");
$homeFileContents = str_replace('<ul>', "<ul>\r\n\t\t<li><a href=\"$path\">$title</a> <br> " . (new DateTime())->format("Y-m-d") . "</li>", $homeFileContents);
file_put_contents("index.html", $homeFileContents);
<!DOCTYPE html>
<head>
	<title><?= $title ?> - Code Straw</title>
	<link rel="stylesheet" href="../styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta property="og:title" content="<?= $title ?>" />
</head>
<body>	
	<div id="title">
		<h1><?= $title ?></h1>
		<sub><?= (new DateTime())->format("Y-m-d") ?> | Josh Taylor</sub>
	</div>



	<a href="..">More Posts</a>
</body>

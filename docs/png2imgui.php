<?php
//
// creates a transparency matrix of a given png
// converts it to a table for lua/imgui
// cuts empty rows and columns
//

// open local image
$import = imagecreatefrompng("./moxtest.png");

// check for successful read
if(!$import) {
	exit("error while reading image file");
}

// get width and height
$width = imagesx($import);
$height = imagesy($import);



// collector
$row_disable = array();

// loop rows
for($y = 0; $y < $height; $y++)
{
	// count lines which are zero
	$count = 0;

	// loop columns
	for($x = 0; $x < $width; $x++)
	{
		// read color index
		$index = imagecolorat($import, $x, $y);

		// and convert it to rgba
		$color = imagecolorsforindex($import, $index);

		// increase count
		if($color['alpha'] == 127) {
			$count++;
		}
	}

	// all are transparent
	if($count == $width) {
		array_push($row_disable, $y);
	}
}



// collector
$col_disable = array();

// loop columns
for($x = 0; $x < $width; $x++)
{
	// count lines which are zero
	$count = 0;

	// loop rows
	for($y = 0; $y < $height; $y++)
	{
		// read color index
		$index = imagecolorat($import, $x, $y);

		// and convert it to rgba
		$color = imagecolorsforindex($import, $index);

		// increase count
		if($color['alpha'] == 127) {
			$count++;
		}
	}

	// all are transparent
	if($count == $height) {
		array_push($col_disable, $x);
	}
}

// debugging
//print_r($row_disable);
//print_r($col_disable);
//echo "\n\n\n";

// start
echo "{\n";

// row loop
$row_loop = 0;

// loop rows again
for($y = 0; $y < $height; $y++)
{
	// no disabled rows
	if(!in_array($y, $row_disable))
	{
		// inc loop count
		$row_loop++;

		// row start
		echo "{";

		// col loop
		$col_loop = 0;

		// loop columns again
		for($x = 0; $x < $width; $x++)
		{
			// no disabled columns
			if(!in_array($x, $col_disable))
			{
				// inc loop count
				$col_loop++;

				// read color index
				$index = imagecolorat($import, $x, $y);

				// and convert it to rgba
				$color = imagecolorsforindex($import, $index);

				// if alpha on max, return only a zero
				if($color['alpha'] == 127) {
					echo "0";
				} else {
					echo round(abs(1 - ($color['alpha'] / 127)), 2);
				}

				// drop comma if not last
				if($col_loop != ($width - count($col_disable))) {
					echo ",";
				}

			}
		}

		// row end
		echo "}";

		// drop comma if not last
		if($row_loop != ($height - count($row_disable))) {
			echo ",\n";
		}
	}
}

// end
echo "\n}";



?>
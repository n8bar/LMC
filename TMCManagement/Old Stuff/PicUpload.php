<?php

/*
			Initialize Gears and Setup Drop Target
			
Gears will be initialized after DOM is ready. We need desktop support for dragging and dropping. HTTPrequest support is used for uploading the files.

We will also setup event handlers for file dropping. Target is a div with id #dropzone. Different browsers use different event names. Unfortunately jQuery does not normalize native dropping event name. Thus we need to initialize the event separately for each browser. We also need to use native DOM element fetched with .get(0). When drop happens upload() function will be called.

When dropping a file default action for browser would be top open it. With Safari and IE this can be prevented by false from dragover event. With FireFox you need to call event.stopPropagation() later in the upload() code.

*/

$error_message[0] = "Unknown problem with upload.";
$error_message[1] = "Uploaded file too large (load_max_filesize).";
$error_message[2] = "Uploaded file too large (MAX_FILE_SIZE).";
$error_message[3] = "File was only partially uploaded.";
$error_message[4] = "Choose a file to upload.";

$upload_dir  = './tmp/';
$num_files = count($_FILES['user_file']['name']);

for ($i=0; $i < $num_files; $i++)
{
	$upload_file = $upload_dir . basename($_FILES['user_file']['name'][$i]);
	
	if (!preg_match("/(gif|jpg|jpeg|png)$/",$_FILES['user_file']['name'][$i]))
	{
		print "I asked for an image...";
	}
	else
	{
		if (is_uploaded_file($_FILES['user_file']['tmp_name'][$i]))
		{
			if (move_uploaded_file($_FILES['user_file']['tmp_name'][$i], $upload_file))
			{
				/* Success... */
			}
			else
			{
				print $error_message[$_FILES['user_file']['error']];
			}     
		}
		else
		{
			print $error_message[$_FILES['user_file']['error']];
		}    
	}    
}






?>
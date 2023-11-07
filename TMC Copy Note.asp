<pre>
To run TMC on your laptop over lan, wifi, or dialup:

1. Setup IIS (requires Windows7 Ultimate or Business or Windows 8 Pro)
<font face="Condensed"><small>    1. Press WindowsLogoKey+R</small>
<small>    2. Enter appwiz.cpl</small>
<small>    3. Click the "Turn Windows features on or off" link on the left side</small>
<small>    4. Find and check "Internet Information Services"</small>
<small>       Under "Internet Information Services" >> "World Wide Web Services" >> "Application Development Features"</small>
<small>        -Find and check "ASP"</small>
<small>        -Find and check "Server-Side Includes"</small>
<small>    5. Click OK.  You may be asked for a windows cd.</small></font>

2. Move or delete your C:\inetpub\wwwroot\iisstart.html file. (you really don't need the other files in there either)

3. In Computer, enter \\tmc.tricom.sc\inetpub in the address bar and copy the entire wwwroot folder to your C:\inetpub\ folder.

4. Test it out: When connected to Tricom's network, In Chrome or Firefox (not I.E.) enter "http://localhost" minus quotes into the address bar.

Notes:
-Because the database server is still on tricom's network, you need to be connected on lan, wifi or dial-up for this to work.
-Tricom's dial-up phone number is 435-656-9512.
-This greatly improves how the website works over a dial-up connection because the actual web pages are now on your computer and only the database data goes over the wire.

-Repeat Step 3 often, like right before you leave town, to keep up to date with the latest features and fixes!

Let me know how it works out!

Frequently Asked Questions:
&lt;Ask questions so I'll have something to put here!>
</pre>
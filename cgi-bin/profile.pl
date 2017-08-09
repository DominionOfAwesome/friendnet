#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "data.lib";
require "cookies.lib";

$logged_in = $cookies{loggedin} eq $formdata{u};

print "Content-type: text/html\r\n\r\n";

&html_head;

%profile = profile_load($formdata{u});

print <<EOD;
<h1>FriendNet!</h1>
<h2>$formdata{u}</h2>
EOD

if ($profile{dogs}) {
    print <<EOD
<style>
body { background-image: url(/img/dog.gif) }
</style>
EOD
}

print <<EOD;
<table>
  <tr>
    <td>Favorite Pearl Jam album:</td><td>$profile{pearljam}</td>
  </tr>
  <tr>
    <td>Sex:</td><td>$profile{sex}</td>
  </tr>
</table>
EOD

&html_foot;

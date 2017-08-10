#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "data.lib";
require "cookies.lib";

$logged_in = $cookies{loggedin} eq $formdata{u};

print "Content-type: text/html\r\n\r\n";

%profile = profile_load($formdata{u});

&html_head($profile{dogs} ? "/img/dog.gif" : '');

print h1(&friendnet);
if ($profile{photo}) {
    print img("/images/$profile{photo}", align => right, width => 200);
}
print h2($formdata{u});


print <<EOD;
<table bgcolor=purple border=2 cellpadding=4>
  <tr>
    <td><font color=white><b>Favorite Pearl Jam album:</b></font></td><td><font color=white>$profile{pearljam}</font></td>
  </tr>
  <tr>
    <td><font color=white><b>College:</b></font></td><td><font color=white>$profile{college}</font></td>
  </tr>
  <tr>
    <td><font color=white>Sex:</font></td><td><font color=white>$profile{sex}</font></td>
  </tr>
</table>
EOD

if ($logged_in) {
    print "<p><a href=/cgi-bin/edit_profile.pl?u=$formdata{u}>Edit profile</a>\n";
}

&html_foot;

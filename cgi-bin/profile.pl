#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "data.lib";
require "cookies.lib";
require "guestbook.lib";

$logged_in = $cookies{loggedin} eq $formdata{u};

print "Content-type: text/html\r\n\r\n";

%profile = profile_load($formdata{u});

&html_head($profile{dogs} ? "/img/dog.gif" : '');

print h1(&friendnet);
if ($profile{photo}) {
    print img("/images/$profile{photo}", align => right, width => 200);
}
print h2($formdata{u});


print &h3("About $formdata{u}");

if ($logged_in) {
    print "<a href=/cgi-bin/edit_profile.pl?u=$formdata{u}>Edit profile</a>\n";
}

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

print "<a name=guestbook><h3>Guestbook</h3>\n";
print "<p><a href=/cgi-bin/guestbook.pl?u=$formdata{u}>Sign my guestbook!</a>\n";
print "<p><table bgcolor=pink border=2 cellpadding=4 width=100%><tr><td>\n";
if (-e "$datadir/guestbook/$formdata{u}") {
    &guestbook_feed($formdata{u});
} else {
    print "No one has posted yet. Be the first!\n";
}
print "</td></tr></table>\n";

&html_foot;

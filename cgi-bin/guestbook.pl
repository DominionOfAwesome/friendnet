#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "cookies.lib";
require "guestbook.lib";

print "Content-type: text/html\r\n\r\n";
&html_head;
print h1(&friendnet);

if (!$cookies{loggedin}) {
    print "<p>You must be logged in to sign the guestbook!\n";
}

if ($formdata{submit}) {
    &guestbook_add($formdata{u}, $cookies{loggedin}, $formdata{post});
    print <<EOD;
<p>You posted this to $formdata{u}'s guestbook:
<p><table cellpadding=8><tr><td><font face=courier,fixed>$formdata{post}</font></td></tr></table>
<p>You can <a href=/cgi-bin/profile.pl?u=$formdata{u}#guestbook>view it on their profile</a> or <a href=/cgi-bin/profile.pl?u=$cookies{loggedin}>go back to your profile</a>.
EOD
} else {
    print <<EOD;
<h2>$formdata{u}'s Guestbook</h2>

<form method=post>
<input type=hidden name=u value=$formdata{u}>
<textarea name=post rows=20 cols=80>
</textarea>
<p><input type=submit name=submit value=Post>
</form>
EOD
}

&html_foot;

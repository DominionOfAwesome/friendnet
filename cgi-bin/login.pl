#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "data.lib";

if (%formdata > 0 && $formdata{success} eq 'true') {
    print "Set-Cookie: loggedin=$formdata{u}\r\n";
    print "Location: /cgi-bin/profile.pl?u=$formdata{u}\r\n\r\n";
} elsif (%formdata > 0) {
    %profile = &profile_load($formdata{username});
    if ($formdata{password} eq $profile{password}) {
        print "Location: /cgi-bin/login.pl?u=$formdata{username}&success=true\r\n\r\n"
    } else {
        print "Content-type: text/html\r\n\r\n";
        &html_head;
        print "Authorization failed";
        &html_foot;
    }
} else {
    print "Content-type: text/html\r\n\r\n";

    &html_head;

    print <<EOD;
<h1>Log in to FriendNet!</h1>
<form>
<p>Username: <input name=username type=text size=8 maxlength=8>
<p>Password: <input name=password type=password size=8 maxlength=8>
<p><input type=image src=/img/clickhere.gif> to log in!
EOD
}

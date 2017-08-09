#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "data.lib";

print "Content-type: text/html\r\n\r\n";

&html_head;

if (%formdata > 0) {
    if (!$formdata{username}) {
        print "You need a username";
    } elsif (!$formdata{password1}) {
        print "You need to put in a password";
    } elsif ($formdata{password1} ne $formdata{password2}) {
        print "Your passwords don't match";
    } else {
        %profile = %formdata{username,dogs,pearljam,sex,college,photo};
        $profile{password} = $formdata{password1};
        &profile_save($formdata{username}, %profile);
        print <<EOD
<h2>Success!</h2>
<p>Your user account has been created!
<p>Please <a href=/cgi-bin/login.pl>login</a> now.
EOD
    }
} else {
    print <<EOD;
<h2>Join FriendNet</h2>

<form>
<p>Username: <input name=username type=text size=8 maxlength=8>
<p>Password: <input name=password1 type=password size=8 maxlength=8>
<p>Password again: <input name=password2 type=password size=8 maxlength=8>
<br><font size=-1>choose a secure password like "p4ssword1"</font>
<p>Dogs: <input type=checkbox name=dogs value=yes>
<p>Favorite Pearl Jam Album: <select name=pearljam>
  <option>Ten</option>
  <option>Vs.</option>
  <option>Vitalogy</option>
</select>
<p>Sex: <select name=sex>
  <option>Male</option>
  <option>Female</option>
  <option>male</option>
</select>
<p>College: <select name=college>
  <option>None</option>
  <option>Syracuse University</option>
  <option>University of Iowa</option>
  <option>University of California at Santa Barbara</option>
  <option>West Virginia University</option>
  <option>University of Illinois at Urbana-Champaign</option>
  <option>Lehigh University</option>
  <option>Pennsylvania State University at University Park</option>
  <option>University of Wisconsin at Madison</option>
  <option>Bucknell University</option>
  <option>University of Florida</option>
  <option>Miami University</option>
  <option>Florida State University</option>
  <option>Ohio University at Athens</option>
  <option>DePauw University</option>
  <option>University of Georgia</option>
  <option>University of Mississippi</option>
</select>
<p>A photo of you: <input name=photo type=file>
<p>Ready? <input type="image" src="/img/clickhere.gif"> to join!
</form>
EOD
}

&html_foot;

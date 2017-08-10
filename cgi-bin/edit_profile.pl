#!/usr/bin/perl
require "html.lib";
require "form.lib";
require "cookies.lib";
require "data.lib";

%profile = profile_load($formdata{u});

$logged_in = $cookies{loggedin} eq $formdata{u};

if (!$logged_in) {
    print "Status: 403 Forbidden\r\n";
    print "Content-type: text/plain\r\n\r\n";
    print "Forbidden\n";
    exit 0;
}

if ($formdata{x}) {
    if ($formdata{photo}) {
        if ($profile{photo}) {
            unlink "../www/images/$profile{photo}";
        }
        $profile{photo} = $filenames{photo};
        open PHOTO, ">../www/images/$filenames{photo}";
        print PHOTO $formdata{photo};
        close PHOTO;
    }
    delete $formdata{photo};
    for $key (keys %formdata) {
        $profile{$key} = $formdata{$key};
    }
    &profile_save($formdata{u}, %profile);
    print "Location: /cgi-bin/profile.pl?u=$formdata{u}\r\n\r\n";
} else {
    print "Content-type: text/html\r\n\r\n";

    &html_head;

    print <<EOD;
<h2>Edit your FriendNet! profile</h2>

<form method=POST enctype=multipart/form-data>
<input type=hidden name=u value=$formdata{u}>
<p>Dogs: <input type=checkbox name=dogs value=yes @{[ $profile{dogs} ? 'checked' : '' ]}>
EOD
    print "<p>Favorite Pearl Jam Album:", &select_option("pearljam", $profile{pearljam}, "Ten", "Vs.", "Vitalogy");
    print "<p>Sex:", &select_option("sex", $profile{sex}, "Male", "Female", "male");
    print "<p>College:", &select_option("college", $profile{college},
        "None",
        "Syracuse University",
        "University of Iowa",
        "University of California at Santa Barbara",
        "West Virginia University",
        "University of Illinois at Urbana-Champaign",
        "Lehigh University",
        "Pennsylvania State University at University Park",
        "University of Wisconsin at Madison",
        "Bucknell University",
        "University of Florida",
        "Miami University",
        "Florida State University",
        "Ohio University at Athens",
        "DePauw University",
        "University of Georgia",
        "University of Mississippi",
    );
    print <<EOD;
<p>A photo of you (100KB max): <input name=photo type=file>
<p><input type="image" src="/img/clickhere.gif"> to update your profile!
</form>
EOD

    &html_foot;
}

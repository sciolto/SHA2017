use Data::Dumper;
use IO::Socket::INET;
use GD;
use strict;

our $main_offsetx = 0;
our $main_offsety = 0;

$| = 1;
my $img_w = 80;
my $img_h = 80;
my $host = 'barflood.sha2017.org';
#my $host =  'localhost';
my $port = 2342;
#my $port = 7777;
my $socket = new IO::Socket::INET (
        PeerHost => $host,
        PeerPort => $port,
        Proto => 'tcp',
        Type => SOCK_STREAM,
    );


GD::Image->trueColor(1);
#my $image = new GD::Image('resources/troll-face-meme.png') or die 'no pic dude !';
my $image = newFromPng GD::Image('resources/troll-face-meme.png',1) or die 'no pic dude !';
my $w = $image->width;
my $h = $image->height;

my $imageResized = new GD::Image($img_w,$img_h);
$imageResized->copyResized($image,0,0,0,0,$img_w,$img_h,$w,$h);

printImage($imageResized);

#print $imageResized->png;
#exit 0;


sub printImage {
    my $w = $image->width;
    my $h = $image->height;
    $image = @_[0];
    while (1) {
        for my $x(0..$w) {
            for my $y(0..$h) {
                #print "$x $y $w $h\n";
                my $i = $image->getPixel($x,$y);
                my ($r,$g,$b) = $image->rgb($i);
                pixel($x,$y,$r,$g,$b);
            }
        } 
    }
}


sub pixel {
    my ($x,$y,$r,$g,$b,$a,$offsetx,$offsety) = @_;
    if ( !defined $a )  { $a=255 };
    if ( !defined $offsetx ) {  $offsetx=0 };
    if ( !defined $offsety ) {  $offsety=0 };
    $x = $x+$offsetx;
    $y = $y+$offsety;
    my $cmd;
    if ($a == 255) {
        $cmd = sprintf("PX  %d %d %02x%02x%02x\n",$x,$y,$r,$g,$b);
        $socket->send($cmd);
    } else {
        $cmd = sprintf("PX  %d %d %02x%02x%02x%02x\n",$x,$y,$r,$g,$b,$a);
        $socket->send($cmd);
    }

}


sub rect {
    # implement me !
}


sub worm {
    # implement me !
}

sub line {
    my ($x,$y,$r,$g,$b,$a,$offsetx,$offsety) = @_;
    
}

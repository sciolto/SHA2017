import socket
import random  
HOST = 'barflood.sha2017.org'
PORT = 2342
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((HOST, PORT))
send = sock.send

def pixel(x,y,r,g,b,a=255,offsetx=320,offsety=0):
  x = x + offsetx
  y = y + offsety
  if a == 255:
#    print('PX %d %d %02x%02x%02x\n' % (x,y,r,g,b))
    send('PX %d %d %02x%02x%02x\n' % (x,y,r,g,b))
  else:
#    print('PX %d %d %02x%02x%02x%02x\n' % (x,y,r,g,b,a))
    send('PX %d %d %02x%02x%02x%02x\n' % (x,y,r,g,b,a))


def rect(x,y,w,h,r,g,b):
 for i in xrange(x,x+w):
   for j in xrange(y,y+h):
     pixel(i,j,r,g,b)



def worm(x,y,n,r,g,b):
  while n:
    pixel(x,y,r,g,b,25)
    x += random.randint(0,2)-1
    y += random.randint(0,2)-1
    n -= 1

import time 
from PIL import Image

#im = Image.open('troll-face-meme.png').convert('RGB')
im = Image.open('resources/tits-or-gtfo_o_847231.jpg').convert('RGB')
#im = Image.open('unpodifiga.jpg').convert('RGB')
#im = Image.open('thumbsup.jpg').convert('RGB')
im.thumbnail((80,80), Image.ANTIALIAS)
_,_,w,h = im.getbbox()  

var = 1
while var == 1 :
  for x in xrange(w):
    for y in xrange(h):
      r,g,b = im.getpixel((x,y))
      pixel(x,y,r,g,b)




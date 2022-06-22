#!/usr/bin/pyton

# I'm using 2732 EPROMs in place of 2716, this script converts 
# the output binary into 4kB EPROM payload - it appends 0xFF
# up to 2kB of size, and writes everything twice.

import sys

src, dst = sys.argv[1], sys.argv[2]

with open(src, 'rb') as f:
  data = f.read()

data = data + b'\xFF' * (2048 - len(data))

with open(dst, 'wb') as f:
  f.write(data)
  f.write(data)


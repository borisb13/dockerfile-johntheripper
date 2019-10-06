# John The Ripper "Jumbo" Docker image

[John The Ripper](https://github.com/magnumripper/JohnTheRipper) is a must-have password crakcer.

This Docker image aims to provide a functional "Jumbo" version for complete CPU based password cracking.

## Usage

### Quick and dirty

For practical reasons, the image is built to be used inside an interactive container.

Just move to the directory that contains the hashes or passwords to crack and run:

```
% docker run -it --hostname jtr --rm -v $(pwd):/hashes:ro phocean/jtr
```

The current directory will be mounted in the `/hashes` directory of the container.

Then, you can crack passwords from within the container:

```
root@jtr:/jtr/run# ./john /hashes/hashes-3.des.txt
```


### Typical setup

I recommand to create a directory on your host with configuration and pot files.

For example:

```
% ls -la ~/.jtr 
total 132K
drwxr-xr-x   2 phocean phocean 4,0K oct.   5 16:02 ./
drwxr-xr-x 186 phocean phocean  12K oct.   6 13:00 ../
-rw-r--r--   1 phocean phocean 110K oct.   5 16:02 john.conf
-rw-------   1 phocean phocean 2,2K oct.   6 13:14 john.pot
```

Then, you can mount them inside the container to keep your settings and cracked passwords.

It is best to declare an alias inside your favorite shell (`.bashrc` or `.zshrc`) to make it easy to use:

```
alias jtr='docker run -it --hostname jtr --rm -v "$HOME"/.jtr/john.conf:/jtr/run/john.conf -v "$HOME"/.jtr/john.pot:/jtr/run/john.pot -v "$(pwd)":/hashes:ro phocean/jtr'
```

Now, just fire up `jtr` and you are ready to go ahead.


## Building

You can build the image locally with:

```
docker build -t phocean/jtr .
```





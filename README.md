# MORSE OF COURSE

This repository contains an implementation of timing-based
dual encoding in the programming language `bash`, as well as a
paper detailing the theoretical and practical implications
thereof.

To use the program, invoke the two components `morse_send.sh`
and `morse_recieve.sh` in a way such that the stdout of
`morse_send.sh` becomes the stdin of `morse_recieve.sh`.

Example usage:

```bash

# Simultaneously send input1.txt and input2.txt through
# the same stream, sending one in the streams "ordinary" contents,
# the other encoded in the pauses in the stream's output.
./morse_send.sh input1.txt input2.txt | ./morse_recieve.sh output1.txt output2.txt

```

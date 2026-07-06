# Structure

- `base`: contains file parts that is used by all
- `hostname`: contains file parts that is used when hostname matches
- `os`: contains file parts that is used when OS matches
- `userhost`: contains file parts that is used whes user@hostname matches

If a file has .subfile-XXX as part of it's name, XXX indicates where in the merged output file this file is places. There is only one rule, a higher number comes after a lower number in the output

If a file ends in .age it's an age encrypted file

# Important

Never run `dotsmith compile/link/apply` without explicit user approval since that will updated the compiled and linked files on the local machine.

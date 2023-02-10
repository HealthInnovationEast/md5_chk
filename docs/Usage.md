# Usage <!-- omit in toc -->

All links here are pinned to the version of XXXX that this nextflow has been created for.

- [Required args](#required-args)
  - [`--check`](#--check)
- [Optional args](#optional-args)
  - [`--outdir`](#--outdir)

## Required args

Workflow would fail if these are not defined

### `--check`

Path to file listing files to check and checksum

Format

```
sample,primary,chksum
A,A.file,B.file.md5
B,B.file,B.file.md5
```

`*.file.md5` must only include the filename in the chksum path, e.g.

```
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  B.file
```

## Optional args

Expect these to have a default behaviour if not defined

### `--outdir`

Where to write the final result file `md5_results.txt`.

This is the raw stdout from each `md5sum -c file.md5 file` command.  Find problem files with `grep -v ': OK$' md5_results.txt`

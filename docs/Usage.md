# Usage <!-- omit in toc -->

NOTE: All workflow executions are anticipated to run to completion, capturing the output of `md5sum` into a report format.

```bash
grep -vP '\t0$' results/md5_results.txt
```

This will return the header and any failed items.

- [Required args](#required-args)
  - [`--check`](#--check)
- [Optional args](#optional-args)
  - [`--outdir`](#--outdir)
- [Resource args](#resource-args)
  - [`--disk`](#--disk)
  - [`--memory`](#--memory)

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

Deault: `./results`

Where to write the final result file `md5_results.txt`.

This is the raw stdout from each `md5sum -c file.md5 file` command prefixed with the `sample` column.

Find problem files with `grep -v ': OK$' md5_results.txt`

## Resource args

These change compute resources, defaults will be present

### `--disk`

Default: `200.GB`

Please specify using GB notation above.  This should be modified to handle the largest file in the dataset.

### `--memory`

Default: `1.GB`

`md5sum` uses trivial amounts of memory, this should not need to be modified

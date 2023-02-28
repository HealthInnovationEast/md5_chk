# md5_chk

Simple distributed md5 of files.

## Workflow details

The workflow simply runs md5sum in check mode on validation pair provided recording the result to a final manifest.

All workflow executions are anticipated to run to completion, capturing the output of `md5sum` into a report format.

The report needs to be reviewed with:

```bash
grep -vP '\t0$' results/md5_results.txt
```

This will return the header and any failed items e.g.

```TSV
Sample	STDOUT	STDERR	EXIT_CODE
Bad	Bad.file: FAILED	md5sum: WARNING: 1 computed checksum did NOT match	1
```

See [Usage](docs/Usage.md) for arguments.

### Resume

Resume is not recommended for this process when running on CloudOS due to potential for large data persistence.

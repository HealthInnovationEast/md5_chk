# md5_chk

Simple distributed md5 of files.

## Workflow details

The workflow simply runs md5sum in check mode on validation pair provided recording the result to a final manifest.

- A successful workflow will generate an output including the results of `md5sum`.
- Failing workflows are resumable once the problem file has been addressed.

See [Usage](docs/Usage.md) for arguments.

### Resume

You should always run this workflow as resumable mode on CloudOS so that it is possible to correct a problem file
and restart the processing.  This minimises costs by not re-processing the sucessful verification.

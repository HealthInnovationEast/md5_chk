# CHANGES

## 0.2.1

- Remove unnecessary code from config
- Remove `retryStrategy` as conflicts with aws-batch retry
- Set `retrys` to a more appropriate default
- Update default memory to cope with docker issues under AWS-batch (memory not released quickly enough)

## 0.2.0

- Process will always complete provided no issues with deployed platform.
- Review of generated report is now necessary

## 0.1.0

Initial release.  Proven to be functional but tuning may be required.

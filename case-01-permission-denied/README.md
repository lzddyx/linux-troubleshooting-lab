# Case 01 - Permission Denied

## Scenario

A deployment script (`deploy.sh`) could not be executed due to permission issues.

## Symptom

When running:

```bash
./deploy.sh
```

The terminal returned:

```text
Permission denied
```

The file existed, but Linux refused to execute it.

---

## Investigation

Checked the file permissions:

```bash
ls -l deploy.sh
```

Found:

```text
-rw-r--r--
```

Permission breakdown:

```text
r = read
w = write
x = execute
```

Current permissions:

```text
Owner:  rw-
Group:  r--
Others: r--
```

The file did not have execute permission (`x`).

---

## Root Cause

The script was missing execute permission.

Linux controls file execution through permission bits.  
A file cannot be executed without execute permission, even if it has a `.sh` extension.

---

## Fix

Added execute permission:

```bash
chmod +x deploy.sh
```

---

## Verification

Checked the permissions again:

```bash
ls -l deploy.sh
```

Result:

```text
-rwxr-xr-x
```

Executed the script:

```bash
./deploy.sh
```

Output:

```text
Deployment started
```

---

## What I Learned

- Linux file execution is controlled by permission bits.
- `ls -l` can be used to inspect file permissions.
- `chmod +x` adds execute permission to a file.
- Troubleshooting requires verification after applying a fix.

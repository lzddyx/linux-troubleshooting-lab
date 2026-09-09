# Case 08 - File Permission Misconfiguration

## Scenario

An application could start, but it could not read its configuration file because the file permissions were misconfigured.

The goal was to inspect the file permissions, identify the missing permission, apply the minimum required fix, and verify that the file became readable.

---

## Symptom

Attempting to read the configuration file:

```bash
cat config/app.conf
```

returned:

```text
Permission denied
```

---

## Investigation

Checked the file permissions:

```bash
ls -l config/app.conf
```

Output:

```text
----------  1 user staff 28 config/app.conf
```

Permission breakdown:

```text
Owner:  ---
Group:  ---
Others: ---
```

No user had read, write, or execute permission.

---

## Root Cause

The configuration file did not have read permission.

The application user owned the file, but the owner permission was:

```text
---
```

This prevented the file from being read.

---

## Fix

Added read permission only for the file owner:

```bash
chmod u+r config/app.conf
```

After the change:

```bash
ls -l config/app.conf
```

showed:

```text
-r--------
```

This granted the owner read permission without unnecessarily giving access to the group or other users.

---

## Verification

The configuration file was read again:

```bash
cat config/app.conf
```

Output:

```text
API_URL=https://example.com
```

The file was now readable.

---

## What I Learned

- `ls -l` is essential for diagnosing file permission problems.
- `r`, `w`, and `x` control read, write, and execute permissions.
- `u` in `chmod` refers to the file owner.
- `chmod u+r` adds read permission for the owner.
- Permission fixes should follow the principle of least privilege.
- Using overly broad permissions such as `chmod 777` is usually not an appropriate troubleshooting fix.

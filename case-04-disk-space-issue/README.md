# Case 04 - Disk Space Issue

## Scenario

An application was unable to continue writing logs because disk usage had increased unexpectedly.

The goal was to identify which directory and file were consuming excessive disk space and safely reclaim the space.

## Symptom

A typical production error may look like:

```text
No space left on device
```

Instead of immediately deleting files, I investigated disk usage step by step.

---

## Investigation

### 1. Check filesystem usage

Command:

```bash
df -h
```

This checks disk usage at the filesystem level.

The system still had sufficient free disk space, so I continued investigating the application directories.

---

### 2. Identify the largest directory

Command:

```bash
du -sh *
```

Output:

```text
4.0K    cache
4.0K    data
50M     logs
```

The `logs` directory was significantly larger than the others.

---

### 3. Identify the largest file

Command:

```bash
du -sh logs/*
```

Output:

```text
50M    logs/app.log
```

The abnormal disk usage was caused by `app.log`.

---

### 4. Confirm the file size

Command:

```bash
ls -lh logs/app.log
```

Output:

```text
-rw-r--r--  1 user staff 50M logs/app.log
```

---

### 5. Check whether the file was currently open

Command:

```bash
lsof logs/app.log
```

No process was using the file.

---

## Root Cause

The application log file had grown significantly and was consuming most of the space inside the test directory.

Large or uncontrolled log growth can eventually cause disk space problems in production systems.

---

## Fix

Instead of deleting the log file, I cleared its contents while keeping the file itself:

```bash
: > logs/app.log
```

This reduced the file size to zero while preserving the file.

---

## Verification

Checked the file size again:

```bash
ls -lh logs/app.log
```

Result:

```text
0B
```

Checked the log directory usage:

```bash
du -sh logs
```

The disk usage returned to a normal level.

---

## What I Learned

- `df -h` checks disk usage at the filesystem level.
- `du -sh *` helps identify which directory is consuming space.
- `du -sh directory/*` can locate large files inside a directory.
- `ls -lh` provides a readable file size.
- `lsof` helps determine whether a file is currently being used by a process.
- Large log files should be investigated before being deleted.
- Clearing a log file can preserve the file while reclaiming disk space.


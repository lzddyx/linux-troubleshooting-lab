# Case 03 - PATH Configuration Error

## Scenario

Multiple standard system commands suddenly stopped working after the PATH environment variable was incorrectly modified.

## Symptom

Running:

```bash
ls
```

Returned:

```text
zsh: command not found: ls
```

Running:

```bash
mkdir
```

also returned:

```text
zsh: command not found: mkdir
```

---

## Investigation

### 1. Test the command using an absolute path

Instead of running:

```bash
ls
```

I ran:

```bash
/bin/ls
```

The command executed successfully.

This confirmed that the `ls` program still existed and the system itself was not broken.

---

### 2. Check the PATH environment variable

Command:

```bash
echo $PATH
```

Output:

```text
/my-tools
```

The normal system command directories such as:

```text
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
```

were missing.

---

## Root Cause

The PATH environment variable had been overwritten.

An incorrect configuration such as:

```bash
export PATH=/my-tools
```

replaces the existing PATH instead of adding a new directory to it.

As a result, the shell could no longer find standard system commands such as `ls` and `mkdir`.

---

## Fix

Restored the system PATH:

```bash
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

---

## Verification

Checked the location of `ls`:

```bash
which ls
```

Output:

```text
/bin/ls
```

Checked the location of `mkdir`:

```bash
which mkdir
```

Output:

```text
/bin/mkdir
```

Checked PATH again:

```bash
echo $PATH
```

Output:

```text
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

The standard commands were available again.

---

## What I Learned

- Multiple `command not found` errors can indicate a PATH configuration problem.
- An absolute path can be used to determine whether a program still exists.
- `export PATH=/some/path` overwrites the existing PATH.
- `export PATH=$PATH:/some/path` preserves the existing PATH and adds a new directory.
- PATH problems should be verified by checking both command locations and the PATH value.

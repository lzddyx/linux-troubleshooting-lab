# Case 02 - Command Not Found

## Scenario

A custom command exists on the system, but the shell cannot find it when executed.

## Symptom

Running:

```bash
hello
```

Returns:

```text
zsh: command not found: hello
```

However, running the program directly works:

```bash
./my-tools/hello
```

Output:

```text
Hello from custom tool
```

This indicates that the program exists, but the shell cannot locate it.

---

## Investigation

### 1. Verify the program exists

Checked the program directly:

```bash
./my-tools/hello
```

The command executed successfully.

---

### 2. Check command location

Command:

```bash
which hello
```

Result:

```text
hello not found
```

The shell could not find the command through the current PATH.

---

### 3. Check PATH environment variable

Command:

```bash
echo $PATH
```

The current PATH did not contain:

```text
./my-tools
```

The shell only searches directories listed in PATH.

---

## Root Cause

The command location was not included in the PATH environment variable.

When a command is executed, the shell searches directories defined in PATH.

Because `my-tools` was missing from PATH, the shell returned:

```text
command not found
```

---

## Fix

Temporarily added the directory to PATH:

```bash
export PATH=$PATH:./my-tools
```

This added `./my-tools` to the existing PATH.

---

## Verification

Executed:

```bash
hello
```

Output:

```text
Hello from custom tool
```

The command was successfully found and executed.

---

## What I Learned

- The shell searches commands through PATH directories.
- `which` helps identify whether a command can be found.
- `$PATH` stores command search locations.
- `export` can modify environment variables temporarily.
- A command not found error does not always mean the program is not installed.

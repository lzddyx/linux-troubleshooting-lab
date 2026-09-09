# Case 07 - Log Error Investigation

## Scenario

An application failed to start.

The visible error only indicated that startup had failed, so the goal was to inspect the logs, identify the real root cause, trace it to the system level, fix the issue, and verify recovery.

---

## Symptom

The application reported:

```text
Application startup failed
```

The exact cause was not immediately visible.

---

## Investigation

### 1. Confirm the log file exists

Command:

```bash
ls -lh logs
```

This confirmed that `app.log` existed.

---

### 2. Inspect the latest log entries

Command:

```bash
tail logs/app.log
```

The latest entries included warnings and errors related to application startup.

---

### 3. Filter error messages

Command:

```bash
grep "ERROR" logs/app.log
```

Output:

```text
2026-09-09 10:00:08 ERROR Failed to bind to port 8080: Address already in use
2026-09-09 10:00:10 ERROR Application startup failed
```

The second error described the final result, while the first error explained the actual cause.

---

## Root Cause

The application could not bind to port `8080` because another process was already using it.

The key log entry was:

```text
Failed to bind to port 8080: Address already in use
```

---

## System-Level Investigation

Checked which process was using port 8080:

```bash
lsof -i :8080
```

Example output:

```text
COMMAND   PID    USER   NAME
Python    65621  user   TCP *:http-alt (LISTEN)
```

Then inspected the process:

```bash
ps -p 65621 -o pid,ppid,command
```

This confirmed that a Python HTTP server was listening on port 8080.

---

## Fix

Stopped the process using the occupied port:

```bash
kill 65621
```

This sent the default `SIGTERM` signal.

---

## Verification

Checked the port again:

```bash
lsof -i :8080
```

No process was listening on port 8080.

Checked the process:

```bash
ps -p 65621
```

The process was no longer running.

---

## What I Learned

- `tail` is useful for checking the most recent log entries.
- `grep` can quickly filter relevant error messages.
- The final error message is not always the root cause.
- Logs should be used as evidence to guide deeper system investigation.
- `lsof -i :PORT` can identify which process is listening on a port.
- `ps` can be used to inspect the process behind the error.
- A troubleshooting process should continue from application logs to system-level evidence when necessary.
- Every fix should be followed by verification.

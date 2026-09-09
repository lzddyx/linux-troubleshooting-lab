# Case 06 - Process Cannot Be Terminated

## Scenario

A running process did not terminate after receiving a normal `kill` command.

The goal was to determine why the process ignored the termination request, escalate the signal safely, and verify that the process was actually stopped.

---

## Symptom

A background process was started:

```bash
./setup.sh &
```

The script saved its process ID to:

```text
stubborn.pid
```

The process could be confirmed with:

```bash
ps -p $(cat stubborn.pid) -o pid,ppid,state,etime,command
```

---

## Investigation

### 1. Confirm the process is running

Command:

```bash
ps -p $(cat stubborn.pid) -o pid,ppid,state,etime,command
```

Example output:

```text
PID    PPID   STAT   ELAPSED   COMMAND
61807  37514  SN     00:23     /bin/bash ./setup.sh
```

---

### 2. Attempt normal termination

Command:

```bash
kill 61807
```

By default, `kill` sends the `SIGTERM` signal.

Afterwards, the process was checked again:

```bash
ps -p 61807 -o pid,state,etime,command
```

The process was still running.

---

## Root Cause

The test process was configured to ignore `SIGTERM`.

The setup script contained:

```bash
trap '' TERM
```

This caused the process to ignore normal termination requests.

---

## Fix

Since `SIGTERM` did not stop the process, the stronger `SIGKILL` signal was used:

```bash
kill -9 61807
```

`SIGKILL` cannot be caught or ignored by the target process.

---

## Verification

The process was checked again:

```bash
ps -p 61807 -o pid,state,etime,command
```

Only the header remained and the process was no longer present.

---

## What I Learned

- `kill PID` sends `SIGTERM` by default.
- `SIGTERM` allows a process to shut down gracefully.
- A process can catch or ignore `SIGTERM`.
- `kill -9 PID` sends `SIGKILL`.
- `SIGKILL` cannot be ignored by the process.
- `SIGKILL` should not be the first troubleshooting step.
- Process termination should always be verified with `ps` or another monitoring tool.

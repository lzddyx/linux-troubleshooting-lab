# Case 05 - High CPU Process

## Scenario

A server became slow because one process was consuming nearly 100% CPU.

The goal was to identify the abnormal process, confirm its CPU usage, terminate it safely, and verify that the system returned to normal.

---

## Symptom

A test process was started in the background:

```bash
./setup.sh &
```

The system became noticeably busier.

---

## Investigation

### 1. Identify running processes

Command:

```bash
ps
```

A suspicious process appeared:

```text
/bin/bash ./setup.sh
```

---

### 2. Check CPU usage for the suspicious process

Command:

```bash
ps -p <PID> -o pid,ppid,%cpu,%mem,etime,command
```

Example result:

```text
PID    PPID   %CPU   %MEM   ELAPSED   COMMAND
56322  37514  99.0   0.0    00:57     /bin/bash ./setup.sh
```

The process was using approximately 99% CPU.

---

### 3. Verify CPU usage in real time

Command:

```bash
top -pid <PID>
```

The process continued using close to 100% CPU.

---

## Root Cause

The test script contained an infinite loop:

```bash
while true
do
  :
done
```

This caused the shell process to continuously consume CPU resources.

---

## Fix

Attempted a normal process termination first:

```bash
kill <PID>
```

This sends the default `SIGTERM` signal and allows the process to exit normally.

---

## Verification

Checked whether the process still existed:

```bash
ps -p <PID>
```

No process was returned.

Then checked system activity again using:

```bash
top
```

The high CPU test process was no longer running.

---

## What I Learned

- `ps` can be used to identify suspicious processes.
- PID is the unique identifier for a running process.
- `%CPU` helps determine whether a process is consuming excessive CPU.
- `top` provides real-time process and CPU information.
- `kill` sends `SIGTERM` by default.
- A process should be verified after termination instead of assuming it stopped.
- `kill -9` should not be the first troubleshooting step unless normal termination fails.

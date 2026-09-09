# Case 10 - Environment Variable Issue

## Scenario

An application could execute successfully, but startup failed because a required environment variable was missing.

The goal was to verify whether the variable existed, identify the root cause, set the missing variable, and confirm that the application could start.

---

## Symptom

Running:

```bash
./app.sh
```

returned:

```text
ERROR: API_KEY environment variable is missing.
```

---

## Investigation

### 1. Check the variable directly

Command:

```bash
echo $API_KEY
```

No value was returned.

---

### 2. Check the environment

Command:

```bash
env | grep API_KEY
```

No matching environment variable was found.

---

## Root Cause

The application required an environment variable named `API_KEY`, but the variable had not been defined in the current shell environment.

---

## Fix

Temporarily set and exported the variable:

```bash
export API_KEY="test-key-123"
```

---

## Verification

Checked the variable:

```bash
echo $API_KEY
```

Output:

```text
test-key-123
```

Then ran the application again:

```bash
./app.sh
```

Output:

```text
Application started successfully.
API_KEY is configured.
```

---

## What I Learned

- Applications often depend on environment variables for runtime configuration.
- `echo $VARIABLE` can be used to inspect a shell variable.
- `env | grep VARIABLE` helps confirm whether a variable is exported into the environment.
- `export` makes a variable available to child processes.
- Environment variables set with `export` are temporary unless added to a shell configuration or deployment environment.
- Missing configuration can cause application failures even when the application and dependencies are otherwise correct.
